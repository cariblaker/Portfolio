#Cari Blaker
#CST240 Final Challenge

use strict;
use warnings;

# Input and output file paths
my $input_file = 'input.txt';
my $output_file = 'output.txt';

# Regular expressions for email and phone number patterns
my $email_regex = qr/[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}/;
my $phone_regex = qr/\b(?:\+?\d{1,3}[-.()\s]?)?(?:\d{1,3}[-.()\s]?){1,12}\d{1,4}\b/;

# Open input file for reading
open(my $input_fh, '<', $input_file) or die "Cannot open $input_file: $!";

# Initialize email and phone number lists
my @emails;
my @phone_numbers;

# Process each line of the input file
while (my $line = <$input_fh>) {
    chomp $line;

    # Find email addresses
    my @line_emails = $line =~ /$email_regex/g;
    push @emails, @line_emails;

    # Find phone numbers
    my @line_phone_numbers = $line =~ /$phone_regex/g;
    push @phone_numbers, @line_phone_numbers;
}

# Close input file
close($input_fh);

# Open output file for writing
open(my $output_fh, '>', $output_file) or die "Cannot open $output_file: $!";

# Write emails to output file
print $output_fh "Email addresses:\n";
print $output_fh join("\n", @emails), "\n\n";

# Write phone numbers to output file
print $output_fh "Phone numbers:\n";
print $output_fh join("\n", @phone_numbers), "\n";

# Close output file
close($output_fh);

print "Email addresses and phone numbers extracted and saved successfully in $output_file.\n";

