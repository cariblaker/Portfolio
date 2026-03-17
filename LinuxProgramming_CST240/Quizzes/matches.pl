#!/usr/bin/perl

use strict;
use warnings;

my ($file) = @ARGV;

print ("$file\n");

open(DATA, $file) or die("Could not open file\n");

my $pattern = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,63})";
my $line;
foreach $line (<DATA>) {
    print "$line -- $pattern\n";
    if ($line =~ /$pattern/) {
        print "$pattern IS in $line\n";
    }
    else {
        print "$pattern is NOT in $line\n";
    }
}
close(DATA);


