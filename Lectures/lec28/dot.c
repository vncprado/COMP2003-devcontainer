int dot_product( int a[], int b[], int sz )
{
    int s = 0;
    for( int i = 0; i < sz; i++ ) {
        s += a[i] * b[i];
    }
    return s;
}
