#!/usr/bin/perl

# Using a module called English
use English;

# With the help of English module
print("You are using $PROGRAM_NAME\n");

# Counting arguments

print("You have supplied: " . scalar @ARGV . " arguments\n");

# Perl also uses an argument array
print("Hello $ARGV[0]\n");

# Looping through an array
foreach $arg (@ARGV) {
    print("Hello $arg\n");
}