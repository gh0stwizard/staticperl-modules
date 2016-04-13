
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

use File::Spec;
use lib File::Spec->catdir( 't', 'lib' );

use PVTests::Regex;
PVTests::Regex::run_tests();
