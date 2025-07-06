#!/usr/bin/perl

#Cari Blaker
#CST 240 Lab3

use strict;
use warnings;

my $key = shift;
my $filename = shift;

#open input file in read mode or kill the program with error message
open(my $input_file, "<", $filename) or die "Can't open $filename: $!";

my $output_filename = $filename . ".enc";
#open output file in write mode or kill the program with error message
open(my $output_file, ">", $output_filename) or die "Can't create $output_filename: $!";

while (my $line = <$input_file>) {  
    chomp $line;                        #remove newline characters
    my @chars = split //, $line;        #splits each line into an array of individual characters
    foreach my $char (@chars) {         #parse the character array
        if ($char =~ /[a-z]/) {      #if it's alphabetical, and lowercase
            my $ascii = ord($char);     #ord converts to ascii
            my $shifted_ascii = $ascii + $key;      #shift according to key
            if ($char =~ /[a-z]/ && $shifted_ascii > ord('z')) { #boundary fixing
                $shifted_ascii -= 26;
            }
            my $encrypted_char = chr($shifted_ascii);      #converts ascii code back to a character in perl
            print $output_file $encrypted_char;
        } 
    }
    print $output_file "\n";
}

close $input_file;
close $output_file;

print "Encryption complete. Encrypted file: $output_filename\n";

