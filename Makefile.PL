use 5.014004;
use ExtUtils::MakeMaker;

# Check that the local system has libpuzzle installed using
# Devel::CheckLib.

use lib 'inc';
use Devel::CheckLib;
check_lib_or_exit (lib => 'puzzle', header => 'puzzle.h');

# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
my $repo = 'https://github.com/estrabd/Image-Libpuzzle';
WriteMakefile(
    NAME              => 'Image::Libpuzzle',
    VERSION_FROM      => 'lib/Image/Libpuzzle.pm', # finds $VERSION
    PREREQ_PM         => {}, # e.g., Module::Name => 1.1
    ABSTRACT_FROM     => 'lib/Image/Libpuzzle.pm', # retrieve abstract from module
    AUTHOR            => 'B. Estrade <estrabd@gmail.com>',
    LIBS              => ['-lpuzzle'], # e.g., '-lm'
    DEFINE            => '', # e.g., '-DHAVE_SOMETHING'
    INC               => '', # e.g., '-I. -I/usr/include/other'
    META_MERGE        => {
        'meta-spec' => { version => 2 },
        resources => {
            repository  => {
                type => 'git',
                web  => $repo,
                url  => "$repo.git",
            },
            bugtracker => {
                web => "$repo/issues",
            },
        },
    },
    # Un-comment this if you add C files to link with later:
    # OBJECT            => '$(O_FILES)', # link all the C files too
);
