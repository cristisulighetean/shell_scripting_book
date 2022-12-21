#!/usr/bin/perl
use strict;
my $fname = prompt_user("Enter the first name: ");
my $lname = prompt_user("Enter the last name: ");

print("Hello $fname $lname\n");

sub prompt_user () {
   my $n;
   print($_[0]);
   chomp( $n = <STDIN> );
   return($n);
}