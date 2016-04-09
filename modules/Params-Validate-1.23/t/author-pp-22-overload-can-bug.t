
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
    package Overloaded;

    use overload 'bool' => sub {0};

    sub new { bless {} }

    sub foo {1}
}

my $ovl = Overloaded->new;

{
    eval {
        my @p = ( object => $ovl );
        validate( @p, { object => { isa => 'Overloaded' } } );
    };

    is( $@, q{}, 'overloaded object->isa' );
}

{
    eval {
        my @p = ( object => $ovl );
        validate( @p, { object => { can => 'foo' } } );
    };

    is( $@, q{}, 'overloaded object->foo' );
}

done_testing();
