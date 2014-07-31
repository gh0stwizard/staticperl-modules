use ExtUtils::MakeMaker;

WriteMakefile(
  dist => {
    PREOP  => 'pod2text lib/Params/Classify.pm | tee README >$(DISTVNAME)/README; chmod -R u=rwX,go=rX . ;',
    COMPRESS  => 'gzip -9v',
    SUFFIX  => '.gz',
  },
  NAME => 'Params::Classify',
  AUTHOR => 'Andrew Main (Zefram) <zefram@fysh.org>',
  ABSTRACT => 'Params::Classify - argument type classification',
  DISTNAME => 'Params-Classify',
  LICENSE => 'perl',
  BUILD_REQUIRES => {
 	"ExtUtils::ParseXS" => "2.2006",
	"Test::More" => 0,
	"strict" => 0,
    "warnings" => 0,
  },
  PREREQ_PM    => {
	"Exporter" => 0,
	"Scalar::Util" => "1.01",
	"parent" => 0,
	"strict" => 0,
	"warnings" => 0,
  },
  VERSION_FROM => 'lib/Params/Classify.pm',
);
