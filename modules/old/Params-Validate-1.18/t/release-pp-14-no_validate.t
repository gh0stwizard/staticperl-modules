

use Test::More;

BEGIN {
    unless ( $ENV{RELEASE_TESTING} ) {
        plan skip_all => 'these tests are for release testing';
    }

    $ENV{PV_TEST_PERL} = 1;
}

use strict;
use warnings;

use lib './t';

use Params::Validate qw(validate);

use Test::More;
plan tests => $] == 5.006 ? 2 : 3;

eval { foo() };
like( $@, qr/parameter 'foo'/ );

{
    local $Params::Validate::NO_VALIDATION = 1;

    eval { foo() };
    is( $@, q{} );
}

unless ( $] == 5.006 ) {
    eval { foo() };
    like( $@, qr/parameter 'foo'/ );
}

sub foo {
    validate( @_, { foo => 1 } );
}

