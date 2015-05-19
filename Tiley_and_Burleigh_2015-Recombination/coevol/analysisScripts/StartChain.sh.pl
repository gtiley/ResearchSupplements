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
	open OUT1, ">$Gene.dsom.chain2.sh";
	print OUT1 "\#!/bin/bash                                                                                                                                              

\#PBS -M YOUR_EMAIL                                                                                                                                                      
\#PBS -m a
\#PBS -l walltime=24:00:00                                                                                                                                                    
\#PBS -l pmem=100mb                                                                                                                                                           
\#PBS -l nodes=1:ppn=1                                                                                                                                                        

cd \$PBS_O_WORKDIR
../../coevol1.3c/exe_lin64/coevol -d $PhyFile -t RRsTree.tre -fixtimes -c RR.lht -dsom -geod $Gene.dsom2";
close OUT1;
system "qsub $Gene.dsom.chain2.sh";
}
}
close FH1;
exit;
