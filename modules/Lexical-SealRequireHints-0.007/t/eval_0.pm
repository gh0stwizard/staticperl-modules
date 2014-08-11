package t::eval_0;

use warnings;
use strict;

use Test::More;

sub _ok_no_eval() {
	my $lastsub = "";
	my $i = 0;
	while(1) {
		my @c = caller($i);
		unless(@c) {
			ok 0;
			diag "failed to find main program in stack trace";
			return;
		}
		my $sub = $c[3];
		if($sub eq "main::BEGIN") {
			ok 1;
			return;
		}
		my $type = $sub ne "(eval)" ? "subroutine" :
			$c[7] ? "require" :
			defined($c[6]) ? "string eval" : "block eval";
		if($type =~ /eval/ && !($lastsub eq "t::eval_0::BEGIN" &&
					$type eq "block eval")) {
			ok 0;
			diag "have $type between module and main program";
			return;
		}
		$lastsub = $sub;
		$i++;
	}
}

BEGIN { _ok_no_eval(); }
_ok_no_eval();
sub import { _ok_no_eval(); }

1;
