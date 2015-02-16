
BEGIN {
  unless ($ENV{AUTHOR_TESTING}) {
    require Test::More;
    Test::More::plan(skip_all => 'these tests are for testing by the author');
  }
}

use strict;
use warnings;

# this test was generated with Dist::Zilla::Plugin::Test::NoTabs 0.13

use Test::More 0.88;
use Test::NoTabs;

my @files = (
    'lib/Attribute/Params/Validate.pm',
    'lib/Params/Validate.pm',
    'lib/Params/Validate/Constants.pm',
    'lib/Params/Validate/PP.pm',
    'lib/Params/Validate/XS.pm',
    'lib/Params/ValidatePP.pm',
    'lib/Params/ValidateXS.pm',
    't/00-compile.t',
    't/00-report-prereqs.dd',
    't/00-report-prereqs.t',
    't/01-validate.t',
    't/02-noop.t',
    't/03-attribute.t',
    't/04-defaults.t',
    't/05-noop_default.t',
    't/06-options.t',
    't/07-with.t',
    't/08-noop_with.t',
    't/09-regex.t',
    't/10-noop_regex.t',
    't/11-cb.t',
    't/12-noop_cb.t',
    't/13-taint.t',
    't/14-no_validate.t',
    't/15-case.t',
    't/16-normalize.t',
    't/17-callbacks.t',
    't/18-depends.t',
    't/19-untaint.t',
    't/21-can.t',
    't/22-overload-can-bug.t',
    't/23-readonly.t',
    't/24-tied.t',
    't/25-undef-regex.t',
    't/26-isa.t',
    't/27-string-as-type.t',
    't/28-readonly-return.t',
    't/29-taint-mode.t',
    't/30-hashref-alteration.t',
    't/31-incorrect-spelling.t',
    't/32-regex-as-value.t',
    't/33-keep-errsv.t',
    't/34-recursive-validation.t',
    't/35-default-xs-bug.t',
    't/36-large-arrays.t',
    't/37-exports.t',
    't/38-callback-message.t',
    't/author-eol.t',
    't/author-no-tabs.t',
    't/author-pod-spell.t',
    't/lib/PVTests.pm',
    't/lib/PVTests/Callbacks.pm',
    't/lib/PVTests/Defaults.pm',
    't/lib/PVTests/Regex.pm',
    't/lib/PVTests/Standard.pm',
    't/lib/PVTests/With.pm',
    't/release-cpan-changes.t',
    't/release-memory-leak.t',
    't/release-pod-coverage.t',
    't/release-pod-linkcheck.t',
    't/release-pod-no404s.t',
    't/release-pod-syntax.t',
    't/release-portability.t',
    't/release-pp-01-validate.t',
    't/release-pp-02-noop.t',
    't/release-pp-03-attribute.t',
    't/release-pp-04-defaults.t',
    't/release-pp-05-noop_default.t',
    't/release-pp-06-options.t',
    't/release-pp-07-with.t',
    't/release-pp-08-noop_with.t',
    't/release-pp-09-regex.t',
    't/release-pp-10-noop_regex.t',
    't/release-pp-11-cb.t',
    't/release-pp-12-noop_cb.t',
    't/release-pp-13-taint.t',
    't/release-pp-14-no_validate.t',
    't/release-pp-15-case.t',
    't/release-pp-16-normalize.t',
    't/release-pp-17-callbacks.t',
    't/release-pp-18-depends.t',
    't/release-pp-19-untaint.t',
    't/release-pp-21-can.t',
    't/release-pp-22-overload-can-bug.t',
    't/release-pp-23-readonly.t',
    't/release-pp-24-tied.t',
    't/release-pp-25-undef-regex.t',
    't/release-pp-26-isa.t',
    't/release-pp-27-string-as-type.t',
    't/release-pp-28-readonly-return.t',
    't/release-pp-29-taint-mode.t',
    't/release-pp-30-hashref-alteration.t',
    't/release-pp-31-incorrect-spelling.t',
    't/release-pp-32-regex-as-value.t',
    't/release-pp-33-keep-errsv.t',
    't/release-pp-34-recursive-validation.t',
    't/release-pp-35-default-xs-bug.t',
    't/release-pp-36-large-arrays.t',
    't/release-pp-37-exports.t',
    't/release-pp-38-callback-message.t',
    't/release-pp-is-loaded.t',
    't/release-synopsis.t',
    't/release-test-version.t',
    't/release-xs-is-loaded.t',
    't/release-xs-segfault.t'
);

notabs_ok($_) foreach @files;
done_testing;
