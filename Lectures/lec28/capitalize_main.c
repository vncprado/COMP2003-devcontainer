#include <stdio.h>

extern void capitalize(char *dest, char *src);

int main()
{
    char *src = "Hello There";
    char dest[20];

    capitalize( dest, src );
    printf("src = %s dest = %s\n", src, dest );
}
