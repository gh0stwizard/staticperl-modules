

use Test::More;

BEGIN {
    unless ( $ENV{RELEASE_TESTING} ) {
        plan skip_all => 'these tests are for testing by the release';
    }

    $ENV{PV_TEST_PERL} = 1;
}

use strict;
use warnings;

use File::Spec;
use lib File::Spec->catdir( 't', 'lib' );

BEGIN { $ENV{PERL_NO_VALIDATION} = 1 }

use PVTests::Callbacks;
PVTests::Callbacks::run_tests();

