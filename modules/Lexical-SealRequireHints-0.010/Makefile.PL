{ use 5.006; }
use warnings;
use strict;

use ExtUtils::MakeMaker;

my $require_xs = "$]" < 5.007002 || ("$]" >= 5.009004 && "$]" < 5.010001);

# TODO: somehow tell ExtUtils::MakeMaker about conflicts.
# In the case of this module should be a conflict module is
#   "B::Hooks::OP::Check" => "< 0.19"

WriteMakefile(
    dist => {
        PREOP  => 'pod2text lib/Lexical/SealRequireHints.pm | tee README >$(DISTVNAME)/README; chmod -R u=rwX,go=rX . ;',
        COMPRESS  => 'gzip -9v',
        SUFFIX  => '.gz',
    },
    NAME => 'Lexical::SealRequireHints',
    VERSION_FROM => 'lib/Lexical/SealRequireHints.pm',
    OBJECT => '$(O_FILES)',
    ABSTRACT => 'prevent leakage of lexical hints',
    AUTHOR => 'Andrew Main (Zefram) <zefram@fysh.org>',
    LICENSE => 'perl_5',
    BUILD_REQUIRES => {
        ($require_xs ? () : (
			"ExtUtils::CBuilder" => "0.15",
		)),
    },
    TEST_REQUIRES => {
        "Test::More" => 0,
    },
    PREREQ_PM => {
        ($require_xs ? () : (
			"ExtUtils::CBuilder" => "0.15",
		)),
    },
    SIGN => 0,
    XS => {
	  # On MSWin32, the XS version of the workaround can't work
		# properly, because it doesn't have access to the core
		# symbols to let SAVEHINTS() work.
        ("$]" < 5.012 && $^O eq "MSWin32") ?
            () : ('SealRequireHints.xs' => 'SealRequireHints.c')
    },
    # need PERL_CORE for working SAVEHINTS()
    DEFINE => "$]" < 5.012 ? '-DPERL_CORE' : '',
);
