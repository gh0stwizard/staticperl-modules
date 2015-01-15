

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

{

    package DateTime::MySubclass;
    use base 'DateTime';

    sub duration_class {'DateTime::Duration::MySubclass'}

    package DateTime::Duration::MySubclass;
    use base 'DateTime::Duration';

    sub is_my_subclass {1}
}

my $dt    = DateTime::MySubclass->now;
my $delta = $dt - $dt;

isa_ok( $delta,       'DateTime::Duration::MySubclass' );
isa_ok( $dt + $delta, 'DateTime::MySubclass' );

my $delta_days = $dt->delta_days($dt);
isa_ok( $delta_days, 'DateTime::Duration::MySubclass' );

done_testing();

