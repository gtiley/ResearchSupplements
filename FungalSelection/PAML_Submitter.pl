#!/usr/bin/perl
use warnings;
system 'ls *.H0.ctl > CtlFiles';
open FH1, "<CtlFiles";
while (<FH1>)
{
    if (/((\S+)\.H0\.ctl)/)
    {
	$File = $1;
	$Gene = $2;
	open OUT1, ">$Gene.H0.sh";
	print OUT1"
\#\!/bin/bash                                                                                                                                                                   
\#PBS -M gtiley\@ufl\.edu                                                                                                                                                       
\#PBS -m a                                                                                                                                                                    
\#PBS -l walltime=24:00:00                                                                                                                                                     
\#PBS -l pmem=400mb                                                                                                                                                            
\#PBS -l nodes=1:ppn=1                                                                                                                                                          
cd \$PBS_O_WORKDIR
module load paml/4.7
codeml $File";
close OUT1;
system "qsub $Gene.H0.sh";
    }
}
close FH1;
exit;
