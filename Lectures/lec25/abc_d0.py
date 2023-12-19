def a() :
    print('start a')
    b()
    print('end a')

def b() :
    print('start b')
    c()
    print('end b')

def c() :
    return 1 // 0;
    print('start/end c')

a()
