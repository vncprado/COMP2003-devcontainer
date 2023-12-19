#!/usr/bin/env bash
# set DIR to the directory containing the command
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

PY=${DIR}/utils/arm_emu.py
LD=${DIR}/utils/arm.ld

read -r -d '' start <<'EOF'
    .arch armv4
    .text
    .align  2
    .global start
start:
    bl      main
    svc     999        // stop the emulation
    .size   start, .-start
EOF

function usage {
    echo "usage: arm_emu [-t] [-S] [-n count] [-R r v]... files..."
    exit 1
}

if (( $# == 0 )) ; then
    usage
fi

save_generate=0
# parse and check arguments
opts=''
while (( $# > 0 )); do
    if [[ "$1" = "-n" ]]; then
        opts="$opts $1"
        shift
        if (( $# > 0 )); then
            opts="$opts $1"
            if [[ ! "$1" =~ [0-9]+ ]]; then
                echo "-n requires an integer argument not $1"
                usage
            fi
            shift
        else
            echo "-n requires an argument"
            usage
        fi
    elif [[ "$1" = "-R" ]]; then
        opts="$opts $1"
        shift
        if (( $# > 1 )); then
            opts="$opts $1 $2"
            if [[ ! "$1" =~ [0-9]+ ]]; then
                echo "-R requires integer arguments not $1"
                usage
            fi
            if [[ ! "$2" =~ [0-9]+ ]]; then
                echo "-R requires integer arguments not $2"
                usage
            fi
            shift
            shift
        else
            echo "-R requires two argument"
            usage
        fi
    elif [[ "$1" = "-S" ]]; then
        save_generate=1
        shift
    elif [[ "$1" = "-t" ]]; then
        opts="$opts $1"
        shift
    else
        break
    fi
done

if (( $# == 0 )); then
    echo "missing files"
    usage
fi

# last file is the target name
files=''
target=''
for f in "$@"; do
    if [ ! -e "$f" ]; then
        echo $f is not a file
        usage
    fi
    if [[ ! "$f" =~ \.s$ && ! "$f" =~ \.S$ ]]; then
        echo $f does not end with .s or .S
        usage
    fi
    files="$files $f"
    # use last file as target
    target=$(echo "$f" | sed -e 's/\.[sS]$//')
done

target_base=${target%.s}
elf=${target_base}.elf

as=arm-linux-gnueabi-as
$as -g -c <(echo "$start") -o start.o

# invoke the assembler
objs='start.o'
for src in $files; do
    obj=$(echo "$src" | sed -e 's/\.[sS]$/.o/')
    if ! $as -g $src -o $obj; then
        echo "assembler did not finish $src"
        exit 1
    fi
    objs="$objs $obj"
done

# invoke the linker
if ! arm-linux-gnueabi-ld -T$LD $objs -o $elf; then
    echo "linker did not finish"
    exit 1
fi

# the following are here for documentation
# arm-linux-gnueabi-objdump -S $elf
# arm-linux-gnueabi-objcopy -j .text -j .data -O ihex $elf $hex

. ${DIR}/py3/bin/activate
#. ./py3/bin/activate

# invoke the simulator
python3 $PY $opts $elf

# cleanup the generated files
if (( $save_generate == 0 )); then
    rm -f $objs $elf
fi

exit 0
