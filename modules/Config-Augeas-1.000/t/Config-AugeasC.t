# -*- cperl -*-
# Before `make install' is performed this script should be runnable with
# `make test'. After `make install' it should work as `perl Config-AugeasC.t'

#########################

# change 'tests => 2' to 'tests => last_test_to_print';

use Test::More tests => 32;
use ExtUtils::testlib;
use File::Path ;
use File::Copy ;
use File::stat;

BEGIN { use_ok('Config::Augeas') };

use strict;
use warnings ;

package Config::Augeas;

# constants are not exported so we switch package
my $fail = 0;
foreach my $constname (qw(AUG_NONE AUG_SAVE_BACKUP AUG_SAVE_NEWFILE 
			  AUG_TYPE_CHECK AUG_NO_STDINC AUG_SAVE_NOOP
			  AUG_NO_LOAD AUG_NO_MODL_AUTOLOAD AUG_ENABLE_SPAN
                          AUG_NOERROR AUG_ENOMEM AUG_EINTERNAL AUG_EPATHX
			  AUG_ENOMATCH AUG_EMMATCH AUG_ESYNTAX AUG_ENOSPAN)) {
  next if (eval "my \$a = $constname; 1");
  if ($@ =~ /^Your vendor has not defined Config::Augeas macro $constname/) {
    print "# pass: $@";
  } else {
    print "# fail: $@";
    $fail = 1;
  }

}

package main;

ok( $fail == 0 , 'Constants' );
#########################
# Insert your test code below, the Test::More module is use()ed here so read
# its man page ( perldoc Test::More ) for help writing this test script.
ok(1,"Compilation done");

# pseudo root were input config file are read
my $r_root = 'augeas-box/';

# pseudo root where config files are written by config-model
my $aug_root = 'augeas-root/';

sub cleanup {
    # cleanup before tests
    rmtree($aug_root);
    mkpath($aug_root.'etc/ssh/', { mode => 0755 }) || die "Can't mkpath:$!" ;
    copy($r_root.'etc/hosts',$aug_root.'etc/') || die "Can't copy etc/hosts:$!";
    copy($r_root.'etc/ssh/sshd_config',$aug_root.'etc/ssh/') 
      || die "Can't copy etc/ssh/sshd_config:$!" ;

    foreach my $f (qw!hosts ssh/sshd_config!) {
	my $testfile = $aug_root."etc/$f" ;
	next if -r $testfile ;
	die "Cannot test: file $testfile was not written";
    }
}

# test augeas without backup file
cleanup;

my $h_file = $aug_root."etc/hosts" ;
my $h_size = stat($h_file)->size ;

my $aug = Config::Augeas::init($aug_root, '' ,0) ;

ok($aug,"Created new Augeas object without backup file");

my $ret = $aug->set("/files/etc/hosts/2/canonical","bilbobackup") ;

is($ret,0,"Set new host name");

$ret = $aug->save ;
is($ret,0,"Save with backup done") ;

is( stat($h_file)->size , $h_size + 6 , "Check new file size") ;

# test augeas with backup file
cleanup;

my $augb = Config::Augeas::init($aug_root, '' ,
				&Config::Augeas::AUG_SAVE_BACKUP) ;

ok($augb,"Created new Augeas object with backup file");

$ret = $augb->set("/files/etc/hosts/2/canonical","bilbobackup") ;

is($ret,0,"Set new host name");

$ret = $augb->save ;
is($ret,0,"Save with backup done") ;

my $b_file = $h_file.".augsave" ;
ok( -e $b_file , "Backup file was written" ) ;
is( stat($b_file)->size , $h_size, "compare file sizes") ;



# complete test with save file
cleanup ;

my $written_file = $aug_root."etc/hosts.augnew" ;
unlink ($written_file) if -e $written_file ;

my $augc = Config::Augeas::init($aug_root, '' ,
				&Config::Augeas::AUG_SAVE_NEWFILE |
                                &Config::Augeas::AUG_ENABLE_SPAN) ;

ok($augc,"Created new Augeas object");

my $string = $augc->get("/files/etc/hosts/1/ipaddr") ;
is($string,'127.0.0.1',"Called get (returned $string )");

$ret = $augc->srun(*STDOUT, 'get /files/etc/hosts/1/ipaddr') ;
is($ret,'1',"Called srun get (returned $ret )");

$ret = $augc->set("/files/etc/hosts/2/ipaddr","192.168.0.1") ;
$ret = $augc->set("/files/etc/hosts/2/canonical","bilbo") ;

is($ret,0,"Set new host");

$ret = $augc->save ;
is($ret,0,"First save done, no file written (no modif)") ;

ok((not -e $written_file), "File was not written" ) ;
unlink ($written_file) if -e $written_file ;

$ret = $augc->get("/files/etc/hosts/2/canonical") ;
is($ret,'bilbo',"Called get after set (returned $ret )");

#$ret = $augc->insert("/files/etc/hosts/1", inserted_host => 1 ) ;
# is($ret ,0,"insert new label");

$augc->set("/files/etc/hosts/3/ipaddr","192.168.0.2") ;
$augc->rm("/files/etc/hosts/3") ;
ok($augc,"removed entry");

$augc->set("/files/etc/hosts/5/ipaddr","192.168.0.3") ;
$augc->set("/files/etc/hosts/5/canonical","gandalf") ;

$ret = $augc->mv("/files/etc/hosts/5","/files/etc/hosts/4") ;
# get return value directly from Augeas
is($ret ,0,"mv ok");

my @a = $augc->match("/files/etc/hosts") ;
is_deeply(\@a,["/files/etc/hosts"],"match result") ;

$ret = $augc->count_match("/files/etc/hosts") ;
is($ret,1,"count_match result") ;

my $span = $augc->span('/files/etc/hosts/2') ;
is($span->{filename}, 'augeas-root/etc/hosts', "filename of span /files/etc/hosts/2") ;
is($span->{span_start}, '30', "span_start of span /files/etc/hosts/2") ;
is($span->{span_end}, '48', "span_start of span /files/etc/hosts/2") ;

# Test text_store and text_retrieve
my $hosts = "192.168.0.1 rtr.example.com router\n";
$augc->set('/raw/hosts', $hosts);
$augc->text_store('Hosts.lns', '/raw/hosts', '/t1');
$augc->text_retrieve('Hosts.lns', '/raw/hosts', '/t1', '/out/hosts');
my $hosts_out = $augc->get('/out/hosts');
is($hosts_out, $hosts, "retrieve ok");

# Test rename
$augc->set('/a/b/c', 'value');
$ret = $augc->rename('/a/b/c', 'd');
is($ret,1,"rename ok") ;

$augc->set('/a/e/d', 'value2');
$ret = $augc->rename('/a//d', 'x');
is($ret,2,"rename ok") ;

$ret = $augc->save ;
is($ret,0,"save done") ;

# $augc->print(*STDOUT,'') ;

ok(-e $written_file,"augnew file written") ;

my $wr_dir = 'wr_test' ;
my $wr_file = "$wr_dir/print_test" ;
if (not -d $wr_dir) {
  mkdir($wr_dir,0755) || die "cannot open $wr_dir:$!";
}

open(WR, ">$wr_file") or die "cannot open $wr_file:$!";
$augc->print(*WR, "/files/etc/") ;
close WR;

ok( -e $wr_file, "$wr_file exists" );

