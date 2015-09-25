use strict;
use warnings;

use Test::More;

use ExtUtils::testlib;
use lib './lib';
use_ok q{Image::Libpuzzle}; 

my @methods = qw/new get_cvec fill_cvec_from_file get_signature set_lambdas set_p_ratio
set_max_width set_max_height set_noise_cutoff set_contrast_barrier_for_cropping set_max_cropping_ratio
set_autocrop vector_euclidean_length vector_normalized_distance is_similar is_very_similar is_most_similar
PUZZLE_VERSION_MAJOR PUZZLE_VERSION_MINOR PUZZLE_CVEC_SIMILARITY_THRESHOLD PUZZLE_CVEC_SIMILARITY_HIGH_THRESHOLD
PUZZLE_CVEC_SIMILARITY_LOW_THRESHOLD PUZZLE_CVEC_SIMILARITY_LOWER_THRESHOLD/;

can_ok q{Image::Libpuzzle}, @methods;

my $p1 = new_ok q{Image::Libpuzzle};
my $p2 = new_ok q{Image::Libpuzzle};

my $pic1 = q{t/pics/luxmarket_tshirt01.jpg};
my $pic2 = q{t/pics/luxmarket_tshirt01_sal.jpg};

my $sig1 = $p1->fill_cvec_from_file($pic1);
ok $sig1, q{Signature for picture 1 defined};

my $sig2 = $p2->fill_cvec_from_file($pic2);
ok $sig2, q{Signature for picture 2 defined};

my $string1 = $p1->signature_as_string;
ok $string1, q{Stringified signature 1 is not empty};

my $words1_ref = $p1->signature_as_ngrams;
ok @$words1_ref, q{Ngrams not empty for signature 1};

my $string2 = $p2->signature_as_string;
ok $string2, q{Stringified signature 2 is not empty};

my $words2_ref = $p2->signature_as_ngrams;
ok @$words2_ref, q{Ngrams not empty for signature 2};

done_testing;

__END__
# initial synopsis

my $p1 = Image::Libpuzzle->new; #( lambdas => 11, p_ratio => 2.0 );  # TODO, process these params
my $p2 = Image::Libpuzzle->new; #( lambdas => 11, p_ratio => 2.0 );  # TODO, process these params

my $sig1 = $p1->fill_cvec_from_file($pic1);
my $sig2 = $p2->fill_cvec_from_file($pic2);

foreach my $i ( 11, 9, 7, 5 ) {
  foreach my $j ( 2.0, 1.0, 0.5 ) {
    #print "Lambda: $i, p ratio: $j\n";
    ok $p1->set_lambdas($i), q{setting lambda};
    ok $p1->set_p_ratio($j), q{setting p_ratio};
    $sig1 = $p1->fill_cvec_from_file($pic1);
    ok $sig1, q{first signature generated};
    ok $p2->set_lambdas($i), q{setting lambda};
    ok $p2->set_p_ratio($j), q{setting p_ratio};
    $sig2 = $p2->fill_cvec_from_file($pic2);
    ok $sig2, q{second signature generated};
    my $string1 = $p1->signature_as_string;
    #print qq{$string1\n};
    my $string2 = $p2->signature_as_string;
    #print qq{$string2\n};
    my $words1_ref = $p1->signature_as_ngrams; # defaults to $ngram size of $Image::Libpuzzle::DEFAULT_NGRAM_SIZE
    #print join ' ', @$words1_ref;
    my $words2_ref = $p2->signature_as_ngrams(6); # example overriding $Image::Libpuzzle::DEFAULT_NGRAM_SIZE 
    #print join ' ', @$words2_ref;
    # my $d = puzzle_vector_euclidean_distance($cvec1, $cvec2);
    #printf("\nEuclidean length: %f",$p1->vector_euclidean_length);
    # my $d = puzzle_vector_normalized_distance($cvec1, $cvec2);
    #printf("\nDiff with \$p2: %f", $p1->vector_normalized_distance($p2));
    #printf("\nCompare 1: Is %s",($p1->is_most_similar($p2)) ? q{most similar} : q{not most similar});
    #printf("\nCompare 2: Is %s",( $p1->vector_normalized_distance($p2) < $Image::Libpuzzle::PUZZLE_CVEC_SIMILARITY_LOWER_THRESHOLD ) ? q{most similar} : q{not most similar});
  }
}

done_testing;
