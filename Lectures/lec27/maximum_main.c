#include <stdio.h>

extern int maximum(int a, int b, int c, int d );

int main() {
    int r;

    r = maximum( 1, 2, 3, 4);
    printf("maximum( 1, 2, 3, 4) = %d\n", r );

    r = maximum( 14, 30, 22, 10);
    printf("maximum( 14, 30, 22, 10) = %d\n", r );
    return 0;
}
