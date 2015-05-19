#!/usr/bin/perl
use warnings;
#GOAL: Calculate the %GC at 3rd position synonymous sites for a species for each gene and print out to a table
##########################################################################################
##########################################################################################

##########################################################################################
#Store hash of 61 codons with to memory - 0 is no synonymous sites and 1 has synonymous sites
##########################################################################################
open FH1, "<translations.txt";
%TranslationHash = ();
%AAHash= ();
while (<FH1>)
{
	if (/(\S+)\s+(\S+)/)
	{
		$CODON = $1;
		$AminoAcid = $2;
		$TranslationHash{$CODON} = $AminoAcid;
		if (! exists $AAHash{$AminoAcid})
		{
			$AAHash{$AminoAcid} = 0;
		}
		elsif (exists $AAHash{$AminoAcid})
		{
			$AAHash{$AminoAcid} = 1;
		}
	}
}
close FH1;


##########################################################################################
#For each file(gene), put codons into an array and then split to find GC at 3rd postion
##########################################################################################
system 'ls *.fasta > FastaFiles.list';
open FH2, "<FastaFiles.list";
while (<FH2>)
{
	if (/((\S+)\.fasta)/)
	{
		$file = $1;
		$gene = $2;
		open FH3, "$file";
		open OUT1, ">$gene.3GC.txt";
		%SeqHash = ();
		while (<FH3>)
		{
			if (/^>(\S+)/)
			{
				$taxon = $1;
			}
			elsif (/(\S+)/)
			{
				$seq = $1;
				$seq = uc $seq;
				$SeqHash{$taxon} = $seq;
			}
		}		
		foreach $Tax (keys %SeqHash)
		{
			$SynCodonCount = 0;
			$GC3 = 0;
			$numcodons = int ((length $SeqHash{$Tax}) / 3);
			for (0..($numcodons - 1))
			{
			    $start = $_ * 3;
			    $codon = substr($SeqHash{$Tax}, $start, 3);
			    if (exists $TranslationHash{$codon})
			    {
				if ($AAHash{$TranslationHash{$codon}} == 1)
				{
				    $SynCodonCount++;
				    @CodonPositions = split //,$codon;
				    if ($CodonPositions[2] eq "G" or $CodonPositions[2] eq "C")
				    {
    					$GC3++;
				    }
				}
			    }
			    else
			    {
			    }
			}
			if ($SynCodonCount != 0)
			{
			    $pGC3 = ($GC3/$SynCodonCount);
			    print OUT1 "$Tax\t$pGC3\n";
			}
		}
	}
}
close OUT1;
close FH2;
exit;		
