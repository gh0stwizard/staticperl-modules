use strict;
use warnings;
use Test::More 0.88;
use Test::Fatal;

use Test::Requires {
    'Test::Without::Module' => 0,
};

use Test::Without::Module 'Class::Load::XS';

{
    my @warnings;
    local $SIG{__WARN__} = sub { push @warnings, @_ };
    require Class::Load;

    is_deeply(
        \@warnings, [],
        'no warning from Class::Load when Class::Load::XS is not available'
    );
}

done_testing();
