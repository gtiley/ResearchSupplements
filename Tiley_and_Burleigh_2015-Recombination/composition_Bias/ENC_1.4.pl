#!/usr/bin/perl
#use warnings;
#GOAL: Calculate the ENC for a species and print out to a table
##########################################################################################
#Store hash of 61 codons with anticodons to memory
##########################################################################################
open FH1, "<translations_61.txt";
%TranslationHash = ();
%AAHash= ();
while (<FH1>)
{
	if (/(\S+)\s+(\S+)/)
	{
		$CODON = $1;
		$AminoAcid = $2;
		$TranslationHash{$CODON} = $AminoAcid;
		$AAHash{$AminoAcid} = 0;
	}
}
close FH1;
##########################################################################################
#For each file(gene) calculate numbers of each codon
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
		open OUT1, ">$gene.ENC.txt";
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
			%CodonNum = ();
			foreach $Codon (keys %TranslationHash)
			{
				$CodonCount = 0;
				$numcodons = int ((length $SeqHash{$Tax}) / 3);
				for (0..($numcodons - 1))
				{
    				$start = $_ * 3;
    				$codon = substr($SeqHash{$Tax}, $start, 3);
    				if ($codon eq $Codon)
    				{
    					$CodonCount = $CodonCount + 1;
    					$CodonNum{$Codon} = $CodonCount;
    				}
    				else
    				{
    				}
    			} 	
    		}  	
##########################################################################################
#Calculate numbers of AA for same sequence
##########################################################################################	
    		%AANum = ();
    		foreach $AA (keys %AAHash)
    		{
    			$AACount = 0;
    			foreach $Codon (keys %TranslationHash)
    			{
    				if ($CodonNum{$Codon} == 0)
    				{
    					$CodonNum{$Codon} = 0;
    				}
    				if ($TranslationHash{$Codon} eq $AA)
    				{
    					$AACount = $AACount + $CodonNum{$Codon};
    					$AANum{$TranslationHash{$Codon}} = $AACount;
    				}
    				else 
    				{
    				}
    			}
    		}
##########################################################################################
#Impose a non-zero bound on the Amino Acid Count
##########################################################################################	
   			foreach $AA (keys %AAHash)
   			{
   				if ($AANum{$AA} == 0)
   				{
   					$AANum{$AA} = 1;
   				}
   			}
##########################################################################################
#Calculate the bias for each AA and use those to solve for the ENC per species
##########################################################################################    		
    		@VectorOfBiases = ();
    		foreach $AA (keys %AAHash)
    		{
    			@VectorOfFrequencies = ();
    			foreach $Codon (keys %TranslationHash)
    			{	
    				if ($TranslationHash{$Codon} eq $AA)
    				{
    					$CodonFreq = ($CodonNum{$Codon} / $AANum{$TranslationHash{$Codon}});
    					$CodonFreqSquared = ($CodonFreq * $CodonFreq);
    					push @VectorOfFrequencies, $CodonFreqSquared;
    				}
    			}
    			$BiasSum = 0;
				foreach (@VectorOfFrequencies)
				{
 					$BiasSum += $_;
				}
				if($BiasSum > 0)
				{
					$BiasForAA = (1 / $BiasSum);
					push @VectorOfBiases, $BiasForAA;
				}
				elsif($BiasSum == 0)
				{
				}
			}
			$ENC = 0;
			foreach (@VectorOfBiases)
			{
				$ENC += $_;
			}
			print OUT1 "$Tax\t$ENC\n";
		}
	}
}
close OUT1;
close FH3;
close FH2;
close FH1;
exit;			
			
			
			
