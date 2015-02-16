use strict;
use warnings;

use Test::More;
use Params::Validate qw( validate );

{
    my $e = _test_args(
        pos_int => 42,
        string  => 'foo',
    );
    is(
        $e,
        q{},
        'no error with good args'
    );
}

{
    my $e = _test_args(
        pos_int => 42,
        string  => [],
    );
    like(
        $e,
        qr/The 'string' parameter \("ARRAY\(.+\)"\) to main::validate1 did not pass the 'string' callback: ARRAY\(.+\) is not a string/,
        'got error for bad string'
    );
}

{
    my $e = _test_args(
        pos_int => 0,
        string  => 'foo',
    );
    like(
        $e,
        qr/\QThe 'pos_int' parameter ("0") to main::validate1 did not pass the 'pos_int' callback: 0 is not a positive integer/,
        'got error for bad pos int (0)'
    );
}

{
    my $e = _test_args(
        pos_int => 'bar',
        string  => 'foo',
    );
    like(
        $e,
        qr/\QThe 'pos_int' parameter ("bar") to main::validate1 did not pass the 'pos_int' callback: bar is not a positive integer/,
        'got error for bad pos int (bar)'
    );
}

{
    my $e = do {
        local $@;
        eval { validate2( string => [] ); };
        $@;
    };

    is_deeply(
        $e,
        { error => 'not a string' },
        'ref thrown by callback is preserved, not stringified'
    );
}

sub _test_args {
    local $@;
    eval { validate1(@_) };
    return $@;
}

sub validate1 {
    validate(
        @_, {
            pos_int => {
                callbacks => {
                    pos_int => sub {
                        $_[0] =~ /^[1-9][0-9]*$/
                            or die "$_[0] is not a positive integer\n";
                    },
                },
            },
            string => {
                callbacks => {
                    string => sub {
                        ( defined $_[0] && !ref $_[0] && length $_[0] )
                            or die "$_[0] is not a string\n";
                    },
                },
            },
        }
    );
}

sub validate2 {
    validate(
        @_, {
            string => {
                callbacks => {
                    string => sub {
                        ( defined $_[0] && !ref $_[0] && length $_[0] )
                            or die { error => 'not a string' };
                    },
                },
            },
        }
    );
}

done_testing();
