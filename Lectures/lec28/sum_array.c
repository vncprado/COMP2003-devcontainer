int sum_array( int arr[], int num )
{
    int sum = 0;
    while( --num >= 0 ) {
        sum += arr[num];
    }
    return sum;
}
