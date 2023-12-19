#include <stdio.h>

extern int dot_product( int a[], int b[], int sz );

int main()
{
    int a1[] = { 4, 2, 5};
    int b1[] = { -1, 2, 3};
    int r = dot_product( a1, b1, 3);
    printf("dot is %d\n", r );
    return 0;
}
