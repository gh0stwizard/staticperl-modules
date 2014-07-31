

use Test::More;

BEGIN {
    unless ( $ENV{RELEASE_TESTING} ) {
        plan skip_all => 'these tests are for testing by the release';
    }

    $ENV{PV_TEST_PERL} = 1;
}

use strict;
use warnings;

use Params::Validate qw(validate validate_with);
use Test::More;

my $ucfirst_normalizer = sub { return ucfirst lc $_[0] };

sub sub1 {
    my %args = validate_with(
        params         => \@_,
        spec           => { PaRaMkEy => 1 },
        normalize_keys => $ucfirst_normalizer
    );

    return $args{Paramkey};
}

sub sub2 {

    # verify that normalize_callback surpresses ignore_case
    my %args = validate_with(
        params         => \@_,
        spec           => { PaRaMkEy => 1 },
        normalize_keys => $ucfirst_normalizer,
        ignore_case    => 1
    );

    return $args{Paramkey};
}

sub sub3 {

    # verify that normalize_callback surpresses strip_leading
    my %args = validate_with(
        params         => \@_,
        spec           => { -PaRaMkEy => 1 },
        normalize_keys => $ucfirst_normalizer,
        strip_leading  => '-'
    );

    return $args{-paramkey};
}

sub sub4 {
    my %args = validate_with(
        params         => \@_,
        spec           => { foo => 1 },
        normalize_keys => sub {undef}
    );
}

sub sub5 {
    my %args = validate_with(
        params         => \@_,
        spec           => { foo => 1 },
        normalize_keys => sub { return 'a' },
    );
}

ok( eval { sub1( pArAmKeY => 1 ) } );
ok( eval { sub2( pArAmKeY => 1 ) } );
ok( eval { sub3( -pArAmKeY => 1 ) } );

eval { sub4( foo => 5 ) };
like( $@, qr/normalize_keys.+a defined value/ );

eval { sub5( foo => 5, bar => 5 ) };
like( $@, qr/normalize_keys.+already exists/ );

done_testing();

