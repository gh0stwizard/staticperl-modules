

use Test::More;

BEGIN {
    unless ( $ENV{RELEASE_TESTING} ) {
        plan skip_all => 'these tests are for release testing';
    }

    $ENV{PERL_DATETIME_PP} = 1;
}

use strict;
use warnings;

use Test::More;

use DateTime;

{
    my $now   = DateTime->now;
    my $today = DateTime->today;

    is( $today->year,  $now->year,  'today->year' );
    is( $today->month, $now->month, 'today->month' );
    is( $today->day,   $now->day,   'today->day' );

    is( $today->hour,   0, 'today->hour' );
    is( $today->minute, 0, 'today->hour' );
    is( $today->second, 0, 'today->hour' );
}

done_testing();

