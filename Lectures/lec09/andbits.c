#include <stdio.h>
#include <stdint.h>
#include <stdlib.h>

void print_binary( uint8_t b )
{
     for( int i=0; i < 8; i++ ) {
         if ( (b & 0b10000000)  != 0 ) {
             putchar('1');
         }
         else {
             putchar('0');
         }
         b = b << 1;
     }
}

int main(int ac, char *av[] )
{
    if ( ac != 3 ) {
        printf("./andbits v1 v2\n");
        return 1;
    }
    uint8_t a = (uint8_t)strtol( av[1], NULL, 2 );
    uint8_t b = (uint8_t)strtol( av[2], NULL, 2 );

    print_binary( a );
    printf(" & ");
    print_binary( b );
    printf(" = ");
    print_binary( a & b );
    putchar('\n');

    return 0;
}
