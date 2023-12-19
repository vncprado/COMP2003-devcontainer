#include <stdio.h>

extern int ifelse(int a, int b );

int main() 
{
    int r;

    r = ifelse( 1, 2);
    printf("ifelse( 1, 2) = %d\n", r );

    r = ifelse( 54, 30);
    printf("ifelse( 54, 30) = %d\n", r );
    return 0;
}
