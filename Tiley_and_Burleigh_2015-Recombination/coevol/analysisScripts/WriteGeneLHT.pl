#!/usr/bin/perl
use warnings;
system 'ls *.codonalign.fasta > CodonFiles.list';
%RR_Hash = ();
$RR_Hash{Alyrata} = 2.262181872;
$RR_Hash{Athaliana} = 4.167024015;
$RR_Hash{Bdistachyon} = 5.520634458;
$RR_Hash{Brapa} = 4.829715985;
$RR_Hash{Crubella} = 4.147563187;
$RR_Hash{Cpapaya} = 2.816678675;
$RR_Hash{Cclementina} = 2.767517903;
$RR_Hash{Csinensis} = 2.193478709;
$RR_Hash{Csativus} = 3.1516835;
$RR_Hash{Egrandis} = 2.087642726;
$RR_Hash{Fvesca} = 1.857534088;
$RR_Hash{Gmax} = 2.403200067;
$RR_Hash{Graimondii} = 1.963163573;
$RR_Hash{Lusitatissimum} = 3.420963061;
$RR_Hash{Mdomestica} = 1.521497063;
$RR_Hash{Mesculenta} = 1.914391619;
$RR_Hash{Mtruncatula} = 2.995936849;
$RR_Hash{Mguttatus} = 4.964937243;
$RR_Hash{Osativa} = 4.728268051;
$RR_Hash{Pvirgatum} = 1.114912995;
$RR_Hash{Pvulgaris} = 2.674786341;
$RR_Hash{Ptrichocarpa} = 4.960937817;
$RR_Hash{Ppersica} = 2.453502542;
$RR_Hash{Sitalica} = 3.275339783;
$RR_Hash{Slycopersicum} = 1.814823123;
$RR_Hash{Stuberosum} = 1.152916606;
$RR_Hash{Sbicolor} = 2.118377669;
$RR_Hash{Tcacao} = 2.690679243;
$RR_Hash{Vvinifera} = 2.988206248;
$RR_Hash{Zmays} = 0.717771706;
open FH1, "<CodonFiles.list";
while (<FH1>)
{
	if (/((\S+)\.codonalign\.fasta)/)
	{
		$File = $1;
		$Gene = $2;
		@SpeciesArray = ();
		open FH2, "$File";
		while (<FH2>)
		{
			if (/>(\S+)/)
			{
				$Tax = $1;
				if($Tax =~ m/(Bdistachyon)\S+/g or $Tax =~ m/(Osativa)\S+/g or $Tax =~ m/(Sbicolor)\S+/g or $Tax =~ m/(Zmays)\S+/g or $Tax =~ m/(Sitalica)\S+/g or $Tax =~ m/(Pvirgatum)\S+/g or $Tax =~ m/(Mguttatus)\S+/g or $Tax =~ m/(Slycopersicum)\S+/g or $Tax =~ m/(Stuberosum)\S+/g or $Tax =~ m/(Vvinifera)\S+/g or $Tax =~ m/(Egrandis)\S+/g or $Tax =~ m/(Csinensis)\S+/g or $Tax =~ m/(Cclementina)\S+/g or $Tax =~ m/(Graimondii)\S+/g or $Tax =~ m/(Tcacao)\S+/g or $Tax =~ m/(Cpapaya)\S+/g or $Tax =~ m/(Brapa)\S+/g or $Tax =~ m/(Crubella)\S+/g or $Tax =~ m/(Athaliana)\S+/g or $Tax =~ m/(Alyrata)\S+/g or $Tax =~ m/(Mesculenta)\S+/g or $Tax =~ m/(Lusitatissimum)\S+/g or $Tax =~ m/(Ptrichocarpa)\S+/g or $Tax =~ m/(Mtruncatula)\S+/g or $Tax =~ m/(Pvulgaris)\S+/g or $Tax =~ m/(Gmax)\S+/g or $Tax =~ m/(Ppersica)\S+/g or $Tax =~ m/(Mdomestica)\S+/g or $Tax =~ m/(Fvesca)\S+/g or $Tax =~ m/(Csativus)\S+/g)
				{	
					$Species = $1;
					push @SpeciesArray, $Species;
				}
			}
		}
		$N_Species = scalar(@SpeciesArray);
		open OUT1, ">$Gene.rr.lht";
		print OUT1 "#TRAITS\n$N_Species\t1\tRecombinationRate\n";
		foreach $SPECIES (@SpeciesArray)
		{
			print OUT1 "$SPECIES\t$RR_Hash{$SPECIES}\n";
		}
	}
	close OUT1;
}
close FH2;
close FH1;
exit;
