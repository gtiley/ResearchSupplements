#!/usr/bin/perl
#use warnings;

system 'ls *.cov > CovFiles.list';
open OUT1, ">partialCoevol_Results_20150120.txt";
open OUT2, ">paritalCoevol_Summary_20150120.txt";
open OUT3, ">partialCoevol_SigResults_20150120.txt";
print OUT2 "Positive_dNdS\tNegative_dNdS\tGeneTotal\n";
print OUT1 "GENE\tPar_RR_dS\tPar_RR_Omega\tPar_RR_dS_PP\tPar_RR_Omega_PP\tSig\n";
$PosCount = 0;
$NegCount = 0;
$TotalCount = 0;
%CorHash = ();
@GeneArray = ();
open FH1, "<CovFiles.list";
while (<FH1>)
{
	if (/((\S+)\.dsom1\.cov)/)
	{
		$CovFile = $1;
		$Gene = $2;
		@LineArray = ();
		print OUT1 "$Gene\t";
		push @GeneArray, $Gene;
		open FH2, "$CovFile";
		while (<FH2>)
		{
			$Line = $_;
			chomp $Line;
#			print "$Line\n";
			push @LineArray, $Line;
		#	print "Hi\n";
		}
		$N = scalar @LineArray;
		for(0..($N-1))
		{
			$i = $_;	
#			print "$i\n";
			if ($LineArray[$i] =~ m/partial\s+correlation\s+coefficients/)
			{
				if ($LineArray[$i+2] =~ m/\S+\s+\S+\s+(\S+)/)
				{
					$rrdsPar = $1;
					print OUT1 "$rrdsPar\t";
					if ($LineArray[$i+3] =~ m/\S+\s+\S+\s+(\S+)/)
					{
						$rromPar = $1;
						print OUT1 "$rromPar\t";    
						if ($LineArray[$i+8] =~ m/\S+\s+\S+\s+(\S+)/)
						{
							$rrdsPPP = $1;
							print OUT1 "$rrdsPPP\t";
							if ($LineArray[$i+9] =~ m/\S+\s+\S+\s+(\S+)/)
							{
								$rromPPP = $1;
								print OUT1 "$rromPPP\t";
							}
						}
					}
				}
			}
		}
		if ($rromPPP >= 0.983)
		{
			$PosCount++;
			print OUT3 "$Gene\t$rromPar\t$rromPPP\n";
		}
		if ($rromPPP <= 0.017)
		{
			$NegCount++;
			print OUT3 "$Gene\t$rromPar\t$rromPPP\n";
		}
		if ($rrdsPP >= 0.983 || $rrdsPP <= 0.017 || $rromPP >= 0.983 || $rromPP <= 0.017)
		{
			print OUT1 "*\n";
			$TotalCount++;
		}
		elsif ($rrdsPP < 0.983 && $rrdsPP > 0.017 && $rromPP < 0.983 && $rromPP > 0.017)
		{
			print OUT1 "\n";
			$TotalCount++;
		}    
		else 
		{
			print OUT1 "\n";
			$TotalCount++;
		}   	
	}
}
print OUT2 "$PosCount\t$NegCount\t$TotalCount";
close OUT1;
close OUT2;
close FH2;
close FH1;
exit;
