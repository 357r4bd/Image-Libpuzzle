
use ExtUtils::testlib;
use lib './lib';
use Image::Libpuzzle; 

use Devel::Peek;
use Data::Dumper ();

my $p = Image::Libpuzzle->new; 

print $p->get_file_signature('./test.jpg');

#Dump($p);
#print Data::Dumper::Dumper($p);
