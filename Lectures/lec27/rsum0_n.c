int rsum( int n ) {
    if ( n == 0 ) return 0;
    return n + rsum( n-1 );
}
