/*

gcc -Wall -O --static recur_sum.c
 ./a.out
*/

#include <stdio.h>

static int rsum( int n ) {
    printf("start level %d\n", n );
    if ( n == 0 ) return 0;
    int v =  n + rsum( n-1 );
    printf("end level %d\n", n );
    return v;
}

int main(int ac, char *av[] ) {
    printf("sum is %d\n", rsum(4) );
    return 0;
}

