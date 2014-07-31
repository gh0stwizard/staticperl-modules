

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

my $badlt_rx = qr/Invalid local time|local time [0-9\-:T]+ does not exist/;

{
    eval {
        DateTime->new(
            year => 2003, month     => 4, day => 6,
            hour => 2,    time_zone => 'America/Chicago',
        );
    };

    like( $@, $badlt_rx, 'exception for invalid time' );

    eval {
        DateTime->new(
            year      => 2003, month  => 4,  day    => 6,
            hour      => 2,    minute => 59, second => 59,
            time_zone => 'America/Chicago',
        );
    };
    like( $@, $badlt_rx, 'exception for invalid time' );
}

{
    eval {
        DateTime->new(
            year      => 2003, month  => 4,  day    => 6,
            hour      => 1,    minute => 59, second => 59,
            time_zone => 'America/Chicago',
        );
    };
    ok( !$@, 'no exception for valid time' );

    my $dt = DateTime->new(
        year      => 2003, month => 4, day => 5,
        hour      => 2,
        time_zone => 'America/Chicago',
    );

    eval { $dt->add( days => 1 ) };
    like( $@, $badlt_rx, 'exception for invalid time produced via add' );
}

done_testing();

