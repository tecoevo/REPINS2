#!/usr/bin/perl

while(<>){
  my @split=split(/\/|\./);
  $all=$split[4].".".$split[5].".".$split[6];
  $all=~s/\s+//g;
  $noFNA=$split[4].".".$split[5];
  my @split2=split(/_/,$noFNA);
  $noFNA=$split2[0]."_".$split2[1]."_".$split2[2];
  my $zero=substr($split[4],0,3);
  my $first=substr($split[4],4,3);
  my $second=substr($split[4],7,3);
  my $third=substr($split[4],10,3);
  system  "wget ftp://ftp.ncbi.nlm.nih.gov/genomes/all/$zero/$first/$second/$third/$noFNA/$all.gz\n";
}
