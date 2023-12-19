int sum_array( int arr[], int num )
{
    int sum = 0;
    for( int i = 0; i < num; i++ ) {
        sum += arr[i];
    }
    return sum;
}
