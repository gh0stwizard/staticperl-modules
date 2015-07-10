use ExtUtils::MakeMaker;

WriteMakefile(
    NAME    => 'unqlite',
    INC     => '-I$(PERL_INC)',
    SKIP    => [qw(dynamic dynamic_lib dlsyms)],
    OBJECT  => '$(O_FILES)',
    clean   => {'FILES' => 'libunqlite.a'},
    H       => [qw(unqlite.h $(PERL_INC)/config.h)],
    C       => [qw(unqlite.c)],
    NO_MYMETA => 1,
);

sub MY::constants {
    package MY;
    my $self = shift;

    $self->{INST_STATIC} = 'libunqlite$(LIB_EXT)';

    return $self->SUPER::constants();
}

sub MY::top_targets {
    my $r = '
all :: static
	$(NOECHO) $(NOOP)

config ::
	$(NOECHO) $(NOOP)

lint:
	lint -abchx $(LIBSRCS)

pure_all :: all
	$(NOECHO) $(NOOP)

';
    $r .= '
# This is a workaround, the problem is that our old GNU make exports
# variables into the environment so $(MYEXTLIB) is set in here to this
# value which can not be built.
unqlite/libunqlite.a:
	$(NOECHO) $(NOOP)
' unless $^O eq 'VMS';

    return $r;
}
