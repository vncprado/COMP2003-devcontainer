typedef enum logic [1:0] {
    AS_ADD,
    AS_SUB,
    AS_A,
    AS_B
} as_ctl_t;

typedef enum logic [1:0] {
    SH_PASS,
    SH_LEFT,
    SH_ONE,
    SH_ONES
} shift_ctl_t;

typedef logic [15:0] reg16_t;
