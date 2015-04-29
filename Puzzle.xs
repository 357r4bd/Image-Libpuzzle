#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "puzzle.h"

#include "ppport.h"


MODULE = Puzzle		PACKAGE = Puzzle		

void
hello()
    CODE:
        printf("Hello, world!\n");

int
print_puzzle_fill_cvec_from_file(filename)
    char * filename
    CODE:
      PuzzleContext context;
      PuzzleCvec cvec1;
      double d;
      puzzle_init_context(&context);
      puzzle_init_cvec(&context, &cvec1);
      RETVAL=puzzle_fill_cvec_from_file(&context, &cvec1, filename);
      size_t remaining;
      int c2;
      remaining = cvec1.sizeof_vec;
      do {
        remaining--;
        c2 = (int) cvec1.vec[remaining];
        printf("%u",cvec1.vec[remaining]);
      } while (remaining > (size_t) 0U);
      printf("\n");
      puzzle_free_cvec(&context, &cvec1);
      puzzle_free_context(&context);
    OUTPUT:
      RETVAL
