#!/usr/bin/perl
use warnings;
#NOTES
#---------------------------------------------------------------------------------------#
#This script converts fasta formatted files into phylip formatted files
#All fasta files in a folder are converted
#---------------------------------------------------------------------------------------#
#USER VARIABLES
#---------------------------------------------------------------------------------------#
#---------------------------------------------------------------------------------------#

system 'ls *.codonalign.fasta > FastaFiles';
open FH1, "<FastaFiles";
while (<FH1>)
{
	if (/((\S+)\.fasta)/)
	{
		$file = $1;
		$gene = $2;
		open FH2, "$file";
		open OUT1, ">$gene.phy";
                %taxhash = ();
		%lengthhash = ();
		@taxarray = ();
		$total_len = 0;
		while (<FH2>)
		{
			if (/\>(\S+)/)
			{
				$taxon = $1;
				push @taxarray, $taxon;
			}
			elsif (/(\S+)/)
			{
				$gene = $1;
				$taxhash{$taxon} = $gene;
				if (! exists $lengthhash{$gene})
				{
					$lengthhash{$gene} = length ($taxhash{$taxon});
				}
				elsif (exists $lengthhash{$gene})
				{
					if ($lengthhash{$gene} < length ($taxhash{$taxon}))
					{
						$lengthhash{$gene} = length ($taxhash{$taxon});
					}
				}
			}
		}
		close FH2;
		$total_len = $total_len + $lengthhash{$gene};
		$Ntax = scalar @taxarray;
		print OUT1 "$Ntax  $total_len\n";
		foreach $TAX (keys %taxhash)
		{
			if (exists $taxhash{$TAX})
			{
				print OUT1 "$TAX  $taxhash{$TAX}\n";
			}
		}
		close OUT1;
	}
}
close FH1;
unlink "FastaFiles";
exit;



