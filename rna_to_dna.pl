#!/usr/bin/perl

# Perl script to transform RNA sequences to DNA in a multifasta input file.

use strict;
use warnings;
use Bio::SeqIO;	# Bioperl
use Bio::Seq;	# Bioperl

# check for proper input parameters
unless ($ARGV[0]) {
  die "Usage: perl $0 <sequences.fasta>\n";
}

# do the work 
&parse_infile($ARGV[0]);

exit;

# subroutine to do the work
sub parse_infile ($) {
  my $infile = shift;

  # read input FASTA file with Bioperl
  my $inseq = Bio::SeqIO->new('-file'=>$infile, '-format'=>'fasta');

  # output file
  $infile =~ s/\.[^.]*$//; # to remove any file extension in the input file
  my $outfile = $infile . '-DNA.fasta';
  open (OUT, ">$outfile") || die "Cannot create $outfile: $!";

  # loop for each sequence at input FASTA file
  while (my $seqobj = $inseq->next_seq) {
      my $seq = $seqobj->seq();		# get the sequence
      my $id = $seqobj->display_id();	# get the name
     
      my $dna = $seq;
      $dna =~ s/U/T/g;
        
  	# print output file in fasta format
 	print OUT ">$id\n$dna\n";
  }
}
close OUT;
#############################################
