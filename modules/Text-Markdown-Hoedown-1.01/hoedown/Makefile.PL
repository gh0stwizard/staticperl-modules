use ExtUtils::MakeMaker;

my $define = ($^O eq 'MSWin32') ? '-D__USE_MINGW_ANSI_STDIO=1' : '';
my $cflags = '-c -g -O3 -Wall -Wextra -Wno-unused-parameter -Isrc';

# ifneq ($(OS),Windows_NT)
$cflags .= ' -fPIC' if ( $^O ne 'MSWin32' );

WriteMakefile
  (
    NAME => 'hoedown',
    OBJECT => '$(O_FILES)',
    NO_MYMETA => 1,
    DEFINE => $define,
    INC => '-I$(PERL_INC)', # force PERL_INC dir ahead of system -I's
    OBJECT => '$(O_FILES)',
    CCFLAGS => $cflags,
    clean => { 'FILES' => 'libhoedown$(LIB_EXT) hoedown hoedown$(OBJ)' },
    C => [ qw(
      autolink.c
      buffer.c
      escape.c
      html.c
      html_blocks.c
      html_smartypants.c
      markdown.c
      stack.c
      hoedown.c
    ) ],
  )
;

sub MY::constants {
  package MY;
  my $self = shift;

  $self->{INST_STATIC} = 'libhoedown$(LIB_EXT)';

  return $self->SUPER::constants();
}

sub MY::top_targets {
  my $r = <<'EOF';
all :: static
	$(NOECHO) $(NOOP)

pure_all :: all
	$(NOECHO) $(NOOP)

html_blocks.c :: html_block_names.gperf
	gperf -L ANSI-C -N hoedown_find_block_tag -c -C -E -S 1 --ignore-case -m100 $^ > $@

hoedown :: hoedown.o autolink.o buffer.o escape.o html.o \
           html_blocks.o html_smartypants.o markdown.o stack.o
	$(CC) $(LDFLAGS) $^ -o $@

test :: hoedown
	$(MAP_TARGET) test/MarkdownTest_1.0.3/MarkdownTest.pl \
		--script=./hoedown --testdir=test/MarkdownTest_1.0.3/Tests --tidy

EOF

  $r .= <<'EOF' unless $^O eq 'VMS';
# This is a workaround, the problem is that our old GNU make exports
# variables into the environment so $(MYEXTLIB) is set in here to this
# value which can not be built.
hoedown/libhoedown.a:
	$(NOECHO)·$(NOOP)

EOF

  return $r;
}

