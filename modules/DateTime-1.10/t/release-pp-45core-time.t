

use Test::More;

BEGIN {
    unless ( $ENV{RELEASE_TESTING} ) {
        plan skip_all => 'these tests are for testing by the release';
    }

    $ENV{PERL_DATETIME_PP} = 1;
}

use strict;
use warnings;

use Test::More;

use DateTime;

no warnings 'redefine';
local *DateTime::_core_time = sub { 0 };

my $dt = DateTime->now;

is(
    "$dt",
    '1970-01-01T00:00:00',
    'overriding DateTime::_core_time() works'
);

done_testing();

