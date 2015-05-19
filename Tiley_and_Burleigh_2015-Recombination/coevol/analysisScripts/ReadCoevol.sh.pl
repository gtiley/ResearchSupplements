#!/usr/bin/perl
use warnings;
system 'ls *.ESS > ESSFiles.list';
open FH1, "<ESSFiles.list";
%BurninHash = ();
@GeneArray = ();
while (<FH1>)
{
    if (/((\S+)\.ESS)/)
    {
	$BadMixCount = 0;
	$ESSFile = $1;
	$Gene = $2;
	push @GeneArray, $Gene;
	open FH99, "<$Gene.dsom1.trace";
	@LineArray = ();
        while (<FH99>)
	{
	    $Line = $_;
            push @LineArray, $Line;
	}
	$Points= (scalar(@LineArray) -1);
	$Burnin= int(0.25 * $Points);
	$BurninHash{$Gene} = $Burnin;
	open FH2, "$ESSFile";
	while (<FH2>)
	{
	    if (/\S+\s+(\d+)\s+\S+/)
	    {
		$ESS = $1;
		if ($ESS < 200 && $ESS >= 50)
		{
		    $BadMixCount = $BadMixCount + 1;
		}
	    }
	}

	if ($BadMixCount != 0)
	{
		    open OUT2, ">$Gene.RestartChain1.sh";
		    open OUT3, ">$Gene.RestartChain2.sh";
		    print OUT2 "                                                                                                                       
\#!/bin/bash                                                    
\#PBS -M YOUR_EMAIL
\#PBS -m a
\#PBS -l walltime=24:00:00
\#PBS -l pmem=100mb
\#PBS -l nodes=1:ppn=1

cd \$PBS_O_WORKDIR
../../coevol1.3c/exe_lin64/coevol $Gene.dsom1";
	           print OUT3 "                                                                                                                                               
\#!/bin/bash                                                                                                                                                                
\#PBS -M YOUR_EMAIL
\#PBS -m a                                                                                                                                                     
\#PBS -l walltime=24:00:00                                                                                                                                                   
\#PBS -l pmem=100mb                                                                                                                                                          
\#PBS -l nodes=1:ppn=1                                                                                                                                                       

cd \$PBS_O_WORKDIR                                                                                                                                                            
../../coevol1.3c/exe_lin64/coevol $Gene.dsom2";
system "qsub $Gene.RestartChain1.sh";
system "qsub $Gene.RestartChain2.sh";
	}
    }
}
#if ($BadMixCount == 0)
#{
#    foreach $GENE (@GeneArray)
#    {
#	open OUT1, ">$GENE.ReadCoevol.sh";
#	print OUT1 "
#\#!/bin/bash                                                                                                                 
#\#PBS -M YOUR_EMAIL                                                                                                     
#\#PBS -l walltime=00:10:00                                                                                                   
#\#PBS -l pmem=200mb                                                                                                         
#\#PBS -l nodes=1:ppn=1                                                                                                       
#                                                                                   
#cd \$PBS_O_WORKDIR
#../../coevol1.3c/exe_lin64/readcoevol -x $BurninHash{$GENE} $GENE.dsom1";
#system "qsub $GENE.ReadCoevol.sh"; 
#    }
#    close OUT1;
#} 
close FH1;
exit; 
