import static java.lang.System.out;

public class Single {
    public static void main( String args[] ) {

        byte v;   // a 8 bit signed integer
        v = 0 & 0; out.printf("0 & 0 = %x\n", v );
        v = 0 & 1; out.printf("0 & 1 = %x\n", v );
        v = 1 & 0; out.printf("1 & 0 = %x\n", v );
        v = 1 & 1; out.printf("1 & 1 = %x\n", v );

        v = 0 | 0; out.printf("0 | 0 = %x\n", v );
        v = 0 | 1; out.printf("0 | 1 = %x\n", v );
        v = 1 | 0; out.printf("1 | 0 = %x\n", v );
        v = 1 | 1; out.printf("1 | 1 = %x\n", v );

        v = 0 ^ 0; out.printf("0 ^ 0 = %x\n", v );
        v = 0 ^ 1; out.printf("0 ^ 1 = %x\n", v );
        v = 1 ^ 0; out.printf("1 ^ 0 = %x\n", v );
        v = 1 ^ 1; out.printf("1 ^ 1 = %x\n", v );

        // ~ works on all the bits
        v = ~0; out.printf("~0 = %x\n", v );
        v = ~1; out.printf("~1 = %x\n", v );
    }
}
