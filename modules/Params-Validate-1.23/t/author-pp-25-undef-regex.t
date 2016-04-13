
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
