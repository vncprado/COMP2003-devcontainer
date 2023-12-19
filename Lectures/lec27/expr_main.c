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
