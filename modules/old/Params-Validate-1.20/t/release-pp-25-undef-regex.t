

use Test::More;

BEGIN {
    unless ( $ENV{RELEASE_TESTING} ) {
        plan skip_all => 'these tests are for release testing';
    }

    $ENV{PV_TEST_PERL} = 1;
}

use strict;
use warnings;

use Params::Validate qw(validate);
use Test::More;

{
    my @w;
    local $SIG{__WARN__} = sub { push @w, @_ };

    my @p = ( foo => undef );
    eval { validate( @p, { foo => { regex => qr/^bar/ } } ) };
    ok( $@,  'validation failed' );
    ok( !@w, 'no warnings' );
}

done_testing();

