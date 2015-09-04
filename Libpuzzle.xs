#include <stdlib.h>
#include <string.h>
#include <errno.h>

#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "puzzle.h"

#include "ppport.h"

typedef struct _Image__Libpuzzle {
    PuzzleContext context;
    PuzzleCvec    cvec;
} * Image__Libpuzzle;

//typedef struct _Image__Libpuzzle *Image__Libpuzzle;

MODULE = Image::Libpuzzle	PACKAGE = Image::Libpuzzle	PREFIX = puzzle_

Image::Libpuzzle
puzzle_new(klass, ...)
    char *klass

    CODE:
      Image__Libpuzzle self;

      if ((self = malloc(sizeof self)) == NULL) {
          croak("Unable to allocate PuzzleContext: %s", strerror(errno));
      }

     puzzle_init_context(&self->context);
     puzzle_init_cvec(&self->context, &self->cvec);

      RETVAL = self;

    OUTPUT:
      RETVAL

SV *
puzzle_get_signature_from_file(self, filename)
    Image::Libpuzzle self 
    char *filename

    CODE:
      if (puzzle_fill_cvec_from_file(&self->context, &self->cvec, filename) < 0) {
          croak("Unable to fill CVEC from file %s: %s", filename, strerror(errno));
      }

      RETVAL = newSVpv((char *)self->cvec.vec, self->cvec.sizeof_vec);

    OUTPUT:
      RETVAL

void
puzzle_DESTROY(self)
    Image::Libpuzzle self

    CODE:
      free(self);
