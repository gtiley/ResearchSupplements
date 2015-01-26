#/usr/bin/perl                                                                                                                                                   
use warnings;
use File::Copy qw(copy);
system 'ls *.codonalign.fasta> codondatafiles.txt';
open FH1, "<codondatafiles.txt";

while (<FH1>)
{
    if (/((\S+)\.codonalign\.fasta)/)
    {
        $File = $1;
        $Gene = $2;
	copy "MG94_REV_3x4.mdl","$Gene.MG94_REV_3x4.mdl";
        @TaxArray = ();
        open FH2, "$File";
        while (<FH2>)
        {
        	if (/>(Cqf\S+)/)
        	{
        		$CqfTax = $1;
        		push @TaxArray, $CqfTax;
        	}
        	elsif (/>(\S+)/)
        	{
        		$NotCqfTax = $1;
        		push @TaxArray, $NotCqfTax;
        	}
        }		
        open FH3, "<$Gene.NamedNodes.tre";
		while (<FH3>)
		{
	    	$tree = $_;
	    	$tree =~ s/NOTCQFNODE_0//;
		}
		open FH4, "<$Gene.NodeList.txt";
		while (<FH4>)
		{
			if (/(NOTCQFNODE\S+)/)
			{
				$NotCqfNode = $1;
				if ($NotCqfNode ne "NOTCQFNODE_0")
				{
					push @TaxArray, $NotCqfNode;
				}
			}
			elsif (/(CQFNODE\S+)/) 
			{
				$CqfNode = $1;
				push @TaxArray, $CqfNode;
			}
		}
		$Tax_N = scalar @TaxArray;
	    open OUT1, ">$Gene.MG94xGTRgamma.bf";

print OUT1 "/*This batch file uses Sergei''s function to build a likelihood*/

//Variable declaration
//OPTIMIZATION_PRECISION = 0.000001;
//VERBOSITY_LEVEL = 10;
LIKELIHOOD_FUNCTION_OUTPUT = 1;
//RANDOM_STARTING_PERTURBATIONS = 1;
//MAXIMUM_ITERATIONS_PER_VARIABLE = 100000;

// Define genetic code

LoadFunctionLibrary (\"chooseGeneticCode\", {\"0\":\"Universal\"}); 
// this call will populate _Genetic_Code
ModelGeneticCode = _Genetic_Code;

// define \'ModelGeneticCode\' which is expected to exist when one calls MG94_REV_3x4.mdl
// the number of rate classes must be hard-coded

/* Include relevant functions */
ExecuteAFile (\"$Gene.MG94_REV_3x4.mdl\");

//Sequences

DataSet TheData = ReadDataFile (\"$File\");
DataSetFilter FilteredData= CreateFilter (TheData,3,\"\", \"\",\"TAA,TAG,TGA\");

HarvestFrequencies (observedFreq,FilteredData,3,1,1);

GUIPopulateModelMatrix(\"Matrix\",observedFreq);
/* Define the models */	
codonfreq=GUIBuildCodonFrequencies(observedFreq);

Model MG94_REV = (Matrix, codonfreq,0); 

/* Define the trees */
UseModel(MG94_REV);
Tree givenTree = $tree

/*Remove any unwanted constraints in the background*/
ClearConstraints(givenTree);
/*Constrain dN and dS before optimization*/
global taxR = 1;";
for (0..($Tax_N - 2))
{
	$i = $_;
	$j = ($i + 1);
	print OUT1"
	ReplicateConstraint(\"this1.$TaxArray[$i].nonSynRate:=taxR*this2.$TaxArray[$j].nonSynRate\", givenTree,givenTree);
	ExecuteCommands(\"givenTree.$TaxArray[$i].nonSynRate:=taxR*givenTree.$TaxArray[$j].nonSynRate\");
	ReplicateConstraint(\"this1.$TaxArray[$i].synRate:=taxR*this2.$TaxArray[$j].synRate\", givenTree,givenTree);
	ExecuteCommands(\"givenTree.$TaxArray[$i].synRate:=taxR*givenTree.$TaxArray[$j].synRate\");
	";
}
print OUT1"
/* Define the likelihood function and optimize */
LikelihoodFunction  theLnLik = (FilteredData, givenTree);

Optimize (paramValues, theLnLik);
fprintf ($Gene.SingleRate.DNDS.txt, theLnLik);";
	}
}
close OUT1;
close FH4;
close FH3;
close FH2;
close FH1;
exit;
