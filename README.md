COMP2003 repository and devcontainer
====================================

This repository contains examples seen in class and a devcontainer configuration files that contain all required sofware to run the examples.
For more informations on how to use the devcontainer, please read the software tools pdf in the course material.

The examples can be found in the `Lectures` folder and follows the course slides.
Assembly examples are organized in the `assembly-examples` folder.
Read the `assembly-examples/README.md` for instructions on how to run the `arm_emu.sh`. 

Please let the instructor know if you find any bugs in the devcontainer configuration or in the examples.

Verilog example:

    $ cd Lectures/lec10
    $ iverilog -g2012 and_gate.v and_gate_tb.v 
    $ ./a.out

After running, in addition to the terminal output, some testbenches already create a dumpfile (e.g.,  `and_gate.vcd`). You can open that using the WaveTrace extension (already installed in the vscode dev container).

Assembly example, assembling add.s:

    $ cd Lectures/assembly-examples/
    $ arm-linux-gnueabi-as -al add.s

Executing add.s with qemu-arm:

    $ arm-linux-gnueabi-gcc --static add.s
    $ qemu-arm ./a.out ; echo $?

Assembly example, arm trace:

    $ ./arm_emu.sh add.s