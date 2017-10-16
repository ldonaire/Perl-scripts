#!/usr/bin/perl

# Perl script to count sRNA sequences of 20 to 26 nts in length from a fastq 
# file and to calculate the percentage of each sRNA size class comparing to the total number of sequences analyzed.

use strict;
use warnings;
use Bio::SeqIO;		#  Bioperl
use Bio::SearchIO;	#  Bioperl

# check for proper input parameters
unless ($ARGV[0]) {
  die "Usage: perl $0 <sequences.fastq>\n";
}
# do the work 
&fq_length_distribution($ARGV[0]);

exit;

# subroutine to do the work
sub fq_length_distribution ($) {
  my $infile = shift;

  # global variables
  my ($total, $length20, $length21, $length22, $length23, $length24, $length25, $length26)=0;

  print "Parsing fastq file, please wait...\n";

  # read input FASTQ file with Bioperl
  my $inseq = Bio::SeqIO->new('-file'=>$infile, '-format'=>'fastq');

  # loop for each sequence at input FASTQ file
  while (my $seqobj = $inseq->next_seq) {
      my $seq = $seqobj->seq();		# get the sequence
      my $length = length($seq); 	# get the length of the sequence
      $total++; #count total sequences analyzed

		if ($length == 20){
		  $length20++;
		} if ($length == 21){
		  $length21++;
		} if ($length == 22){
		  $length22++;
		} if ($length == 23){
		  $length23++;
		} if ($length == 24){
		  $length24++;
		} if ($length == 25){
		  $length25++;
	        } if ($length == 26){
		  $length26++;
		}
  }
  #calculate percentages
  my $per20 =($length20/$total)*100;
  my $per21 =($length21/$total)*100;
  my $per22 =($length22/$total)*100;
  my $per23 =($length23/$total)*100;
  my $per24 =($length24/$total)*100;
  my $per25 =($length25/$total)*100;
  my $per26 =($length26/$total)*100;

 #print the results to the STDOUT
  print "Total sequences analyzed = $total\n";
  print "length\treads\tpercentage\n"; 
  print "20 nts\t$length20\t$per20\n"; 
  print "21 nts\t$length21\t$per21\n";
  print "22 nts\t$length22\t$per22\n";
  print "23 nts\t$length23\t$per23\n";
  print "24 nts\t$length24\t$per24\n";
  print "25 nts\t$length25\t$per25\n";
  print "26 nts\t$length26\t$per26\n";
}
#############################################
