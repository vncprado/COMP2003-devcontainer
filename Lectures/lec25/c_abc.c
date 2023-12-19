#include <stdint.h>
#include <stdio.h>

// declare b and c
void b( void );
void c( void );

void a( void ) 
{
    printf("start a\n");
    b();
    printf("end a\n");
}

void b( void ) 
{
    printf("start b\n");
    c();
    printf("end b\n");
}

void c( void ) 
{
int x = 1 / 0;
    printf("start/end\n");
}

int
main( int ac, char *av[] )
{
    a();
    return 0;
}
