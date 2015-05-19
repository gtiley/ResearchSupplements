#!/usr/bin/perl
use warnings;
system 'ls *.phy > PhyFiles.list';
open FH1, "<PhyFiles.list";
while (<FH1>)
{
    if (/((\S+)\.phy)/)
    {
	$PhyFile = $1;
	$Gene = $2;
	open FH99, "<$Gene.dsom1.trace";
	@LineArray = ();
	while (<FH99>)
	{
	    $Line = $_;
	    push @LineArray, $Line;
	}
	$Points = (scalar(@LineArray) - 1);
	$Burnin = int(0.25 * $Points);
#	print "$Points\n";    
	open OUT1, ">$Gene.TraceComp.sh";
	print OUT1 "
\#!/bin/bash                                                                                                                 
\#PBS -M YOUR_EMAIL                                                                                                     
\#PBS -l walltime=01:00:00                                                                                                   
\#PBS -l pmem=200mb                                                                                                         
\#PBS -l nodes=1:ppn=1                                                                                                       
                                                                                   
cd \$PBS_O_WORKDIR
../../coevol1.3c/exe_lin64/tracecomp -x $Burnin $Gene.dsom1 $Gene.dsom2 > $Gene.ESS";
     }
    close OUT1;
    system "qsub $Gene.TraceComp.sh";
} 
close FH1;
exit; 
