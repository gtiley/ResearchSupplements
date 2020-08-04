#!/usr/bin/perl
use warnings;
#NOTES
#---------------------------------------------------------------------------------------#
#This script reads through multiple aligned fasta files and concatenates them
#Missing data is inserted for missing taxa in each alignment
#All files need to be in the same folder as this script
#---------------------------------------------------------------------------------------#
#USER VARIABLES
#---------------------------------------------------------------------------------------#
#Define what character you would like to insert for missing data
$insert = "N";
#Name the output file
$concat_file = "$ARGV[0]";
#Name the log file, this tracks the number of taxa in each alignment and missing data
$concat_log = "$ARGV[1]";
#Get a partition file for raxml too!
$partition_file = "$ARGV[2]";

#$pathToFastas = "$ARGV[3]";
#---------------------------------------------------------------------------------------#

###
#collect fasta files from another location
@fastaFiles = glob("*.fasta");
###

open OUT1, ">$concat_file";
open OUT2, ">$concat_log";
open OUT3, ">$partition_file";
print OUT2 "TAXON\tMISSING_GENES\t\%_MISSING_GENES\t\%_MISSING_DATA\n";
%alltax = ();
%allgenes = ();
%allhash = ();
%misshash = ();
@gene_array = ();
$total_len = 0;
foreach $ff (@fastaFiles)
{
	if ($ff =~ m/((\S+)\.fasta)/)
	{
		$file = $1;
		$gene = $2;
		push @gene_array, $gene;
		if (! exists $allgenes{$gene})
		{
			$allgenes{$gene} = 1;
		}
		open FH2,'<',"$file";
		while (<FH2>)
		{
			if (/\>(\S+)/)
			{
			    $taxon = $1;
			    $taxon =~ s/\__\S+//;
			    $taxon =~ s/\.\S+//;
				if (! exists $alltax{$taxon})
				{
					$alltax{$taxon} = 1;
				}
			}
			elsif (/(\S+)/)
			{
				$allhash{$taxon}{$gene} = $1;
				if (! exists $misshash{$gene})
				{
					$misshash{$gene} = length ($allhash{$taxon}{$gene});
				}
				elsif (exists $misshash{$gene})
				{
					if ($misshash{$gene} < length ($allhash{$taxon}{$gene}))
					{
						$misshash{$gene} = length ($allhash{$taxon}{$gene});
					}
				}
			}
		}
		$total_len = $total_len + $misshash{$gene};
		close FH2,
	}
}

print "$total_len\n";
$Ngenes = scalar @gene_array;
%missing_data = ();
foreach $TAX (keys %alltax)
{
	print OUT1 ">$TAX\n";
	print OUT2 "$TAX\t";
	$miss_gene_count = 0;
	$miss_data_count = 0;
	foreach $GENE (keys %allgenes)
	{
		if (! exists $allhash{$TAX}{$GENE})
		{
			$miss_gene_count++;
			for (0..(($misshash{$GENE})-1))
			{
				print OUT1 "$insert";
				$miss_data_count++;
			}
		}
		if (exists $allhash{$TAX}{$GENE})
		{
			print OUT1 "$allhash{$TAX}{$GENE}";
		}
	}
	print OUT1 "\n";
	$missing_genes = ($miss_gene_count / $Ngenes) * 100;
	$missing_data = ($miss_data_count / $total_len) * 100;
	print OUT2 "$miss_gene_count\t$missing_genes\t$missing_data\n";
}	
close OUT1;
close OUT2;


$start = 0;
foreach $gene (keys %misshash)
{
	$begin = ($start + 1);
	$end = ($begin + ($misshash{$gene} - 1));
	print OUT3 "DNA, $gene = $begin-$end\n";
	if ($start < ($total_len + 1))
	{
		$start = $end;
	}
	
	print "$begin\t$end\n";
}
close OUT3;
exit;
