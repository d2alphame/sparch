#! /usr/bin/perl
use v5.30;
use strict;
use warnings;
use Archive::Tar;
use MIME::Base64;
use Getopt::Long;

my $run = 1;
my $keep = 0;
my $compression = "xz";
my $temp_file = "AfTzATR9gKKcqJxx";

# Process commandline options
GetOptions(
  'no-run' => sub{ $run = 0 },
  'keep' => \$keep 
) or (show_options_error() && exit 1);

mkdir "sparch";
chdir "sparch";

# Open a temporary working file
open(my $temp_handle, '>', $temp_file) or die "Cannot open temporary file: $!";
binmode $temp_handle;

# Base64-decode the data attached to this script
my $base64_data = <DATA>;
print $temp_handle decode_base64($base64_data);
close $temp_handle;

# Decompress and extract the file archive
Archive::Tar->extract_archive($temp_file, $compression);

do './install' if $run;
if($!) {
  die "$!\n";
}

unlink $temp_file;
chdir '..';
unlink $0 unless $keep;

sub show_options_error {
  say <<EOHELP;
USAGE:
  --keep
    Keep the archive after extraction. The script is deleted by default.

  --no-run
    Do not run script after extraction. If the archive was created with a --script option,
    the script will be executed after extraction. --no-run prevents the script from running.
EOHELP

  return 1;
}

# Attached tar archive compressed and base64 encoded
__DATA__
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