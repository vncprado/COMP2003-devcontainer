#include <stdio.h>

extern int count_bits(int bits );

int main() {
    int r;

    r = count_bits( 4 );
    printf("count_bits( 4 ) = %d\n", r );

    r = count_bits( 6 );
    printf("count_bits( 6 ) = %d\n", r );

    r = count_bits( -1 );
    printf("count_bits( -1 ) = %d\n", r );

    r = count_bits( 0xabcd );
    printf("count_bits( 0xabcd ) = %d\n", r );

    r = count_bits( 0b110110101 );
    printf("count_bits( 0b110110101 ) = %d\n", r );

    r = count_bits( 0b1 );
    printf("count_bits( 0b1 ) = %d\n", r );

    r = count_bits( 0 );
    printf("count_bits( 0 ) = %d\n", r );

    return 0;
}
