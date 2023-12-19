#include <stdio.h>

extern int sum_array( int arr[], int num );

int main()
{
    int test[5] = {2,5,8,3,10};

    int r = sum_array( test, 5 );
    printf("sum is %d\n", r );

    r = sum_array( test, 3 );
    printf("sum is %d\n", r );
    return 0;
}
