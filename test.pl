
use ExtUtils::testlib;
use lib './lib';
use Puzzle;

Puzzle::hello();
Puzzle::print_puzzle_fill_cvec_from_file('../../php/libpuzzle/tests/pics/pic-a-0.jpg');
