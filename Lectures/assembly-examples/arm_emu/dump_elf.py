from elftools.elf.elffile import ELFFile
elf_file = 'tst.elf'
elf_file = ELFFile( open(elf_file,'rb') )
sect_text = elf_file.get_section_by_name('.text')
text_data = sect_text.data()
print( ' '.join( "%02x" % d for d in text_data) )
print(sect_text.header['sh_size'])
print(sect_text.header['sh_addr'])

sect_data = elf_file.get_section_by_name('.data')
data_data = sect_data.data()
print( ' '.join( "%02x" % d for d in data_data) )
print(sect_data.header['sh_size'])
print(sect_data.header['sh_addr'])
