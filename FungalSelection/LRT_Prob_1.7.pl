#!/usr/bin/perl -w
#use warnings;
use Statistics::Distributions;
%OneRateLik = ();
%BurstLik = ();
%TwoRateLik = ();
%OneRateDNDS = ();
%BurstDNDS = ();
%TwoRateDNDS = ();
%GeneHash = ();

%NullBurstLik = ();
%AltBurstLik = ();
%AltBurst1 = ();
%AltBurst2 = ();

%NullTwoLik = ();
%AltTwoLik = ();
%AltTwo1 = ();
%AltTwo2 = ();

#----------------------------------------------
open FH2000, '<', 'CQF_EffectorVector.txt';
%EffectorVector = ();
while (<FH2000>)
{
	if (/(\d+)/)
	{
		$EffectorID = $1;
		$EffectorVector{$EffectorID} = 0;
	}
}
close FH2000;
#----------------------------------------------


open OUT1, ">CQF_RatesOut_PreFilter.txt";
system 'ls *.H0.out > RateFiles';
open FH1, "<RateFiles";
while (<FH1>)
{
#Get Single rate lnL and dN/dS
	if (/((\S+)\.H0\.out)/)
	{
		$File = $1;
		$Gene = $2;
		if (!exists $GeneHash{$Gene})
		{
			$GeneHash{$Gene} = 1;
		}
		open FH2, "$File";
		while (<FH2>)
		{
			$line = $_;
			if ($line =~ m/lnL\(ntime\:\s+\d+\s+np:\s+\d+\)\:\s+(-\d+\.\d+)/)
			{
				$OneRate_Lik = $1;
				$OneRateLik{$Gene} = $OneRate_Lik;
			}
			if ($line !~ m/omega\s+\(dN\/dS\)\s+\=\s+(\d+\.\d+)/)
			{
				$Null_Omega = $1;
				$OneRateDNDS{$Gene} = $Null_Omega;
			}
		}
		close FH2;
		#Get Two rate lnL and dN/dS for cqf and non-cqf	
		open FH3, "$Gene.H1.out";
		while (<FH3>)
		{
			$line = $_;
			if ($line =~ m/lnL\(ntime\:\s+\d+\s+np:\s+\d+\)\:\s+(-\d+\.\d+)/)
			{
				$Burst_Lik = $1;
				$BurstLik{$Gene} = $Burst_Lik;
			}
			if ($line !~ m/w\s+\(dN\/dS\)\s+for\s+branches\:\s+(\d+\.\d+)\s+(\d+\.\d+)/)
			{
				$Null_Omega = $1;
				$Alt_Omega = $2;
				$BurstDNDS{$Gene}{Background} = $Null_Omega;
				$BurstDNDS{$Gene}{Foreground} = $Alt_Omega;
			}
		}
		close FH3;
		open FH4, "$Gene.H2.out";
		while (<FH4>)
		{
			$line = $_;
			if ($line =~ m/lnL\(ntime\:\s+\d+\s+np:\s+\d+\)\:\s+(-\d+\.\d+)/)
			{
				$TwoRate_Lik = $1;
				$TwoRateLik{$Gene} = $TwoRate_Lik;
			}
			if ($line !~ m/w\s+\(dN\/dS\)\s+for\s+branches\:\s+(\d+\.\d+)\s+(\d+\.\d+)/)
			{
				$Null_Omega = $1;
				$Alt_Omega = $2;
				$TwoRateDNDS{$Gene}{Background} = $Null_Omega;
				$TwoRateDNDS{$Gene}{Foreground} = $Alt_Omega;
#				print "$Alt_Omega\n\n";
			}
		}
		close FH4;
		open FH5, "$Gene.H1.NullSites.out";
		while (<FH5>)
		{
			$line = $_;
			if ($line =~ m/lnL\(ntime\:\s+\d+\s+np:\s+\d+\)\:\s+(-\d+\.\d+)/)
			{
				$NullBurst_Lik = $1;
				$NullBurstLik{$Gene} = $NullBurst_Lik;
			}
		}
		close FH5;
		open FH6, "$Gene.H1.PositiveSites.out";
		while (<FH6>)
		{
			$line = $_;
			if ($line =~ m/lnL\(ntime\:\s+\d+\s+np:\s+\d+\)\:\s+(-\d+\.\d+)/)
			{
				$AltBurst_Lik = $1;
				$AltBurstLik{$Gene} = $AltBurst_Lik;
			}
			if ($line =~ m/proportion\s+\d+\.\d+\s+\d+\.\d+\s+(\d+\.\d+)\s+(\d+\.\d+)/)
			{
				$AltBurst1{$Gene} = $1;
				$AltBurst2{$Gene} = $2;
			}
		}
		close FH6;
		open FH7, "$Gene.H2.NullSites.out";
		while (<FH7>)
		{
			$line = $_;
			if ($line =~ m/lnL\(ntime\:\s+\d+\s+np:\s+\d+\)\:\s+(-\d+\.\d+)/)
			{
				$NullTwo_Lik = $1;
				$NullTwoLik{$Gene} = $NullTwo_Lik;
			}
		}
		close FH7;
		open FH8, "$Gene.H2.PositiveSites.out";
		while (<FH8>)
		{
			$line = $_;
			if ($line =~ m/lnL\(ntime\:\s+\d+\s+np:\s+\d+\)\:\s+(-\d+\.\d+)/)
			{
				$AltTwo_Lik = $1;
				$AltTwoLik{$Gene} = $AltTwo_Lik;
			}
			if ($line =~ m/proportion\s+\d+\.\d+\s+\d+\.\d+\s+(\d+\.\d+)\s+(\d+\.\d+)/)
			{
				$AltTwo1{$Gene} = $1;
				$AltTwo2{$Gene} = $2;
			}
		}
		close FH8;
	}
}
print OUT1 "Gene\tEffector\tH0_lnL\tH1_lnL\tH2_lnL\tH0_Global_dN/dS\tH1_Background_dN/dS\tH1_Foreground_dN/dS\tH2_Background_dN/dS\tH2_Foreground_dN/dS\tH1_ConstrainSites_lnL\tH1_PositiveSites_lnL\tH1_PositiveClass1\tH1_PositiveClass2\tH2_ConstrainSites_lnL\tH2_PositiveSites_lnL\tH2_PositiveClass1\tH2_PositiveClass2\tLRT1(H1_vs_H0)\tLRT2(H2_vs_H0)\tLRT3(H1_PositiveSites_vs_H1_ConstrainSites)\tLRT4(H2_PositiveSites_vs_H2_ConstrainSites)\n";
foreach $GENE (keys %GeneHash)
{
	if (exists $OneRateLik{$GENE})
	{
		print OUT1 "$GENE\t";
		if (exists $EffectorVector{$GENE})
		{
			print OUT1 "YES\t";
		}
		if (! exists $EffectorVector{$GENE})
		{
			print OUT1 "NO\t";
		}
		print OUT1 "$OneRateLik{$GENE}\t";
		if (exists $BurstLik{$GENE})
		{
			print OUT1 "$BurstLik{$GENE}\t$TwoRateLik{$GENE}\t$OneRateDNDS{$GENE}\t$BurstDNDS{$GENE}{Background}\t$BurstDNDS{$GENE}{Foreground}\t$TwoRateDNDS{$GENE}{Background}\t$TwoRateDNDS{$GENE}{Foreground}\t$NullBurstLik{$GENE}\t$AltBurstLik{$GENE}\t$AltBurst1{$GENE}\t$AltBurst2{$GENE}\t$NullTwoLik{$GENE}\t$AltTwoLik{$GENE}\t$AltTwo1{$GENE}\t$AltTwo2{$GENE}\t";
			$LRT1 = (2 * ($BurstLik{$GENE} - $OneRateLik{$GENE}));	
			$LRT2 = (2 * ($TwoRateLik{$GENE} - $OneRateLik{$GENE}));
			$LRT3 = (2 * ($AltBurstLik{$GENE} - $NullBurstLik{$GENE}));
			$LRT4 = (2 * ($AltTwoLik{$GENE} - $NullTwoLik{$GENE}));
			$ChiProb1 = Statistics::Distributions::chisqrprob (1, $LRT1);
			$ChiProb2 = Statistics::Distributions::chisqrprob (1, $LRT2);
			$ChiProb3 = Statistics::Distributions::chisqrprob (1, $LRT3);
			$ChiProb4 = Statistics::Distributions::chisqrprob (1, $LRT4);
			print OUT1 "$ChiProb1\t$ChiProb2\t$ChiProb3\t$ChiProb4\n";
		}
		elsif (! exists $BurstLik{$GENE})
		{
			print OUT1 "NA\t$TwoRateLik{$GENE}\t$OneRateDNDS{$GENE}\tNA\tNA\t$TwoRateDNDS{$GENE}{Background}\t$TwoRateDNDS{$GENE}{Foreground}\tNA\tNA\tNA\tNA\t$NullTwoLik{$GENE}\t$AltTwoLik{$GENE}\t$AltTwo1{$GENE}\t$AltTwo2{$GENE}\t";
			$LRT2 = (2 * ($TwoRateLik{$GENE} - $OneRateLik{$GENE}));
			$LRT4 = (2 * ($AltTwoLik{$GENE} - $NullTwoLik{$GENE}));
			$ChiProb2 = Statistics::Distributions::chisqrprob (1, $LRT2);
			$ChiProb4 = Statistics::Distributions::chisqrprob (1, $LRT4);
			print OUT1 "NA\t$ChiProb2\tNA\t$ChiProb4\n";
		}	
	}
}
close OUT1;
close FH1;
unlink "RateFiles";
exit;			