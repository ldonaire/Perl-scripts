#!/usr/bin/perl

# Perl script to calculate the 5' end nucleotide composition of a pool of sRNA sequences in fasta format.

use strict;
use warnings;
use Bio::SeqIO;		#  Bioperl
use Bio::SearchIO;	#  Bioperl

# check for proper input parameters
unless ($ARGV[0]) {
  die "Usage: perl $0 <sequences.fasta>\n";
}

# subrutine to do the work 
&nt_comp($ARGV[0]);

exit;

# subroutine to do the work
sub nt_comp ($) {
  my $infile = shift;
 
# global variables
  my $countID = 0; # number of total sequence IDs in the file
  my $countA = 0; # number of sequences beginning with A
  my $countT = 0; # number of sequences beginning with T
  my $countC = 0; # number of sequences beginning with C
  my $countG = 0; # number of sequences beginning with G
  my $countN = 0; # number of sequences beginning with N
  my $perA = 0;
  my $perT = 0;
  my $perC = 0;
  my $perG = 0;
  my $perN = 0;

  # read input FASTA file with Bioperl
  my $inseq = Bio::SeqIO->new('-file'=>$infile, '-format'=>'fasta');

  print "Checking sequences...\n";

  # loop for each sequence at input FASTA file
  while (my $seqobj = $inseq->next_seq) {
      my $seq = $seqobj->seq();			# get the sequence
      $countID++; #count total number of sequences analyzed

		if ($seq =~ /^A\w+/) {
		$countA++;
		} if ($seq =~ /^T\w+/){
		$countT++;
		} if ($seq =~ /^C\w+/){
		$countC++;
		} if ($seq =~ /^G\w+/){
		$countG++;
		} if ($seq =~ /^N\w+/){
		$countN++;
		}	
}
# calculating percentages of 5' end nucleotide composition
$perA = $countA/$countID*100;
$perT = $countT/$countID*100;
$perC = $countC/$countID*100;
$perG = $countG/$countID*100;
$perN = $countN/$countID*100;

# print data to the STDOUT
print "Total sequences analyzed:\t$countID\n";
print "5'_end_nt\tcounts\tpercentage\n"; #header of the output file
print "A\t$countA\t$perA\n";
print "T\t$countT\t$perT\n";
print "C\t$countC\t$perC\n";
print "G\t$countG\t$perG\n";
print "N\t$countN\t$perN\n";
}
#############################################
