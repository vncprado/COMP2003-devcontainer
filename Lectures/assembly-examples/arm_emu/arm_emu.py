#!usr/bin/env python

import sys
import argparse
import capstone
import unicorn
from unicorn import ( UC_HOOK_CODE, UC_HOOK_MEM_READ, UC_HOOK_MEM_WRITE, 
        UC_HOOK_INTR, UC_ARCH_ARM, UC_MODE_ARM, UcError, UC_MEM_WRITE, 
        UC_MEM_READ )

from unicorn.arm_const import *
from elftools.elf.elffile import ELFFile
import struct

def dump_nzcv( nzcv ) :
    codes = nzcv >> 28
    r = ''
    r += 'N' if codes & 0x8 else '-'
    r += 'Z' if codes & 0x4 else '-'
    r += 'C' if codes & 0x2 else '-'
    r += 'V' if codes & 0x1 else '-'
    return r

def hook_intr(uc, intno, user_data):
    if intno == 2 :
        prev_pc = uc.reg_read(UC_ARM_REG_PC) - 4
        prev_ins =  uc.mem_read(prev_pc, 4) 
        # ARM svc encoding
        svc = struct.unpack("<L", prev_ins )[0] & 0xFFFFFF
        if svc == 0 :
            dump_regs( uc )
            return
        elif svc == 1 :
            start = uc.reg_read(UC_ARM_REG_R0)
            count = uc.reg_read(UC_ARM_REG_R1)
            dump_memory( uc, start, count, 8 )
            return
        elif svc == 2 :
            start = uc.reg_read(UC_ARM_REG_R0)
            count = uc.reg_read(UC_ARM_REG_R1)
            dump_memory( uc, start, count, 4 )
            return
        elif svc == 3 :
            start = uc.reg_read(UC_ARM_REG_R0)
            count = uc.reg_read(UC_ARM_REG_R1)
            dump_memory( uc, start, count, 2 )
            return
        elif svc == 4 :
            start = uc.reg_read(UC_ARM_REG_R0)
            count = uc.reg_read(UC_ARM_REG_R1)
            dump_memory( uc, start, count, 1 )
            return
        elif svc == 5 :
            start = uc.reg_read(UC_ARM_REG_R0)
            dump_string( uc, start )
            return
        elif svc == 6 :
            start = uc.reg_read(UC_ARM_REG_R0)
            count = uc.reg_read(UC_ARM_REG_R1)
            dump_memory( uc, start, count )
            return
    uc.emu_stop()

def dump_string(uc, start ) :
    s = ''
    addr = start
    while True:
        ch = uc.mem_read(addr, 1)[0]
        if ch == 0 :
            break
        addr += 1
        s += chr(ch)
    print( s, end='')

def unpack( buf ):
    l = len(buf)
    res = None
    if l == 8 :
        res = struct.unpack('<Q', buf)[0]
    elif l == 4 :
        res = struct.unpack('<I', buf)[0]
    elif l == 2 :
        res = struct.unpack('<H', buf)[0]
    elif l == 1 :
        res = struct.unpack('<B', buf)[0]
    return res

def dump_memory(uc, start, count, incr) :
    print('-'*64)
    print('Memory from %08x (%d)' % (start, count) )
    for addr in range(start, incr*count+start, incr) :
        mem_word = uc.mem_read(addr, incr)
        if incr == 8 :
            word = struct.unpack('<Q', mem_word)[0]
            print( "%08x: %016x" % (addr, word) )
        elif incr == 4 :
            word = struct.unpack('<I', mem_word)[0]
            print( "%08x: %08x" % (addr, word) )
        elif incr == 2 :
            word = struct.unpack('<H', mem_word)[0]
            print( "%08x: %04x" % (addr, word) )
        elif incr == 1 :
            word = struct.unpack('<B', mem_word)[0]
            print( "%08x: %02x" % (addr, word) )
        else :
            print("bad increment")
    print('-'*64)

def write_regs(uc, regs) :
    for r,v in regs :
        if 0 <= r <= 12 :
            uc.reg_write(UC_ARM_REG_R0+r, v)
        elif r == 13 :
            uc.reg_write(UC_ARM_REG_SP, v)
        elif r == 14 :
            uc.reg_write(UC_ARM_REG_LR, v)
        elif r == 15 :
            uc.reg_write(UC_ARM_REG_PC, v)

def get_cur_regs( uc ) :
        regs = [uc.reg_read(r) for r in range(UC_ARM_REG_R0,UC_ARM_REG_R12+1)]
        regs += [
            uc.reg_read(UC_ARM_REG_SP),
            uc.reg_read(UC_ARM_REG_LR),
            uc.reg_read(UC_ARM_REG_PC)  
        ]
        return regs

def dump_regs( uc ) :
    regs = get_cur_regs(uc)
    print( "Register Set".center(64,' ') )
    for i in range(0,16) : 
        print( "R%-2d: %08x" % (i, regs[i]),  end="")
        if (i+1)%4 == 0 : print() 
        else : print(' ',end='')
    print()
        

def print_trace(uc, user_data) :
    if not user_data['trace'] :
        return
    if user_data['last_code'] is None:
        return
    raw_inst = user_data['last_code']
    ir = struct.unpack('<I', raw_inst)[0]
    address = user_data['last_addr']
    size = user_data['last_size']
    decoder = user_data[ 'decoder' ]
    # XXX should only be one instruction
    insns = list( decoder.disasm(raw_inst, address) )
    if len( insns ) >= 1 :
        insn = insns[0]
        print("%08x: " % insn.address, end='')
        if user_data['encoding'] :
            print("%08x " % ir, end='' )
        print("%-6s %-17s" % (insn.mnemonic, insn.op_str), end='')
    cur_nzcv = uc.reg_read( UC_ARM_REG_CPSR )
    print( 'CC:', dump_nzcv( cur_nzcv ), end='' )
    cur_regs = get_cur_regs( uc )
    prev_regs = user_data['regs']
    # display only registers that have changed
    for i,(cr,pr) in enumerate( zip(cur_regs,prev_regs) ) :
        if cr != pr and i != 15:
            print( " R%-2d: %08x" % (i,cr), end='' )
    print()
    for m in user_data['mem_access'] :
        if m[0] == 'W' :
            print(f'    M[{m[1]:x}] = {m[3]:x} # {m[2]*8} bits')
        elif m[0] == 'R' :
            v = unpack( m[3] )
            print(f'    M[{m[1]:x}] is {v:x} # {m[2]*8} bits')
        else :
            print( '    ', m )
    user_data['mem_access'] = []

# callback for tracing instructions, called before the instruction
# is executed
def hook_code(uc, address, size, user_data):
    print_trace( uc, user_data)

    user_data['last_code'] = uc.mem_read(address,size)
    user_data['last_addr'] = address
    user_data['last_size'] = size
    user_data['regs'] = get_cur_regs( uc )

# prints before
def hook_mem_access(uc, access, address, size, value, user_data):
    if not user_data['trace'] :
        return
    if access == UC_MEM_WRITE:
        user_data['mem_access'].append( ('W', address, size, value) )
    elif access == UC_MEM_READ:
        mem = uc.mem_read(address,size)
        user_data['mem_access'].append( ('R', address, size, mem) )

def load_text_data( emu, elf_file ) :
    # XXX handle different sizes
    pgm_start = None
    code_end = None
    with  open(elf_file,'rb') as f :
        elf_file = ELFFile(f)
        # get start and end of text segment from symbols
        sym = elf_file.get_section_by_name('.symtab')
        stext = sym.get_symbol_by_name('_stext')
        if stext :
            pgm_start = stext[0].entry.st_value
        start = sym.get_symbol_by_name('start')
        if start :
            pgm_start = start[0].entry.st_value
        etext = sym.get_symbol_by_name('_etext')
        if etext :
            code_end = etext[0].entry.st_value
        main_loc = sym.get_symbol_by_name('main')
        if main_loc :
            main_loc = main_loc[0].entry.st_value

        # get text, data, bss section information
        sect_text = elf_file.get_section_by_name('.text')
        text_data = sect_text.data()
        text_start = sect_text.header['sh_addr']
        text_size = sect_text.header['sh_size']
        if pgm_start is None :
            pgm_start = text_start

        sect_rodata = elf_file.get_section_by_name('.rodata')
        rodata_data = sect_rodata.data()
        rodata_start = sect_rodata.header['sh_addr']
        rodata_size = sect_rodata.header['sh_size']

        sect_data = elf_file.get_section_by_name('.data')
        data_data = sect_data.data()
        data_start = sect_data.header['sh_addr']
        data_size = sect_data.header['sh_size']

        sect_bss = elf_file.get_section_by_name('.bss')
        bss_data = sect_data.data()
        bss_start = sect_data.header['sh_addr']
        bss_size = sect_data.header['sh_size']

        # ASSUMES .text, .data, and .bss are contiguous XXX
        last_addr = max(text_start+text_size,
            rodata_start+rodata_size,
            data_start+data_size,
            bss_start+bss_size)
        page_size = 0x40000
        # round up to page_size
        mem_size = ((last_addr+page_size)//page_size) * page_size
        ## XXX need to reexaming first address
        emu.mem_map(0, mem_size)

        # load .text section
        emu.mem_write(text_start, text_data )
        if code_end is None :
            code_end = text_size + text_start
        # load .rodata section
        emu.mem_write(rodata_start, rodata_data )
        # load .data section
        emu.mem_write(data_start, data_data )
        # load .bss section XXX
        emu.mem_write(bss_start, bss_data )
    return (pgm_start, text_start, code_end, mem_size, main_loc)

def arm_emulate( elf_file, regs, num_insts, trace_flag ):
    try:
        # initialize emulator in ARM mode
        emu = unicorn.Uc(UC_ARCH_ARM, UC_MODE_ARM)
        pgm_start, code_start, code_end, mem_size, main_loc = \
            load_text_data(emu, elf_file)

        # initialize machine registers
        emu.reg_write(UC_ARM_REG_CPSR, 0x0)
        write_regs(emu, regs )
        #emu.reg_write(UC_ARM_REG_APSR, 0xFFFFFFFF)
        emu.reg_write(UC_ARM_REG_PC, code_start)
        # set stack to end of memory
        emu.reg_write(UC_ARM_REG_SP, mem_size )

        emu_state = {}
        emu_state[ 'decoder' ] = \
            capstone.Cs(capstone.CS_ARCH_ARM, capstone.CS_MODE_ARM)
        emu_state[ 'regs' ] = get_cur_regs( emu )
        emu_state[ 'nczv' ] = emu.reg_read( UC_ARM_REG_CPSR )
        emu_state[ 'trace' ] = trace_flag
        emu_state[ 'encoding' ] = True
        emu_state[ 'last_code' ] = None
        emu_state[ 'last_addr' ] = None
        emu_state[ 'last_size' ] = None
        emu_state[ 'mem_access' ] = [] 
        # tracing all instructions with customized callback
        emu.hook_add(UC_HOOK_CODE,
                hook_code, begin=code_start, end=code_end, user_data=emu_state)
        emu.hook_add(UC_HOOK_MEM_READ|UC_HOOK_MEM_WRITE, hook_mem_access, user_data=emu_state)
        emu.hook_add(UC_HOOK_INTR, hook_intr)

        dump_regs( emu )

        # stop when pc is code_end, or count instructions executed
        emu.emu_start( pgm_start, code_end, count=num_insts )

        print( "Tracing over" )

    except UcError as e:
        print("ERROR: %s" % e)

if __name__ == '__main__':
    ap = argparse.ArgumentParser(description='ARM Emulator')
    ap.add_argument('-t', dest='trace', action='store_false',
        help='disable display of tracing' )
    ap.set_defaults(trace=True)
    ap.add_argument('elf_file', type=str, help='elf file to emulate' )
    ap.add_argument('-R', nargs=2, action='append',
        help='-R r v (sets registor r to v)' )
    ap.add_argument('-n', type=int, nargs=1, 
        default=2000, help='Maximum number of instructions')

    args = ap.parse_args()
    trace_flag =  args.trace
    if type(args.n) == int : 
        num_insts = args.n
    elif len(args.n) > 0 :
        num_insts = args.n[0]
    else:
        num_insts = 2000
    if num_insts < 1 :
        num_insts = 1

    regs = []
    if args.R is not None :
        for r,v in args.R :
            try : 
                r = int(r)
                if r < 0 or r > 14 :
                    print('bad register: ', r )
                    sys.exit( 1 )
                v = int(v,0) # parse prefix
            except ValueError:
                print( 'bad args: %s %s' % (str(r), str(v)) )
                sys.exit( 1 )
            regs.append( (r,v) )

    arm_emulate( args.elf_file, regs, num_insts, trace_flag )
