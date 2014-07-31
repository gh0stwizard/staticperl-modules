
BEGIN {
  unless ($ENV{RELEASE_TESTING}) {
    require Test::More;
    Test::More::plan(skip_all => 'these tests are for release candidate testing');
  }
}

use strict;
use warnings;

use Test::More;

eval "use Test::Pod::Coverage 1.04";
plan skip_all => "Test::Pod::Coverage 1.04 required for testing POD coverage"
    if $@;

pod_coverage_ok(
    'Params::Validate', {
        trustme => [
            qr/(?:UNKNOWN|set_options|validate(?:_pos|_with)?|validation_options)/
        ]
    }
);

done_testing();
