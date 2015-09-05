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

      if ((self = malloc(sizeof(*self))) == NULL) {
          croak("Unable to allocate PuzzleContext: %s", strerror(errno));
      }

      puzzle_init_context(&self->context);
      puzzle_init_cvec(&self->context, &self->cvec);

      RETVAL = self;

    OUTPUT:
      RETVAL

int
puzzle_puzzle_set_lambdas(self, lambdas)
    Image::Libpuzzle self;
    unsigned int lambdas

    CODE:
      RETVAL = puzzle_set_lambdas(&self->context, lambdas);

    OUTPUT:
      RETVAL

int
puzzle_puzzle_set_p_ratio(self, p_ratio)
    Image::Libpuzzle self;
    double p_ratio

    CODE:
      RETVAL = puzzle_set_p_ratio(&self->context, p_ratio);

    OUTPUT:
      RETVAL

int
puzzle_puzzle_set_max_width(self, width)
    Image::Libpuzzle self;
    unsigned int width

    CODE:
      RETVAL = puzzle_set_max_width(&self->context, width);

    OUTPUT:
      RETVAL

int
puzzle_puzzle_set_max_height(self, height)
    Image::Libpuzzle self;
    unsigned int height

    CODE:
      RETVAL = puzzle_set_max_height(&self->context, height);

    OUTPUT:
      RETVAL

int
puzzle_puzzle_set_noise_cutoff(self, noise_cutoff)
    Image::Libpuzzle self;
    double noise_cutoff

    CODE:
      RETVAL = puzzle_set_noise_cutoff(&self->context, noise_cutoff);

    OUTPUT:
      RETVAL

int
puzzle_puzzle_set_contrast_barrier_for_cropping(self, barrier)
    Image::Libpuzzle self;
    double barrier

    CODE:
      RETVAL = puzzle_set_contrast_barrier_for_cropping(&self->context, barrier);

    OUTPUT:
      RETVAL

int
puzzle_puzzle_set_max_cropping_ratio(self, ratio)
    Image::Libpuzzle self;
    double ratio

    CODE:
      RETVAL = puzzle_set_max_cropping_ratio(&self->context, ratio);

    OUTPUT:
      RETVAL

int
puzzle_puzzle_set_autocrop(self, enable)
    Image::Libpuzzle self;
    int enable

    CODE:
      RETVAL = puzzle_set_autocrop(&self->context, enable);

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
