use strict;
use ExtUtils::MakeMaker 6.64;
use Config;

my $myextlib = 'hoedown/libhoedown$(LIB_EXT)';

WriteMakefile(
  dist => {
    PREOP  => 'pod2text lib/Text/Markdown/Hoedown.pm | tee README >$(DISTVNAME)/README; chmod -R u=rwX,go=rX . ;',
    COMPRESS  => 'gzip -9v',
    SUFFIX  => '.gz',
  },
  NAME => 'Text::Markdown::Hoedown',
  VERSION_FROM => 'lib/Text/Markdown/Hoedown.pm',
  ABSTRACT => 'Text::Markdown::Hoedown is binding library for hoedown.',
  AUTHOR => 'tokuhirom <tokuhirom@gmail.com>',
  LICENSE => 'perl',
  BUILD_REQUIRES => {
    perl => "5.008001",
  },
  TEST_REQUIRES => {
    'Test::More' => 0,
  },
  PREREQ_PM => {
    'ExtUtils::ParseXS' => '3.22',
    'parent' => 0,
  },
  INC => '-Ihoedown',
  MYEXTLIB => $myextlib,
);

# We don't want the default subdir rule, as it creates a race condition with the
# rule we add below.
sub MY::subdir_x { return '' }

sub MY::postamble {
  return <<'EOT';
$(MYEXTLIB) : hoedown/Makefile
	cd hoedown && $(MAKE)
EOT
}
