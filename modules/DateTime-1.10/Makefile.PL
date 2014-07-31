use ExtUtils::MakeMaker;

WriteMakefile(
  dist => {
    PREOP  => 'pod2text lib/DateTime.pm | tee README >$(DISTVNAME)/README; chmod -R u=rwX,go=rX . ;',
    COMPRESS  => 'gzip -9v',
    SUFFIX  => '.gz',
  },
  NAME => 'DateTime',
  VERSION_FROM => 'lib/DateTime.pm',
  OBJECT => '$(O_FILES)',
  ABSTRACT => 'A date and time object',
  AUTHOR => "Dave Rolsky <autarch\@urth.org>",
  DISTNAME => 'DateTime',
  LICENSE => 'artistic_2',
  BUILD_REQUIRES => {
    "perl" => "5.008001",
  },
  TEST_REQUIRES => {
    "Storable" => 0,
    "Test::Fatal" => 0,
    "Test::More" => "0.88",
    "Test::Warnings" => "0.005",
    "utf8" => 0
  },
  PREREQ_PM    => {
    "Carp" => 0,
    "DateTime::Locale" => "0.41",
    "DateTime::TimeZone" => "1.09",
    "Math::Round" => 0,
    "Params::Validate" => "0.76",
    "Scalar::Util" => 0,
    "XSLoader" => 0,
    "base" => 0,
    "constant" => 0,
    "integer" => 0,
    "overload" => 0,
    "strict" => 0,
    "vars" => 0,
    "warnings" => 0
  } 
);
