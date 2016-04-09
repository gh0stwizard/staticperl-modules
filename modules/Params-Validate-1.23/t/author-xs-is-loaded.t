
BEGIN {
  unless ($ENV{AUTHOR_TESTING}) {
    require Test::More;
    Test::More::plan(skip_all => 'these tests are for testing by the author');
  }
}

use strict;
use warnings;

use Test::More;

BEGIN { $ENV{PV_WARN_FAILED_IMPLEMENTATION} = 1 }

use Module::Implementation 0.04 ();
use Params::Validate;

is(
    Module::Implementation::implementation_for('Params::Validate'),
    'XS',
    'XS implementation is loaded by default'
);

done_testing();
