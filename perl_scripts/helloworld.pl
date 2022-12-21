#!/usr/bin/perl

# Using a module called English
use English;

print("Hello World!\n");
print("You are using program $0\n");

# With the help of English module
print("You are using $PROGRAM_NAME\n");

# Perl also uses an argument array
print("Hello $ARGV[0]\n");