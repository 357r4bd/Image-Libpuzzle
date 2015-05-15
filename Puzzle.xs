#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "puzzle.h"

#include "ppport.h"


MODULE = Puzzle		PACKAGE = Puzzle	PREFIX = puzzle_

void
hello()
    CODE:
        printf("Hello, world!\n");

int
puzzle_new(klass, file)
    char *klass
    char *file

    CODE:
      RETVAL = 1;

    OUTPUT:
      RETVAL

void
puzzle_fill_cvec_from_file(file)
    char *file;

    CODE:
      printf("hi\n");

int
puzzle_compress_cvec()

    CODE:
      RETVAL = 1;

    OUTPUT:
      RETVAL

int
puzzle_uncompress_cvec()

    CODE:
      RETVAL = 1;

    OUTPUT:
      RETVAL

double
puzzle_vector_normalized_distance()

    CODE:
      RETVAL = 1;

    OUTPUT:
      RETVAL

int
puzzle_set_p_ratio()

    CODE:
      RETVAL = 1;

    OUTPUT:
      RETVAL

int
puzzle_set_lambdas()

    CODE:
      RETVAL = 1;

    OUTPUT:
      RETVAL

int
puzzle_set_max_width()

    CODE:
      RETVAL = 1;

    OUTPUT:
      RETVAL

int
puzzle_set_max_height()

    CODE:
      RETVAL = 1;

    OUTPUT:
      RETVAL

int
puzzle_set_noise_cutoff()

    CODE:
      RETVAL = 1;

    OUTPUT:
      RETVAL

int
puzzle_set_contrast_barrier_for_cropping()

    CODE:
      RETVAL = 1;

    OUTPUT:
      RETVAL

int
puzzle_set_max_cropping_ratio()

    CODE:
      RETVAL = 1;

    OUTPUT:
      RETVAL

int
puzzle_set_autocrop()

    CODE:
      RETVAL = 1;

    OUTPUT:
      RETVAL
