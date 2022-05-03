package Sparch;

use 5.030000;
use strict;
use warnings;

our @ISA = qw();

our $VERSION = '0.01';


# Preloaded methods go here.
use Archive::Tar;
use MIME::Base64;
use Getopt::Long;
use File::Find;

# Usage
# --output Name of the resulting self extracting archive
# --script Name of a script to run after decompressing and extracting the archive
# --files everything after this is taken to be files that are to be in the archive
# --dir Use this in place of --files if the files are in a directory. 
# if --files and --dir are specified, all specified files as well as those in the directories are archived
# If neither --dir nor --files is specified, the list of files is read in from <STDIN>

my $compression;
my $temp_file = random_filename();              # Generate a random filename to be used
my $output = '';
my $script = '';
my $dir = '';
my @files;

# Check if XZ is available. If not, try BZIP2. If BZIP2 is also not available, then default to GZIP
# Note 9 means 'the best gzip compression level'
$compression = eval'COMPRESS_XZ' || eval'COMPRESS_BZIP' || 9;

# Parse options from the command line
GetOptions(
    'output=s' => \$output,
    'script=s' => \$script,
    'dir=s' => \$dir,
    'files=s{,}' => \@files
);

$output ||= 'out.pl';             # If --output is not specifided, default to 'out.pl'

# If --dir is specified, get all files from that directory. This needs to be done
if($dir) { my @dirs = ($dir); find(\&wanted, @dirs) }

my $tar = Archive::Tar->new;
$tar->create_archive($temp_file, $compression, @files);
#say $tar->error();


open (my $temp_handle, '<', $temp_file);
binmode $temp_handle;


# Sub routine to be used by Find::File
sub wanted {
    push @files, $File::Find::name
}


# Subroutine to generate random file names
sub random_filename {
  my $filename = '';
  my @chars = ('A' .. 'Z', 'a' .. 'z', '0' .. '9', '-', '_');
  for(1 .. 16) {
    $filename .= $chars[ int(rand(@chars))];
  }
  return $filename;
}


1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

Sparch - Perl extension for blah blah blah

=head1 SYNOPSIS

  use Sparch;
  blah blah blah

=head1 DESCRIPTION

Stub documentation for Sparch, created by h2xs. It looks like the
author of the extension was negligent enough to leave the stub
unedited.

Blah blah blah.


=head1 SEE ALSO

Mention other useful documentation such as the documentation of
related modules or operating system documentation (such as man pages
in UNIX), or any relevant external documentation such as RFCs or
standards.

If you have a mailing list set up for your module, mention it here.

If you have a web site set up for your module, mention it here.

=head1 AUTHOR

Deji Adegbite, E<lt>dejiadegbite@p1s.plx.sd.apple.comE<gt>

=head1 COPYRIGHT AND LICENSE

Copyright (C) 2022 by Deji Adegbite

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself, either Perl version 5.30.3 or,
at your option, any later version of Perl 5 you may have available.


=cut