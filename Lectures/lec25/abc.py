def a() :
    print('start a')
    b()
    print('end a')

def b() :
    print('start b')
    c()
    print('end b')

def c() :
    print('start/end c')

if __name__ == "__main__":
    a()


