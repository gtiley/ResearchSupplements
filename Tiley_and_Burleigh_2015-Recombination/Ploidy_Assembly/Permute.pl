#!/usr/bin/perl -w

open FH1, "<PermutingPloidy.txt";
%Cs = ();
%Rs = ();
%Ms = ();
%res = ();
while (<FH1>)
{
	$Line = $_;
	chomp $Line;
#	print "$Line\n";
	if ($Line !~ m/GenusSpecies.+/)
	{
		$Ploidies = 0;
		if ($Line =~ m/(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)\s+(\S+)/)
		{
			$Species = $1;
			$MB = $2;
			$C1 = $3;
			$C2 = $4;
			$C3 = $5;
			$Map = $6;
			$Ms{$Species} = ($MB);
#			print "$Species\n";
			
			if ($C1 !~ m/NA/)
			{
				$Ploidies++;
				$res{$Species} = $Ploidies;
				$Cs{$Species}{$Ploidies} = $C1;
				$Rs{$Species}{$Ploidies} = ($Map/$C1);
			}
			if ($C2 !~ m/NA/)
			{
				$Ploidies++;
				$res{$Species} = $Ploidies;
				$Cs{$Species}{$Ploidies} = $C2;
				$Rs{$Species}{$Ploidies} = ($Map/$C2);
			}
			if ($C3 !~ m/NA/)
			{
				$Ploidies++;
				$res{$Species} = $Ploidies;
				$Cs{$Species}{$Ploidies} = $C3;
				$Rs{$Species}{$Ploidies} = ($Map/$C3);
			}
		}
	}
}

for (0..99)
{
	$num = $_;
	open OUT1, ">cM_C.C.$num.txt";
	open OUT2, ">cM_C.Mb.$num.txt";
	print OUT1 "SPECIES\tRRate\tSIZE\n";
	print OUT2 "SPECIES\tRRate\tSIZE\n";
	foreach $SPECIES (keys %Ms)
	{
		if (exists $res{$SPECIES})
		{
			$i = $res{$SPECIES};
			$rnum = int(rand($i)) + 1;
			print OUT1 "$SPECIES\t$Rs{$SPECIES}{$rnum}\t$Cs{$SPECIES}{$rnum}\n";
			print OUT2 "$SPECIES\t$Rs{$SPECIES}{$rnum}\t$Ms{$SPECIES}\n";
		}
	}
	close OUT1;
	close OUT2;	
}	
exit;				