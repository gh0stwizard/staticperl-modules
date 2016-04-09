
BEGIN {
  unless ($ENV{AUTHOR_TESTING}) {
    require Test::More;
    Test::More::plan(skip_all => 'these tests are for testing by the author');
  }
}

BEGIN {
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
