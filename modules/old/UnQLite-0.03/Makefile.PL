use ExtUtils::MakeMaker;
use Config;

my $myextlib = 'unqlite/libunqlite$(LIB_EXT)';

WriteMakefile(
    dist => {
        PREOP  => 'pod2text lib/UnQLite.pm | tee README >$(DISTVNAME)/README; chmod -R u=rwX,go=rX . ;',
        COMPRESS  => 'gzip -9v',
        SUFFIX  => '.gz',
    },
    NAME => 'UnQLite',
    VERSION_FROM => 'lib/UnQLite.pm',
    ABSTRACT => 'Perl bindings for UnQLite',
    AUTHOR => 'tokuhirom tokuhirom@gmail.com',
    LICENSE => 'artistic_2',
    TEST_REQUIRES => {
        'Test::More' => '0.98',
    },
    INC => '-Iunqlite',
    MYEXTLIB => $myextlib,
);

# We don't want the default subdir rule, as it creates a race condition with the
# rule we add below.
sub MY::subdir_x {
    return '';
}

sub MY::postamble {
    return <<'EOT';
$(MYEXTLIB): unqlite/Makefile
	cd unqlite && $(MAKE) all
EOT
}
