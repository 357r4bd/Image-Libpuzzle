#include <stdlib.h>
#include <string.h>
#include <errno.h>

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "puzzle.h"

#include "ppport.h"

typedef PuzzleContext * Alien__Puzzle;

MODULE = Alien::Puzzle	PACKAGE = Alien::Puzzle	PREFIX = puzzle_

Alien::Puzzle
puzzle_new(klass)
    char *klass

    CODE:
      PuzzleContext *context;

      if ((context = malloc(sizeof(*context))) == NULL) {
          croak("Unable to allocate PuzzleContext: %s", strerror(errno));
      }

      puzzle_init_context(context);

      RETVAL = context;

    OUTPUT:
      RETVAL

SV *
puzzle_get_file_signature(context, filename)
    Alien::Puzzle context
    char *filename

    CODE:
      PuzzleCvec cvec;

      puzzle_init_cvec(context, &cvec);

      if (puzzle_fill_cvec_from_file(context, &cvec, filename) < 0) {
          croak("Unable to fill CVEC from file %s: %s", filename, strerror(errno));
      }

      RETVAL = newSVpv((char *)cvec.vec, cvec.sizeof_vec);

    OUTPUT:
      RETVAL

void
puzzle_DESTROY(context)
    Alien::Puzzle context

    CODE:
      free(context);
