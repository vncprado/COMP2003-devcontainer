/*
gcc -c -O main_rsum0_n.c 
gcc --static rsum0_n.o main_rsum0_n.o  
*/

#include <stdio.h>

// define the external function
int rsum(int n);

int main(int ac, char *av[] )
{
    printf("sum is %d\n", rsum(4) );
    return 0;
}

