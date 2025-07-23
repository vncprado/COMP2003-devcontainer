/*
gcc -c -O rsum0_n.c    		
arm-linux-gnueabi-gcc -march=armv4 -O -S rsum0_n.c
cat rsum0_n.s
*/

int rsum( int n ) {
    if ( n == 0 ) return 0;
    return n + rsum( n-1 );
}
