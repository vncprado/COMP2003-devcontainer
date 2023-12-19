def print_8bits( v ) :
    b = ''.join( '1' if v & 1<<m else '0' for m in range(7,-1,-1) )
