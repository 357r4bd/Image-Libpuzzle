
use ExtUtils::testlib;
use lib './lib';
use Image::Libpuzzle; 

use Devel::Peek;
use Data::Dumper ();

# initial synopsis

my $pic1 = q{pics/luxmarket_tshirt01.jpg};
my $pic2 = q{pics/luxmarket_tshirt01_sal.jpg};

my $p1 = Image::Libpuzzle->new; #( lambdas => 11, p_ratio => 2.0 );  # TODO, process these params
my $p2 = Image::Libpuzzle->new; #( lambdas => 11, p_ratio => 2.0 );  # TODO, process these params

my $sig1 = $p1->get_signature_from_file($pic1);
my $sig2 = $p2->get_signature_from_file($pic2);

foreach my $i ( 11, 9, 7, 5 ) {
  foreach my $j ( 2.0, 1.0, 0.5 ) {
    print "Lambda: $i, p ratio: $j\n";
    $p1->puzzle_set_lambdas($i);
    $p1->puzzle_set_p_ratio($j);
    $sig1 = $p1->get_signature_from_file($pic1);
    $p2->puzzle_set_lambdas($i);
    $p2->puzzle_set_p_ratio($j);
    $sig2 = $p2->get_signature_from_file($pic2);
    print unpack("C*", $sig1), "\n";
    print unpack("C*", $sig2);
    printf("\nEuclidean length: %f",$p1->puzzle_vector_euclidean_length);
    printf("\nDiff with \$p2: %f", $p1->puzzle_vector_normalized_distance($p2));
    print "\n\n";
  }
}

my $cvec = $p1->get_cvec; # reference to Image::Libpuzzle::Cvec

__END__

#maybe also provide the example functionality of Libpuzzle PHP:
# Compute sig1natures for two images
my $cvec1 = puzzle_fill_cvec_from_file('img1.jpg');
my $cvec2 = puzzle_fill_cvec_from_file('img2.jpg');

# Compute the distance between both sig1natures
my $d = puzzle_vector_normalized_distance($cvec1, $cvec2);

# Are pictures similar?
if ($d < PUZZLE_CVEC_SIMILARITY_LOWER_THRESHOLD) {
  print "Pictures are looking similar\n";
} else {
  print "Pictures are different, distance=$d\n";
}

# Compress the sig1natures for database storage
my $compress_cvec1 = puzzle_compress_cvec($cvec1);
my $compress_cvec2 = puzzle_compress_cvec($cvec2)
