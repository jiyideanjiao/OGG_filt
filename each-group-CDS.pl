#!usr/bin/perl -w

$hamstr_out=$ARGV[0];
$outputdir=$ARGV[1];
if($#ARGV !=1){print "Usage: perl_sript <file_hamstr_out> <dir_output>\n\n";}
open HAMSTR_OUT, "$hamstr_out" or die $!;
while(<HAMSTR_OUT>){chomp;
        @arr1=();
        @arr1=split /\|/,$_;
        #$ortholog_group=$arr1[0];
        open RESULT,">>$outputdir/$arr1[0].fas" or die $!;
#       $num=$#arr1;
        $seq=pop @arr1;  ###notice: after this step, the @arr1 has been changed
#print "@arr1\t";
#print "$#arr1\n";
        if($#arr1 == 2){$species_name="$arr1[2]";}
        elsif($#arr1 == 3){$species_name="$arr1[2]";}
        elsif($#arr1 == 4){$species_name="$arr1[2]";}
        print RESULT ">$species_name\n$seq\n";
}close RESULT;
close HAMSTR_OUT;