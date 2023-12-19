#include <stdio.h>

extern void init_seq( int arr[], int sz); // no return value

int main()
{
    int array[8];

    init_seq( array, 8 );

    // print out sequence
    for(int i = 0 ; i < 8; i++ ) {
        printf("%d ", array[i] );
    }
    printf("\n");
    return 0;
}
