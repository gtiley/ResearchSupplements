#!/usr/bin/perl
use warnings;
#LRT really corresponds to q-value - specified for each individual set of same hypothesis
#qs for FDR of 0.05
# H1 - 1.9985e-02 
# H2 - 2.1097e-02
# H1Sites - 1.7678e-02
# H2Sites - 1.5298e-02

open FH1, '<', 'CQF_RatesOut_PostFilter.txt';
open FH2, '<', 'CQF_EffectorVector.txt';
open OUT1, '>', 'CQF_Unique_H1';
open OUT2, '>', 'CQF_Unique_H2';
open OUT3, '>', 'CQF_Unique_H1Sites';
open OUT4, '>', 'CQF_Unique_H2Sites';
open OUT5, '>', 'CQF_Shared_H1H2';
open OUT6, '>', 'CQF_Shared_H1SitesH2Sites';
open OUT7, '>', 'CQF_Shared_H1_H1Sites';
open OUT8, '>', 'CQF_Shared_H1_H2Sites';
open OUT9, '>', 'CQF_Shared_H2_H1Sites';
open OUT10, '>', 'CQF_Shared_H2_H2Sites';
open OUT11, '>', 'CQF_Shared_H1_H2_H1Sites';
open OUT12, '>', 'CQF_Shared_H1_H2_H2Sites';
open OUT13, '>', 'CQF_Shared_H1_H1Sites_H2Sites';
open OUT14, '>', 'CQF_Shared_H2_H1Sites_H2Sites';
open OUT15, '>', 'CQF_Shared_H1_H2_H1Sites_H2Sites';
open OUT99, '>', 'CQF_Summary';

print OUT1 "GENE\tBACKGROUND_RATE\tFOREGROUND_RATE\tEFFECTOR\n";
print OUT2 "GENE\tBACKGROUND_RATE\tFOREGROUND_RATE\tEFFECTOR\n";
print OUT3 "GENE\tPROPORTION_POSITIVE_SITES\tEFFECTOR\n";
print OUT4 "GENE\tPROPORTION_POSITIVE_SITES\tEFFECTOR\n";
print OUT5 "GENE\tCLADE_BACKGROUND_RATE\tCLADE_FOREGROUND_RATE\tALLCQF_BACKGROUND_RATE\tALLCQF_FOREGROUND_RATE\tEFFECTOR\n";
print OUT6 "GENE\tCLADE_PROPORTION_POSITIVE_SITES\tALLCQF_PROPORTION_POSITICE_SITES\tEFFECTOR\n";
print OUT7 "GENE\tBACKGROUND_RATE\tFOREGROUND_RATE\tPROPORTION_POSITIVE_SITES\tEFFECTOR\n";
print OUT8 "GENE\tBACKGROUND_RATE\tFOREGROUND_RATE\tPROPORTION_POSITIVE_SITES\tEFFECTOR\n";
print OUT9 "GENE\tBACKGROUND_RATE\tFOREGROUND_RATE\tPROPORTION_POSITIVE_SITES\tEFFECTOR\n";
print OUT10 "GENE\tBACKGROUND_RATE\tFOREGROUND_RATE\tPROPORTION_POSITIVE_SITES\tEFFECTOR\n";
print OUT11 "GENE\tCLADE_BACKGROUND_RATE\tCLADE_FOREGROUND_RATE\tALLCQF_BACKGROUND_RATE\tALLCQF_FOREGROUND_RATE\tPROPORTION_POSITIVE_SITES\tEFFECTOR\n";
print OUT12 "GENE\tCLADE_BACKGROUND_RATE\tCLADE_FOREGROUND_RATE\tALLCQF_BACKGROUND_RATE\tALLCQF_FOREGROUND_RATE\tPROPORTION_POSITIVE_SITES\tEFFECTOR\n";
print OUT13 "GENE\tBACKGROUND_RATE\tFOREGROUND_RATE\tCLADE_PROPORTION_POSITIVE_SITES\tALLCQF_PROPORTION_POSITIVE_SITES\tEFFECTOR\n";
print OUT14 "GENE\tBACKGROUND_RATE\tFOREGROUND_RATE\tCLADE_PROPORTION_POSITIVE_SITES\tALLCQF_PROPORTION_POSITIVE_SITES\tEFFECTOR\n";
print OUT15 "GENE\tCLADE_BACKGROUND_RATE\tCLADE_FOREGROUND_RATE\tALLCQF_BACKGROUND_RATE\tALLCQF_FOREGROUND_RATE\tCLADEPROPORTION_POSITIVE_SITES\tALLCQF_PROPORTION_POSITIVE_SITES\tEFFECTOR\n";

$H1count = 0;
$H1ecount = 0;
$H2count = 0;
$H2ecount = 0;
$H1H2count = 0;
$H1H2ecount = 0;
$H1Sitescount = 0;
$H1eSitescount = 0;
$H2Sitescount = 0;
$H2eSitescount = 0;
$H1SitesH2Sitescount = 0;
$H1eSitesH2eSitescount = 0;
$Totalcount = 0;
$H1Applied = 0;
$H2Applied = 0;
$H1SitesApplied = 0;
$H2SitesApplied = 0;

$H1H1Sitescount = 0;
$H1H1Sitescounte = 0;
$H1H2Sitescount = 0;
$H1H2Sitescounte = 0;
$H2H1Sitescount = 0;
$H2H1Sitescounte = 0;
$H2H2Sitescount = 0;
$H2H2Sitescounte = 0;
$H1H2H1Sitescount = 0;
$H1H2H1Sitescounte = 0;
$H1H2H2Sitescount = 0;
$H1H2H2Sitescounte = 0;
$H1H1SitesH2Sitescount = 0;
$H1H1SitesH2Sitescounte = 0;
$H2H1SitesH2Sitescount = 0;
$H2H1SitesH2Sitescounte = 0;
$H1H2H1SitesH2Sitescount = 0;
$H1H2H1SitesH2Sitescounte = 0;


$TotalTests = 0;
$TotalSigThings = 0;
$SigH1 = 0;
$SigH2 = 0;
$SigH1Sites = 0;
$SigH2Sites = 0;
#---------------------------------------------------------------------------------------#				
%EffectorVector = ();
while (<FH2>)
{
	if (/(\d+)/)
	{
		$EffectorID = $1;
		$EffectorVector{$EffectorID} = 0;
	}
}
close FH2;

while (<FH1>)
{
	if (/(\S+)\s+\S+\s+\S+\s+\S+\s+\S+\s+\S+\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+\S+\s+\S+\s+(\S+)\s+(\S+)\s+\S+\s+\S+\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)/)
	{
		$Gene = $1;
		$H1_Background = $2;
		$H1_Foreground = $3;
		$H2_Background = $4;
		$H2_Foreground = $5;
		$H1_Sites_Class1 = $6;
		$H1_Sites_Class2 = $7;
		$H2_Sites_Class1 = $8;
		$H2_Sites_Class2 = $9;
		$LRT1 = $10;
		$LRT2 = $11;
		$LRT3 = $12;
		$LRT4 = $13;
		if ($Gene ne "Gene")
		{
#		print "$Gene\n";
#---------------------------------------------------------------------------------------#				
		if ($H1_Sites_Class1 ne "NA" and $H1_Sites_Class2 ne "NA")
		{
			$H1_ProportionSites = $H1_Sites_Class1 + $H1_Sites_Class2;
		}
		if ($H1_Sites_Class1 eq "NA" and $H1_Sites_Class2 eq "NA")
		{
			$H1_ProportionSites = 0;
		}
		if ($H2_Sites_Class1 ne "NA" and $H2_Sites_Class2 ne "NA")
		{
			$H2_ProportionSites = $H2_Sites_Class1 + $H2_Sites_Class2;
		}
		if ($H2_Sites_Class1 eq "NA" and $H2_Sites_Class2 eq "NA")
		{
			$H2_ProportionSites = 0;
		}
		
		$Totalcount++;
#---------------------------------------------------------------------------------------#				
		if ($LRT1 ne "NA")
		{
			$H1Applied++;
		}
		if ($LRT1 eq "NA")
		{
			$LRT1 = 1;
		}
		if ($LRT2 ne "NA")
		{
			$H2Applied++;
		}
		if ($LRT2 eq "NA")
		{
			$LRT2 = 1;
		}
		if ($LRT3 ne "NA")
		{
			$H1SitesApplied++;
		}
		if ($LRT3 eq "NA")
		{
			$LRT3 = 1;
		}
		if ($LRT4 ne "NA")
		{
			$H2SitesApplied++;
		}
		if ($LRT4 eq "NA")
		{
			$LRT4 = 1;
		}
#		print "$Gene\t$LRT1\t$LRT2\t$LRT3\t$LRT4\n";
#---------------------------------------------------------------------------------------#		
		if ($LRT1 <= 1.9985E-02 && $LRT2 > 2.1097E-02 && $LRT3 > 1.7678E-02 && $LRT4 > 1.5298E-02)
		{
			print OUT1 "$Gene\t$H1_Background\t$H1_Foreground\t";
			$H1count++;
			if (exists $EffectorVector{$Gene})
			{
				print OUT1 "YES\n";
				$H1ecount++;
			}
			elsif(! exists $EffectorVector{$Gene})
			{
				print OUT1 "NO\n";
			}
#			print "Hi\n";
		}
		if ($LRT1 > 1.9985E-02 && $LRT2 <= 2.1097E-02 && $LRT3 > 1.7678E-02 && $LRT4 > 1.5298E-02)
		{
			print OUT2 "$Gene\t$H2_Background\t$H2_Foreground\t";
			$H2count++;
			if (exists $EffectorVector{$Gene})
			{
				print OUT2 "YES\n";
				$H2ecount++;
			}
			elsif(! exists $EffectorVector{$Gene})
			{
				print OUT2 "NO\n";
			}
		}
		if ($LRT1 <= 1.9985E-02 && $LRT2 <= 2.1097E-02 && $LRT3 > 1.7678E-02 && $LRT4 > 1.5298E-02)
		{
			print OUT5 "$Gene\t$H1_Background\t$H1_Foreground\t$H2_Background\t$H2_Foreground\t";
			$H1H2count++;
			if (exists $EffectorVector{$Gene})
			{
				print OUT5 "YES\n";
				$H1H2ecount++;
			}
			elsif(! exists $EffectorVector{$Gene})
			{
				print OUT5 "NO\n";
			}
		}
		if ($LRT1 > 1.9985E-02 && $LRT2 > 2.1097E-02 && $LRT3 <= 1.7678E-02 && $LRT4 > 1.5298E-02)
		{
			print OUT3 "$Gene\t$H1_ProportionSites\t";
			$H1Sitescount++;
			if (exists $EffectorVector{$Gene})
			{
				print OUT3 "YES\n";
				$H1eSitescount++;
			}
			elsif(! exists $EffectorVector{$Gene})
			{
				print OUT3 "NO\n";
			}
		}
		if ($LRT1 > 1.9985E-02 && $LRT2 > 2.1097E-02 && $LRT3 > 1.7678E-02 && $LRT4 <= 1.5298E-02)
		{
			print OUT4 "$Gene\t$H2_ProportionSites\t";
			$H2Sitescount++;
			if (exists $EffectorVector{$Gene})
			{
				print OUT4 "YES\n";
				$H2eSitescount++;
			}
			elsif(! exists $EffectorVector{$Gene})
			{
				print OUT4 "NO\n";
			}
		}
		if ($LRT1 > 1.9985E-02 && $LRT2 > 2.1097E-02 && $LRT3 <= 1.7678E-02 && $LRT4 <= 1.5298E-02)
		{
			print OUT6 "$Gene\t$H1_ProportionSites\t$H2_ProportionSites\t";
			$H1SitesH2Sitescount++;
			if (exists $EffectorVector{$Gene})
			{
				print OUT6 "YES\n";
				$H1eSitesH2eSitescount++;
			}
			elsif(! exists $EffectorVector{$Gene})
			{
				print OUT6 "NO\n";
			}
		}
		if ($LRT1 <= 1.9985E-02 && $LRT2 > 2.1097E-02 && $LRT3 <= 1.7678E-02 && $LRT4 > 1.5298E-02)
		{
			print OUT7 "$Gene\t$H1_Background\t$H1_Foreground\t$H1_ProportionSites\t";
			$H1H1Sitescount++;
			if (exists $EffectorVector{$Gene})
			{
				print OUT7 "YES\n";
				$H1H1Sitescounte++;
			}
			elsif(! exists $EffectorVector{$Gene})
			{
				print OUT7 "NO\n";
			}
		}
		if ($LRT1 <= 1.9985E-02 && $LRT2 > 2.1097E-02 && $LRT3 > 1.7678E-02 && $LRT4 <= 1.5298E-02)
		{
			print OUT8 "$Gene\t$H1_Background\t$H1_Foreground\t$H2_ProportionSites\t";
			$H1H2Sitescount++;
			if (exists $EffectorVector{$Gene})
			{
				print OUT8 "YES\n";
				$H1H2Sitescounte++;
			}
			elsif(! exists $EffectorVector{$Gene})
			{
				print OUT8 "NO\n";
			}
		}
		if ($LRT1 > 1.9985E-02 && $LRT2 <= 2.1097E-02 && $LRT3 <= 1.7678E-02 && $LRT4 > 1.5298E-02)
		{
			print OUT9 "$Gene\t$H2_Background\t$H2_Foreground\t$H1_ProportionSites\t";
			$H2H1Sitescount++;
			if (exists $EffectorVector{$Gene})
			{
				print OUT9 "YES\n";
				$H2H1Sitescounte++;
			}
			elsif(! exists $EffectorVector{$Gene})
			{
				print OUT9 "NO\n";
			}
		}
		if ($LRT1 > 1.9985E-02 && $LRT2 <= 2.1097E-02 && $LRT3 > 1.7678E-02 && $LRT4 <= 1.5298E-02)
		{
			print OUT10 "$Gene\t$H2_Background\t$H2_Foreground\t$H2_ProportionSites\t";
			$H2H2Sitescount++;
			if (exists $EffectorVector{$Gene})
			{
				print OUT10 "YES\n";
				$H2H2Sitescounte++;
			}
			elsif(! exists $EffectorVector{$Gene})
			{
				print OUT10 "NO\n";
			}
		}
		if ($LRT1 <= 1.9985E-02 && $LRT2 <= 2.1097E-02 && $LRT3 <= 1.7678E-02 && $LRT4 > 1.5298E-02)
		{
			print OUT11 "$Gene\t$H1_Background\t$H1_Foreground\t$H2_Background\t$H2_Foreground\t$H1_ProportionSites\t";
			$H1H2H1Sitescount++;
			if (exists $EffectorVector{$Gene})
			{
				print OUT11 "YES\n";
				$H1H2H1Sitescounte++;
			}
			elsif(! exists $EffectorVector{$Gene})
			{
				print OUT11 "NO\n";
			}
		}
		if ($LRT1 <= 1.9985E-02 && $LRT2 <= 2.1097E-02 && $LRT3 > 1.7678E-02 && $LRT4 <= 1.5298E-02)
		{
			print OUT12 "$Gene\t$H1_Background\t$H1_Foreground\t$H2_Background\t$H2_Foreground\t$H2_ProportionSites\t";
			$H1H2H2Sitescount++;
			if (exists $EffectorVector{$Gene})
			{
				print OUT12 "YES\n";
				$H1H2H2Sitescounte++;
			}
			elsif(! exists $EffectorVector{$Gene})
			{
				print OUT12 "NO\n";
			}
		}
		if ($LRT1 <= 1.9985E-02 && $LRT2 > 2.1097E-02 && $LRT3 <= 1.7678E-02 && $LRT4 <= 1.5298E-02)
		{
			print OUT13 "$Gene\t$H1_Background\t$H1_Foreground\t$H1_ProportionSites\t$H2_ProportionSites\t";
			$H1H1SitesH2Sitescount++;
			if (exists $EffectorVector{$Gene})
			{
				print OUT13 "YES\n";
				$H1H1SitesH2Sitescounte++;
			}
			elsif(! exists $EffectorVector{$Gene})
			{
				print OUT13 "NO\n";
			}
		}
		if ($LRT1 > 1.9985E-02 && $LRT2 <= 2.1097E-02 && $LRT3 <= 1.7678E-02 && $LRT4 <= 1.5298E-02)
		{
			print OUT14 "$Gene\t$H2_Background\t$H2_Foreground\t$H1_ProportionSites\t$H2_ProportionSites\t";
			$H2H1SitesH2Sitescount++;
			if (exists $EffectorVector{$Gene})
			{
				print OUT14 "YES\n";
				$H2H1SitesH2Sitescounte++;
			}
			elsif(! exists $EffectorVector{$Gene})
			{
				print OUT14 "NO\n";
			}
		}
		if ($LRT1 <= 1.9985E-02 && $LRT2 <= 2.1097E-02 && $LRT3 <= 1.7678E-02 && $LRT4 <= 1.5298E-02)
		{
			print OUT15 "$Gene\t$H1_Background\t$H1_Foreground\t$H2_Background\t$H2_Foreground\t$H1_ProportionSites\t$H2_ProportionSites\t";
			$H1H2H1SitesH2Sitescount++;
			if (exists $EffectorVector{$Gene})
			{
				print OUT15 "YES\n";
				$H1H2H1SitesH2Sitescounte++;
			}
			elsif(! exists $EffectorVector{$Gene})
			{
				print OUT15 "NO\n";
			}
		}
		}
	}
}
$TotalTests = ($H1Applied + $H2Applied + $H1SitesApplied + $H2SitesApplied);
$TotalSigThings = ($H1count + $H2count + (2 * $H1H2count) + $H1Sitescount + $H2Sitescount + (2 * $H1SitesH2Sitescount) + (2 * $H1H1Sitescount) + (2 * $H1H2Sitescount) + (2 * $H2H1Sitescount) + (2 * $H2H2Sitescount) + (3 * $H1H2H1Sitescount) + (3 * $H1H2H2Sitescount) + (3 * $H1H1SitesH2Sitescount) + (3 * $H2H1SitesH2Sitescount) + (4 * $H1H2H1SitesH2Sitescount));
$SigH1 = ($H1count + $H1H2count + $H1H1Sitescount + $H1H2Sitescount + $H1H2H1Sitescount + $H1H2H2Sitescount + $H1H1SitesH2Sitescount + $H1H2H1SitesH2Sitescount);
$SigH2 = ($H2count + $H1H2count + $H2H1Sitescount + $H2H2Sitescount + $H1H2H1Sitescount + $H1H2H2Sitescount + $H2H1SitesH2Sitescount + $H1H2H1SitesH2Sitescount);
$SigH1Sites = ($H1Sitescount + $H1SitesH2Sitescount + $H1H1Sitescount + $H2H1Sitescount + $H1H2H1Sitescount + $H1H1SitesH2Sitescount + $H2H1SitesH2Sitescount + $H1H2H1SitesH2Sitescount);
$SigH2Sites = ($H2Sitescount + $H1SitesH2Sitescount + $H1H2Sitescount + $H2H2Sitescount + $H1H2H2Sitescount + $H1H1SitesH2Sitescount + $H2H1SitesH2Sitescount + $H1H2H1SitesH2Sitescount);
close FH2;
print OUT99 "Total Number of Families: $Totalcount\nNumber Ran H1: $H1Applied\nNumber Ran H2: $H2Applied\nNumber Ran H1Sites: $H1SitesApplied\nNumber Ran H2Sites: $H2SitesApplied\n\n";
print OUT99 "Total Number of Test: $TotalTests\nTotal Number of Significant Tests at FDR=0.05: $TotalSigThings\n";
print OUT99 "Significant H1: $SigH1\nSignificant H2: $SigH2\nSignificant H1 Sites: $SigH1Sites\nSignificant H2 Sites: $SigH2Sites\n\n";
print OUT99 "HYPOTHESIS\tNUMBER_SIGNIFICANT\tNUMBER_EFFECTORS\n";
print OUT99 "H1\t$H1count\t$H1ecount\n";
print OUT99 "H2\t$H2count\t$H2ecount\n";
print OUT99 "H1 and H2\t$H1H2count\t$H1H2ecount\n";
print OUT99 "H1 Sites\t$H1Sitescount\t$H1eSitescount\n";
print OUT99 "H2 Sites\t$H2Sitescount\t$H2eSitescount\n";
print OUT99 "H1 Sites and H2 Sites\t$H1SitesH2Sitescount\t$H1eSitesH2eSitescount\n";
print OUT99 "H1 and H1 Sites\t$H1H1Sitescount\t$H1H1Sitescounte\n";
print OUT99 "H1 and H2 Sites\t$H2H1Sitescount\t$H2H1Sitescounte\n";
print OUT99 "H2 and H1 Sites\t$H2H1Sitescount\t$H2H1Sitescounte\n";
print OUT99 "H2 and H2 Sites\t$H2H2Sitescount\t$H2H2Sitescounte\n";
print OUT99 "H1 and H2 and H1 Sites\t$H1H2H1Sitescount\t$H1H2H1Sitescounte\n";
print OUT99 "H1 and H2 and H2 Sites\t$H1H2H2Sitescount\t$H1H2H2Sitescounte\n";
print OUT99 "H1 and H1 Sites and H2 Sites\t$H1H1SitesH2Sitescount\t$H1H1SitesH2Sitescounte\n";
print OUT99 "H2 and H1 Sites and H2 Sites\t$H2H1SitesH2Sitescount\t$H2H1SitesH2Sitescounte\n";
print OUT99 "H1 and H2 and H1 Sites and H2 Sites\t$H1H2H1SitesH2Sitescount\t$H1H2H1SitesH2Sitescounte\n";
exit;
		