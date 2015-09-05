
use ExtUtils::testlib;
use lib './lib';
use Image::Libpuzzle; 

use Devel::Peek;
use Data::Dumper ();

# initial synopsis

my $p = Image::Libpuzzle->new( lambdas => 9, p_ratio => 2.0 );  # TODO, process these params

my $sig = $p->get_signature_from_file('./test.jpg');

# TODO, how to convert $sig to something meaningful?

print unpack("C*", $sig);

__END__

#maybe also provide the example functionality of Libpuzzle PHP:
# Compute signatures for two images
my $cvec1 = puzzle_fill_cvec_from_file('img1.jpg');
my $cvec2 = puzzle_fill_cvec_from_file('img2.jpg');

# Compute the distance between both signatures
my $d = puzzle_vector_normalized_distance($cvec1, $cvec2);

# Are pictures similar?
if ($d < PUZZLE_CVEC_SIMILARITY_LOWER_THRESHOLD) {
  print "Pictures are looking similar\n";
} else {
  print "Pictures are different, distance=$d\n";
}

# Compress the signatures for database storage
my $compress_cvec1 = puzzle_compress_cvec($cvec1);
my $compress_cvec2 = puzzle_compress_cvec($cvec2)
