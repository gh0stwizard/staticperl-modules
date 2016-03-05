use 5.008_001;

use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  dist => {
    PREOP  => 'pod2text lib/HTML/Escape.pm | tee README >$(DISTVNAME)/README; chmod -R u=rwX,go=rX . ;',
    COMPRESS  => 'gzip -9v',
    SUFFIX  => '.gz',
  },
  NAME => 'HTML::Escape',
  DISTNAME => 'HTML-Escape',
  VERSION_FROM => 'lib/HTML/Escape.pm',
  OBJECT => '$(O_FILES)',
  ABSTRACT => 'Extremely fast HTML escape',
  AUTHOR => "Goro Fuji, Tokuhiro Matsuno <tokuhirom AAJKLFJEF\@ GMAIL COM>",
  LICENSE => 'perl',
  BUILD_REQUIRES => {
    "Devel::PPPort" => "3.20",
    "Test::More" => "0.98",
    "Test::Requires" => "0",
  },
  PREREQ_PM    => {
    
  } 
);
