#!/usr/bin/env perl
use strict;
use warnings;
use Test::More 0.88;
use Test::Fatal;

use Test::Requires {
    'Test::Without::Module' => 0,
};

use Test::Without::Module qw( Class::Load::PP Class::Load::XS );

{
    like(
        exception { require Class::Load },
        qr/Class.Load.PP\.pm did not return a true value/,
        'error when loading Class::Load and no implementation is available includes errors from trying to load modules'
    );
}

done_testing();
