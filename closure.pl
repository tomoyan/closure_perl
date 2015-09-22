# クロージャーは変数の値を保持する関数
#! /usr/local/bin/perl

use strict;
use warnings;
use Data::Dumper;

print "### Closure  Start ###\n";

my $secret_version = "0.001-beta\n";

# Anonymous subroutine
my $secret_sub = sub { print $secret_version };

# This is calling anonymous subroutine
&$secret_sub();

print "### outer ###\n";
# Outer subroutine
sub outer {
	my $x = 1;
	print "Outer\n";

	# Anonymous(inner) subroutine
	return sub {
		#print "Anonymous subroutine\n";
		print "$x\n";
		$x += 1;
	}
}

# Calling outer() subroutine
# Anonymous(inner) subroutine is declared
# but not executed
my $f = outer();

# Calling Anonymous(inner) subroutine
&$f();
&$f();
&$f();

print "### adder1 ###\n";
sub adder1 {
	my $addpiece = shift;
	return sub { shift() + $addpiece };
}
my $f1 = adder1(20);
print $f1->(0)."\n";
print &$f1(0)."\n";
print &$f1(10)."\n";
print &$f1(10)."\n";
print $f1->(20)."\n";
print $f1->(20)."\n";

print "### adder2 ###\n";
sub adder2 {
	my $addpiece = shift;
	my $x = 1;
	return sub { $x += $addpiece };
}
my $f2 = adder2(100);
print $f2->()."\n";
print &$f2()."\n";

print "### Closure End ###\n";