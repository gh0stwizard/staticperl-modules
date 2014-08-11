use warnings;
use strict;

use Test::More tests => 11;

BEGIN { use_ok "Lexical::SealRequireHints"; }

my $retval;

eval { $retval = require t::context_0; 1 };
is $@, "";
is $retval, "t::context_0 return";

eval { $retval = require t::context_0; 1 };
is $@, "";
is $retval, 1;

eval { $retval = [ require t::context_1 ]; 1 };
is $@, "";
is_deeply $retval, ["t::context_1 return"];

eval { $retval = [ require t::context_1 ]; 1 };
is $@, "";
is_deeply $retval, [1];

eval { require t::context_2; 1 };
is $@, "";

eval { require t::context_2; 1 };
is $@, "";

1;
