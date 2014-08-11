use warnings;
use strict;

BEGIN {
	eval { require threads; };
	if($@ =~ /\AThis Perl not built to support threads/) {
		require Test::More;
		Test::More::plan(skip_all => "non-threading perl build");
	}
	if($@ ne "") {
		require Test::More;
		Test::More::plan(skip_all => "threads unavailable");
	}
	eval { require Thread::Semaphore; };
	if($@ ne "") {
		require Test::More;
		Test::More::plan(skip_all => "Thread::Semaphore unavailable");
	}
}

use threads;

use Test::More tests => 3;
use Thread::Semaphore ();

alarm 10;   # failure mode may involve an infinite loop

my $done1 = Thread::Semaphore->new(0);
my $exit1 = Thread::Semaphore->new(0);
my $done2 = Thread::Semaphore->new(0);
my $exit2 = Thread::Semaphore->new(0);

my $ok1 = 1;
my $thread1 = threads->create(sub {
	eval(q{
		use Lexical::SealRequireHints;
		require t::context_1;
		1;
	}) or $ok1 = 0;
	$done1->up;
	$exit1->down;
});
$done1->down;
ok $ok1;

my $ok2 = 1;
my $thread2 = threads->create(sub {
	eval(q{
		use Lexical::SealRequireHints;
		require t::context_2;
		1;
	}) or $ok2 = 0;
	$done2->up;
	$exit2->down;
});
$done2->down;
ok $ok2;

$exit1->up;
$exit2->up;
$thread1->join;
$thread2->join;
ok 1;

1;
