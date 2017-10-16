#!/usr/bin/perl

# Perl script to convert a sequence file in fastq format to fasta format and to collapse reads. 
# Also it counts the number of each sRNA sequence and prints this number in the header of the fasta sequence.

use strict;
use warnings;
use Bio::SeqIO;	     # Bioperl
use Bio::SearchIO;   # Bioperl

# check for proper input parameters
unless ($ARGV[0]) {
  die "Usage: perl $0 <sequences.fastq>\n";
}

# do the work
&collapse_reads($ARGV[0]);

exit;

# subroutine to do the work
sub collapse_reads ($) {
  my $infile = shift;

  # global variables
  my %res;
  my $num_seq = 0;
  my $outseq = 0;

  print "Parsing sequences, please wait...\n";
 
  # read input FASTQ file with Bioperl
  my $inseq = Bio::SeqIO->new('-file'=>$infile, '-format'=>'fastq');

  # output file
  $infile =~ s/\.[^.]*$//; # to remove any file extension in the input file
  my $outfile = $infile . '-unique.fa';  
open (OUT, ">$outfile") || die "Cannot create $outfile: $!"; 

  # loop for each sequence at input FASTQ file
  while (my $seqobj = $inseq->next_seq) {
      my $seq = $seqobj->seq();		# get the sequence
      my $id = $seqobj->display_id();	# get the name
      $num_seq++; # count total sequences analyzed

      my $length = length($seq);	# get the length of the sequence
     
      if ($res{$seq}) {
	  $res{$seq}{"count"}++;
      }
        else {	  
	   $res{$seq} = {id => $id,
				count => 1,
				length => $length,
				seq => $seq};
        }
  }

   my @lengths;

  foreach my $r (sort keys %res) {
      print OUT ">$res{$r}{id}_$res{$r}{count}\n$res{$r}{seq}\n";
      $outseq++;      

      $lengths[$res{$r}{length}] += $res{$r}{count};

  }
 
print "$num_seq total sequences evaluated\n";
print "$outseq unique sequences\n";
}
close OUT;
#############################################
