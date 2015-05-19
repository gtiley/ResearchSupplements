#!/usr/bin/perl
use warnings;

system 'ls *.codonalign.3GC.txt > 3GCFiles.list';
open OUT1, ">CoevolSig_Avg3GC.txt";
print OUT1 "Species\tGeneNumber\tGlobal3GC\n";
open OUT2, ">CoevolSigDistn_3GC.txt";
print OUT2 "Species\t3GC\n";

%GlobalGC = ();
%LocalGC = ();
%GeneHash = ();
$SpeciesHash = ();
open FH1, "<3GCFiles.list";
open FH9, "<partialCoevol_SigResults_20150120.txt";
#open FH99, "<partialCoevol_Results_20150120.txt";
%TheList = ();
#%Excludes = ();


while (<FH9>)
{
        if (/(\S+)\s+\S+\s+\S+/)
        {
                $CoevolFile = $1;
#                $Excludes{$CoevolFile} = 1;
		$TheList{$CoevolFile} = 1;
        }
}
close FH9;
#while (<FH99>)
#{
#    if (/(\S+)\s+\S+\s+\S+\s+\S+\s+\S+/)
#    {
#                $COEVOLFile = $1;
#                if (! exists $Excludes{$COEVOLFile})
#                {
#                    $TheList{$COEVOLFile} = $1;
#                }
#    }
#}
closeFH99;
while (<FH1>)
{
	if (/((\S+)\.codonalign\.3GC\.txt)/)
	{
		$File = $1;
		$Gene = $2;
		if (! exists $GeneHash{$Gene})
		{
			$GeneHash{$Gene} = 1;
		}
		%TempGeneHash = ();
		%TempSpeciesHash = ();
		%TempTaxHash = ();
		if (exists $TheList{$Gene})
                {
#		    print "$Gene\n";
		    open FH2, "$File";
		    while (<FH2>)
		    {
			$Line = $_;
			if ($Line =~ m/((Bdistachyon)\S+)\s+(\S+)/g or $Line =~ m/((Osativa)\S+)\s+(\S+)/g or $Line =~ m/((Sbicolor)\S+)\s+(\S+)/g or $Line =~ m/((Zmays)\S+)\s+(\S+)/g or $Line =~ m/((Sitalica)\S+)\s+(\S+)/g or $Line =~ m/((Pvirgatum)\S+)\s+(\S+)/g or $Line =~ m/((Mguttatus)\S+)\s+(\S+)/g or $Line =~ m/((Slycopersicum)\S+)\s+(\S+)/g or $Line =~ m/((Stuberosum)\S+)\s+(\S+)/g or $Line =~ m/((Vvinifera)\S+)\s+(\S+)/g or $Line =~ m/((Egrandis)\S+)\s+(\S+)/g or $Line =~ m/((Csinensis)\S+)\s+(\S+)/g or $Line =~ m/((Cclementina)\S+)\s+(\S+)/g or $Line =~ m/((Graimondii)\S+)\s+(\S+)/g or $Line =~ m/((Tcacao)\S+)\s+(\S+)/g or $Line =~ m/((Cpapaya)\S+)\s+(\S+)/g or $Line =~ m/((Brapa)\S+)\s+(\S+)/g or $Line =~ m/((Crubella)\S+)\s+(\S+)/g or $Line =~ m/((Athaliana)\S+)\s+(\S+)/g or $Line =~ m/((Alyrata)\S+)\s+(\S+)/g or $Line =~ m/((Mesculenta)\S+)\s+(\S+)/g or $Line =~ m/((Lusitatissimum)\S+)\s+(\S+)/g or $Line =~ m/((Ptrichocarpa)\S+)\s+(\S+)/g or $Line =~ m/((Mtruncatula)\S+)\s+(\S+)/g or $Line =~ m/((Pvulgaris)\S+)\s+(\S+)/g or $Line =~ m/((Gmax)\S+)\s+(\S+)/g or $Line =~ m/((Ppersica)\S+)\s+(\S+)/g or $Line =~ m/((Mdomestica)\S+)\s+(\S+)/g or $Line =~ m/((Fvesca)\S+)\s+(\S+)/g or $Line =~ m/((Csativus)\S+)\s+(\S+)/g)
			{
				$Tax = $1;
				$TempTaxHash{$Tax}= 1;
#				print "$Tax";
				$GC = $3;
				$Species = $2;
				if (! exists $SpeciesHash{$Species})
				{
					$SpeciesHash{$Species} = 1;
				}
				$TempSpeciesHash{$Species}= 1;
				$TempGeneHash{$Species}{$Tax} = $GC;
#				print "$TempGeneHash{$Species}{$Tax}\n";

				print OUT2 "$Species\t$GC\n";

			}
		    }
		}
		foreach $SPECIES (keys %TempSpeciesHash)
		{
#			print "$SPECIES\n";
			$SpeciesCount = 0;
			$CopySum = 0;
			foreach $TAX (keys %TempTaxHash)
			{
#				print "$TAX\n";
				if (exists $TempGeneHash{$SPECIES}{$TAX})
				{
					$SpeciesCount = $SpeciesCount + 1;
					$CopySum = $CopySum + $TempGeneHash{$SPECIES}{$TAX};
				}
#				
			}
#			print "$SpeciesCount\n";
#			print "$CopySum\n";
			$localmeanGC = ($CopySum / $SpeciesCount);
			$LocalGC{$Gene}{$SPECIES} =  $localmeanGC;
		}
	}
}		

foreach $species (keys %SpeciesHash)
{
	$GeneNum = 0;
	$GenomeSum = 0;
	foreach	$gene (keys %GeneHash)
	{
		if (exists $LocalGC{$gene}{$species})
		{
			$GeneNum = $GeneNum + 1;
			$GenomeSum = $GenomeSum + $LocalGC{$gene}{$species};
		}
	}
	$globalmeanGC = ($GenomeSum / $GeneNum);
	$GlobalGC{$species}=$globalmeanGC;
	print OUT1 "$species\t$GlobalGC{$species}\n";
}
close OUT1;
close FH2;
close FH1;
exit;	
