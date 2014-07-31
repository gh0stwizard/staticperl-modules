use strict;
use ExtUtils::MakeMaker;
use Config;

my $compiler_flags;
if(defined($ENV{RRDTWEAK_CFLAGS}) ) {
  $compiler_flags = ' ' . $ENV{RRDTWEAK_CFLAGS};
} else {
  $compiler_flags = `pkg-config librrd --cflags`;
  $compiler_flags =~ s/\s+$//m;
}

my $linker_flags;
if(defined($ENV{RRDTWEAK_LDFLAGS}) ) {
  $linker_flags = ' ' . $ENV{RRDTWEAK_LDFLAGS};
} else {
  $linker_flags = `pkg-config librrd --libs`;
  $linker_flags =~ s/\s+$//m;
}
$linker_flags = length($linker_flags) ?
    [split(/\s+/,$linker_flags)]:undef;

#my $compiler_flags = `pkg-config librrd --cflags`;
#$compiler_flags =~ s/\s+$//m;
#if( defined($ENV{RRDTWEAK_CFLAGS}) ) {
#    $compiler_flags .= ' ' . $ENV{RRDTWEAK_CFLAGS};
#}
#$compiler_flags = length($compiler_flags) ?
#    [split(/\s+/,$compiler_flags)]:undef;
#
#my $linker_flags = `pkg-config librrd --libs`;
#$linker_flags =~ s/\s+$//m;
#if( defined($ENV{RRDTWEAK_LDFLAGS}) ) {
#    $linker_flags .= ' ' . $ENV{RRDTWEAK_LDFLAGS};
#}
#$linker_flags = length($linker_flags) ?
#    [split(/\s+/,$linker_flags)]:undef;

WriteMakefile(
  dist => {
    PREOP  => 'pod2text lib/RRD/Tweak.pm | tee README >$(DISTVNAME)/README; chmod -R u=rwX,go=rX . ;',
    COMPRESS  => 'gzip -9v',
    SUFFIX  => '.gz',
  },
  NAME => 'RRD::Tweak',
  VERSION_FROM => 'lib/RRD/Tweak.pm',
  ABSTRACT => 'RRD file manipulation',
  AUTHOR => 'Stanislav Sinyagin <ssinyagin@k-open.com>',
  LICENSE => 'gpl',
  BUILD_REQUIRES => {
    'Test::More' => 0,
    'Data::Compare' => 0,
    'Data::Dumper' => 0,
    'ExtUtils::CBuilder' => 0,
    'RRDs' => 0,
  },
  PREREQ_PM    => {
    'RRDs' => 0,
  },
  CCFLAGS => $compiler_flags,
  LIBS => $linker_flags,
);
