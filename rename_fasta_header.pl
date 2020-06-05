#! /usr/bin/perl

use strict;
use warnings;


# by Livia Donaire 2020-06-05
# script to change fasta headers for headers in another file in comma delimited fomat with 5 columns

# sequences.fasta downloaded from Virus NCBI database
# sequences.csv downloaded from Virus NCBI database with columns: accession,species,genus,family,segment


# check for proper input parameters 
unless ($ARGV[1]) {
  die "Usage: perl $0 sequences.csv sequences.fasta\n";
}


# open input files
my $infile1 = $ARGV[0];
open (IN1,"<$infile1") || die "Cannot open input file $infile1: $!";
my $infile2 = $ARGV[1];
open (IN2,"<$infile2") || die "Cannot open input file $infile2: $!";


# create output file in fasta format
$infile2 =~ s/\.[^.]*$//; # to remove any file extension in the input file
my $outfile = $infile2 . '_renamed.fa';  # give the same name to the new output with a sufix "_renamed"
open (OUT, ">$outfile") || die "Cannot create $outfile: $!"; 

my @arr; # create a global array to save fasta header names

# save fasta headers in @arr
while (<IN1>) {
        chomp;
	next if $. < 2; # Skip csv header
        my @a = split /,/; # split fields by commas
        push @arr, $a[0] . " Species=" . $a[1] . ", Genus=" . $a[2] . ", Family=" . $a[3] . ", Segment=" . $a[4]  if length;
        last if eof; # to detect the end of the file
}

# change fasta heades in a new file
while (<IN2>) {
	print OUT /^>/ ? ">" . shift(@arr) . "\n" : $_; 
}

print "\n ***** Reported errors are due to lacking information in some csv columns (i.e. segment column is empty for most of the viruses) *****\n";

close IN1;
close IN2;
close OUT;
exit;
