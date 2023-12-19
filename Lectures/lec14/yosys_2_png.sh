# THIS IS NOT FINISHED
# YOU CAN USE THE YOSYS COMMANDS
#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Illegal number of parameters"
    echo "use: input_file top_module_name"
    exit 0;
fi

read_verilog -sv mod3_12_v6.v
hierarchy -top mod3_12
write_ilang
proc; opt
show -format png -prefix mod3_12_v6

