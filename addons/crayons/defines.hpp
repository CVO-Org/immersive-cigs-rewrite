#define SUCKS_TOTAL 1800

#define CRAYON(COLOR) QGVAR(crayon_##COLOR)
#define CRAYON_NV(COLOR) QGVAR(crayon_##COLOR##_NV)

#define CRAYONS CRAYON(black), CRAYON(blue), CRAYON(brown), CRAYON(gray), CRAYON(green), CRAYON(orange), CRAYON(pink), CRAYON(purple), CRAYON(red), CRAYON(white), CRAYON(yellow)
#define CRAYONS_NV CRAYON_NV(black), CRAYON_NV(blue), CRAYON_NV(brown), CRAYON_NV(gray), CRAYON_NV(green), CRAYON_NV(orange), CRAYON_NV(pink), CRAYON_NV(purple), CRAYON_NV(red), CRAYON_NV(white), CRAYON_NV(yellow)
