/*
The C and assembler files are combined and tested with:
        arm-linux-gnueabi-gcc --static expr_main.c r_expr.S 
        qemu-arm ./a.out
The assembly code for the C program can be generate and shown with:
	arm-linux-gnueabi-gcc -march=armv4 -Os -S expr_main.c
	cat expr_main.s
*/


#include <stdio.h>

// extern int r_expr(int a, int b, int c, int d);
extern int r_expr(int, int, int, int);

int main() {
    int r;

    r = r_expr(2, 1, 4, 1);
    printf("r_expr(2, 1, 4, 1) = %d\n", r );

    r = r_expr( 14, 3, 22, 10);
    printf("r_expr(14, 3, 22, 10) = %d\n", r );

    return 0;
}
