#!/usr/bin/perl
use warnings;
#----------------------------------------------------------------------------------------#
#Some notes
#calculate dN and dS for known GY94 model params and eq freqs
#eq freqs are assumed equal here
#All parameters are fixed within this file
#----------------------------------------------------------------------------------------#


#----------------------------------------------------------------------------------------#
#User Param settings
$w = 0.2; #omega is global 0.2
$k = 2; #kappa 2 for simulations
$t = 0.01268182;
#----------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------#
%Translations = ();
%Codons = (); #A hash of arrays is still declared as a hash
%GY94 = ();
#Read in translation table for constructing GY94 Q
open FH1, '<', "translations61.txt";
while (<FH1>)
{
	if (/(\S+)\s+(\S+)/)
	{
		$codon = $1;
		$aa = $2;
		$Translations{$codon} = $aa;
		
		@tempCodon = ();
		@tempCodon = split//,$codon;
		@{$Codons{$codon}} = @tempCodon;
#		print "@tempCodon\n";
#		print "$codon\n";
#		print "$Codons{$codon}[0]\n";
	}
}
close FH1;

#Construct the GY94 Q using known params 
foreach $i (sort keys %Translations)
{
	foreach $j (sort keys %Translations)
	{
		if ($i eq $j)
		{
			$GY94{$i}{$j} = 0;
		}
		elsif ($i ne $j)
		{
			$diff = 0;
			for $k (0..2)
			{
				if ($Codons{$i}[$k] ne $Codons{$j}[$k])
				{
					$diff++;
					$base1 = $Codons{$i}[$k];
					$base2 = $Codons{$j}[$k];
				}
				else {}
			}
			if ($diff == 1)
			{
				if ($Translations{$i} eq $Translations{$j})
				{
					if ($base1 eq "A" && $base2 eq "G" || $base1 eq "C" && $base2 eq "T" || $base1 eq "G" && $base2 eq "A" || $base1 eq "T" && $base2 eq "C")
					{
						$GY94{$i}{$j} = $k * $t;
					}
					else
					{
						$GY94{$i}{$j} = $t;
					}
				}
				
				elsif ($Translations{$i} ne $Translations{$j})
				{
					if ($base1 eq "A" && $base2 eq "G" || $base1 eq "C" && $base2 eq "T" || $base1 eq "G" && $base2 eq "A" || $base1 eq "T" && $base2 eq "C")
					{
						$GY94{$i}{$j} = $w * $k * $t;
					}
					else
					{
						$GY94{$i}{$j} = $w * $t;
					}
				}
			}
			elsif ($diff == 2 || $diff == 3) 
			{
				$GY94{$i}{$j} = 0;
			}	
		}
	}
}

#Go back and retrieve the diagonals
foreach $i (sort keys %Translations)
{
	foreach $j (sort keys %Translations)
	{
		if ($i ne $j)
		{
			$GY94{$i}{$i} = $GY94{$i}{$i} - $GY94{$i}{$j};
		}
	}
}

#----------------------------------------------------------------------------------------#
#Print out 61x61 Q to check calculations - i.e. diagonals are -Sum(Other Row Entries)
open OUT1, '>', "GY94.txt";
print OUT1 "\t";
foreach $i (sort keys %Translations)
{
	print OUT1 "$i\t";
#	print "$i\n";
}
print OUT1 "\n";
foreach $i (sort keys %Translations)
{
	print OUT1 "$i\t";
	foreach $j (sort keys %Translations)
	{
		print OUT1 "$GY94{$i}{$j}\t";
	}
	print OUT1 "\n";
}
#----------------------------------------------------------------------------------------#

#----------------------------------------------------------------------------------------#
#Initiate values for observations
$S = 0.0;
$N = 0.0;
$Sd = 0.0;
$Sd_scaled = 0.0;
$Nd = 0.0;
$Nd_scaled = 0.0;
$pS = 0.0;
$pN = 0.0;
#Initiate values for expectations under w = 1
$S_1 = 0.0;
$N_1 = 0.0;
$Sd_1 = 0.0;
$Sd_scaled_1 = 0.0;
$Nd_1 = 0.0;
$Nd_scaled_1 = 0.0;
$pS_1 = 0.0;
$pN_1 = 0.0;
#initiate values for dN, dS, and dN/dS
$dS = 0.0;
$dN = 0.0;
$dnds = 0.0;

#Find raw Sd and Nd
#0.016393 is for equal codon frequencies after correcting for the 3 stop codons
foreach $i (sort keys %Translations)
{
	foreach $j (sort keys %Translations)
    {
    	if ($i ne $j)
        {
            if ($Translations{$i} eq $Translations{$j})
            {
                $Sd = $Sd + (0.016393 * $GY94{$i}{$j});
            }
            if ($Translations{$i} ne $Translations{$j})
            {
    	    	$Nd = $Nd + (0.016393 * $GY94{$i}{$j});
            }
        }
    }
}

$Scaling = ($Sd / $t) + ($Nd / $t);
$Sd_scaled = $Sd / $Scaling;
$Nd_scaled = $Nd / $Scaling;
$pS = $Sd_scaled / $t;
$pN = $Nd_scaled / $t;
$S = (3 * $pS);
$N = (3 * $pN);

#Fix omega to 1 to get the definition of synonymous and nonsynonymous sites
$wfix = 1;
#reconstruct Q
foreach $i (sort keys %Translations)
{
	foreach $j (sort keys %Translations)
	{
		if ($i eq $j)
		{
			$GY94{$i}{$j} = 0;
		}
		elsif ($i ne $j)
		{
			$diff = 0;
			for $k (0..2)
			{
				if ($Codons{$i}[$k] ne $Codons{$j}[$k])
				{
					$diff++;
					$base1 = $Codons{$i}[$k];
					$base2 = $Codons{$j}[$k];
				}
				else {}
			}
			if ($diff == 1)
			{
				if ($Translations{$i} eq $Translations{$j})
				{
					if ($base1 eq "A" && $base2 eq "G" || $base1 eq "C" && $base2 eq "T" || $base1 eq "G" && $base2 eq "A" || $base1 eq "T" && $base2 eq "C")
					{
						$GY94{$i}{$j} = $k * $t;
					}
					else
					{
						$GY94{$i}{$j} = $t;
					}
				}
				
				elsif ($Translations{$i} ne $Translations{$j})
				{
					if ($base1 eq "A" && $base2 eq "G" || $base1 eq "C" && $base2 eq "T" || $base1 eq "G" && $base2 eq "A" || $base1 eq "T" && $base2 eq "C")
					{
						$GY94{$i}{$j} = $wfix * $k * $t;
					}
					else
					{
						$GY94{$i}{$j} = $wfix * $t;
					}
				}
			}
			elsif ($diff == 2 || $diff == 3) 
			{
				$GY94{$i}{$j} = 0;
			}	
		}
	}
}
#Go back and retrieve the diagonals
foreach $i (sort keys %Translations)
{
	foreach $j (sort keys %Translations)
	{
		if ($i ne $j)
		{
			$GY94{$i}{$i} = $GY94{$i}{$i} - $GY94{$i}{$j};
		}
	}
}

# And get the synonymous and nonsynonymous sites
foreach $i (sort keys %Translations)
{
	foreach $j (sort keys %Translations)
	{
		if ($i ne $j)
		{
            if ($Translations{$i} eq $Translations{$j})
            {
                $Sd_1 = $Sd_1 + (0.016393 * $GY94{$i}{$j});
            }
            if ($Translations{$i} ne $Translations{$j})
            {
    	    	$Nd_1 = $Nd_1 + (0.016393 * $GY94{$i}{$j});
            }
		}
	}
}

$Scaling_1 = ($Sd_1 / $t) + ($Nd_1 / $t);
$Sd_scaled_1 = $Sd_1 / $Scaling_1;
$Nd_scaled_1 = $Nd_1 / $Scaling_1;
$pS_1 = $Sd_scaled_1 / $t;
$pN_1 = $Nd_scaled_1 / $t;
$S_1 = (3 * $pS_1);
$N_1 = (3 * $pN_1);

#Finally, get the true dS from the patristic distance
$dS = ($Sd_scaled/$S_1);
$dN = ($Nd_scaled/$N_1);
$dnds = ($dN/$dS);
#----------------------------------------------------------------------------------------#
print "Starting parameters:\nt\t$t\nw\t$w\nk\t$k\n\n";
print "Calculations under parameters for GY94 with equal 3x4 eq freqs\n";
print "Proportion of synonymous sites $pS\n";
print "Proportion of nonsynonymous sites $pN\n";
print "dS\t$dS\ndN\t$dN\nomega\t$dnds\n";				
exit;