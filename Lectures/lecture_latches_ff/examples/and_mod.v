/* declare a module called and_gate */
module and_gate(output logic y, input logic a, b); // three connection 
    // a and b are inputs, only connected to inputs of gates
    // x is an output, must be connected to an output in this module

    // and is the function
    // #2 is the delay from input to output
    // g1 is the name of the gate
    // both delay and gate's name are optional
    or #2 g1(y, a, b);
    // y is the output, a, b are inputs
endmodule
