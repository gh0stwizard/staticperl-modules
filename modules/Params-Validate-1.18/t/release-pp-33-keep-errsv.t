

use Test::More;

BEGIN {
    unless ( $ENV{RELEASE_TESTING} ) {
        plan skip_all => 'these tests are for release testing';
    }

    $ENV{PV_TEST_PERL} = 1;
}

use strict;
use warnings;

use Params::Validate qw( validate SCALAR );

use Test::More;

{
    $@ = 'foo';
    v( bar => 42 );

    is(
        $@,
        'foo',
        'calling validate() does not clobber'
    );
}

done_testing();

sub v {
    validate( @_, { bar => { type => SCALAR } } );
}

