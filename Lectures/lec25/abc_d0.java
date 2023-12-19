import static java.lang.System.out;

public class abc_d0 {
    public static void a() {
        out.println("start a");
        b();
        out.println("end a");
    }

    public static void b() {
        out.println("start b");
        c();
        out.println("end b");
    }

    public static void c() {
        int x = 1 / 0;
        out.println("start/end c");
    }

    public static void main(String[] av){
        a();
    }
}
