ARM trace script
================

The script arm_emu.sh can be used by the students to trace the assembly code examples.

This tool was tested on Ubuntu 20.04 but may work in other distribuitions.
The script needs the following software to be installed:

* arm-linux-gnueabi-as
* arm-linux-gnueabi-ld

You can then trace any assembly code example with:

    $ ./arm_emu.sh add.s

DEPRECATED:

To run the examples. You have to create a python env in this folder:

    $ python3 -m venv py3
    $ . ./py3/bin/activate
    $ pip install -r requirements.txt
    $ deactivate