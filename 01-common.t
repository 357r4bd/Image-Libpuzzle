use strict;
use warnings;

use ExtUtils::testlib;
use lib '../lib';
use Image::Libpuzzle; 

# initial synopsis

my $pic1 = q{t/pics/luxmarket_tshirt01.jpg};
my $pic2 = q{t/pics/luxmarket_tshirt01_sal.jpg};

my $p1 = Image::Libpuzzle->new; #( lambdas => 11, p_ratio => 2.0 );  # TODO, process these params
my $p2 = Image::Libpuzzle->new; #( lambdas => 11, p_ratio => 2.0 );  # TODO, process these params

my $sig1 = $p1->fill_cvec_from_file($pic1);
my $sig2 = $p2->fill_cvec_from_file($pic2);

foreach my $i ( 11, 9, 7, 5 ) {
  foreach my $j ( 2.0, 1.0, 0.5 ) {
    print "Lambda: $i, p ratio: $j\n";
    $p1->set_lambdas($i);
    $p1->set_p_ratio($j);
    $sig1 = $p1->fill_cvec_from_file($pic1);
    $p2->set_lambdas($i);
    $p2->set_p_ratio($j);
    $sig2 = $p2->fill_cvec_from_file($pic2);
    my $string1 = $p1->signature_as_string;
    print qq{$string1\n};
    my $string2 = $p2->signature_as_string;
    print qq{$string2\n};
    my $words1_ref = $p1->signature_as_ngrams; # defaults to $ngram size of $Image::Libpuzzle::DEFAULT_NGRAM_SIZE
    print join ' ', @$words1_ref;
    my $words2_ref = $p2->signature_as_ngrams(6); # example overriding $Image::Libpuzzle::DEFAULT_NGRAM_SIZE 
    print join ' ', @$words2_ref;
    # my $d = puzzle_vector_euclidean_distance($cvec1, $cvec2);
    printf("\nEuclidean length: %f",$p1->vector_euclidean_length);
    # my $d = puzzle_vector_normalized_distance($cvec1, $cvec2);
    printf("\nDiff with \$p2: %f", $p1->vector_normalized_distance($p2));
    printf("\nCompare 1: Is %s",($p1->is_most_similar($p2)) ? q{most similar} : q{not most similar});
    print "\n";
    printf("\nCompare 2: Is %s",( $p1->vector_normalized_distance($p2) < $Image::Libpuzzle::PUZZLE_CVEC_SIMILARITY_LOWER_THRESHOLD ) ? q{most similar} : q{not most similar});
    print "\n";
    print "\n\n";
  }
}

my $cvec = $p1->get_cvec; # reference to Image::Libpuzzle::Cvec

#my $cvec1 = $p1->puzzle_fill_cvec_from_file($pic1);
#my $cvec2 = $p2->puzzle_fill_cvec_from_file($pic2);

__END__

#maybe also provide the example functionality of Libpuzzle PHP:
# Compute sig1natures for two images

# Compute the distance between both sig1natures

# Are pictures similar?
if ($d < PUZZLE_CVEC_SIMILARITY_LOWER_THRESHOLD) {
  print "Pictures are looking similar\n";
} else {
  print "Pictures are different, distance=$d\n";
}

# Compress the sig1natures for database storage
my $compress_cvec1 = puzzle_compress_cvec($cvec1);
my $compress_cvec2 = puzzle_compress_cvec($cvec2)