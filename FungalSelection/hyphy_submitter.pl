#!/usr/bin/perl                                                                                                                                           
use warnings;
system 'ls *.MG94xGTRgamma.bf > batchfiles.txt';
open FH1, "<batchfiles.txt";
while (<FH1>)
{
    if (/((\S+)\.MG94xGTRgamma\.bf)/)
    {
       $file = $1;
       $gene = $2;
       open OUT1, ">$gene.MG94xGTRgamma.sh";
       print OUT1 "#!/bin/bash\n#PBS -M gtiley\@ufl.edu\n#PBS -m a\n#PBS -l walltime=24:00:00\n#PBS -l pmem=200mb\n#PBS -l nodes=1:ppn=1\n";
       print OUT1 "cd \$PBS_O_WORKDIR\n";
       print OUT1 "module load intel\n";
       print OUT1 "module load hyphy/2.1.2.28\n";
       print OUT1 "HYPHYMP $file\n";
       system "qsub $gene.MG94xGTRgamma.sh";
 close OUT1;
    }
}
close FH1;
exit;
