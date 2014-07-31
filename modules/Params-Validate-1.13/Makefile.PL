use strict;
use ExtUtils::MakeMaker;
use Config;

WriteMakefile(
  dist => {
    PREOP  => 'pod2text lib/Params/Validate.pm | tee README >$(DISTVNAME)/README; chmod -R u=rwX,go=rX . ;',
    COMPRESS  => 'gzip -9v',
    SUFFIX  => '.gz',
  },
  NAME => 'Params::Validate',
  VERSION_FROM => 'lib/Params/Validate.pm',
  ABSTRACT => 'Validate method/function parameters',
  AUTHOR => "Dave Rolsky, <autarch\@urth.org> and Ilya Martynov <ilya\@martynov.org>",
  LICENSE => 'artistic_2',
  BUILD_REQUIRES => {
    perl => "5.008001",
  },
  TEST_REQUIRES => {
    "Devel::Peek" => 0,
    "File::Spec" => 0,
    "File::Temp" => 0,
    "Module::Implementation" => "0.04",
    "Test::Fatal" => 0,
    "Test::More" => "0.88",
    "Tie::Array" => 0,
    "Tie::Hash" => 0,
    "base" => 0,
    "overload" => 0
  },
  PREREQ_PM    => {
    "Attribute::Handlers" => "0.79",
    "Carp" => 0,
    "Exporter" => 0,
    "Module::Implementation" => 0,
    "Scalar::Util" => "1.10",
    "XSLoader" => 0,
    "attributes" => 0,
    "strict" => 0,
    "vars" => 0,
    "warnings" => 0
  },
  DIR => [ 'xs' ],
);
