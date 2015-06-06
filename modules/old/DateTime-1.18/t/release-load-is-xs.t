
BEGIN {
  unless ($ENV{RELEASE_TESTING}) {
    require Test::More;
    Test::More::plan(skip_all => 'these tests are for release candidate testing');
  }
}

use strict;
use warnings;

use Test::More;

use DateTime;

ok( ! $DateTime::IsPurePerl, 'Loading DateTime loaded the XS version' );

done_testing();
