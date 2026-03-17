#!/usr/bin/perl

#Cari Blaker
#CST240 Lab3

use strict;
use warnings;

# Get the key and filename from the command line arguments
my $key = shift @ARGV;
my $filename = shift @ARGV;

# Open the input file for reading
open(my $input_file, "<", $filename) or die "Can't open $filename: $!";

# Read the input file into a single string
my $input_string = do { local $/; <$input_file> };

# Remove any newline characters from the input string
chomp($input_string);

# Close the input file handle
close($input_file);

# Convert the input string to lowercase
$input_string = lc($input_string);

# Initialize the array that will hold the encrypted message
my @rails = ();
for (my $i = 0; $i < $key; $i++) {
    $rails[$i] = "";
}

# Iterate over each character in the input string
my $rail_num = 0;
my $direction = 1;
for (my $i = 0; $i < length($input_string); $i++) {
    # Get the current character
    my $char = substr($input_string, $i, 1);
    
    # Ignore any non-lowercase characters
    if ($char !~ /[a-z]/) {
        next;
    }
    
    # Append the current character to the current rail
    $rails[$rail_num] .= $char;
    
    # If we've reached the first or last rail, reverse direction
    if ($rail_num == 0) {
        $direction = 1;
    } elsif ($rail_num == $key - 1) {
        $direction = -1;
    }
    
    # Move to the next rail in the current direction
    $rail_num += $direction;
}

# Concatenate the rails into a single string
my $output_string = join("", @rails);

# Create a new filename for the encrypted output file
my $output_filename = $filename . ".enc";

# Open the output file for writing
open(my $output_file, ">", $output_filename) or die "Can't open $output_filename: $!";

# Write the encrypted message to the output file
print $output_file $output_string;

# Close the output file handle
close($output_file);

# Print a success message
print "Encryption complete. Encrypted message written to $output_filename.\n";

