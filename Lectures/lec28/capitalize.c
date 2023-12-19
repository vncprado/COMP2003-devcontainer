
void capitalize(char *dest, char *src)
{
    int i = 0;
    while ( 1 ) {
        char ch = src[i];
        if ( ch == '\0' ) break;
        if ( ch >= 'a' && ch <= 'z' ) {
            ch &= ~0x20;
        }
        dest[i] = ch;
        i++;
    }
    dest[i] = '\0';
}
