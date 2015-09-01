
use ExtUtils::testlib;
use lib './lib';
use Alien::Puzzle;

use Devel::Peek;
use Data::Dumper ();

my $p = Alien::Puzzle->new;

print $p->get_file_signature('./test.jpg');

#Dump($p);
#print Data::Dumper::Dumper($p);
