#!/usr/bin/perl
foreach $filename (@ARGV) {
  open(COUNT,"grep -c \"^-- \$\" $filename |");
  $max = <COUNT>;
  chomp $max;
  close(COUNT);
  open(FILE,"<$filename") || die;
  randomize;
  $nr = $count = int rand($max);
#  print "$max - $count\n";
  while ($count > 0) {
    $line = <FILE>;
    if ($line =~ /^-- $/) {
      $count--;
#      print $line;
    }
  }

  $output = "\n,---------------------------------<";
  for ($empty = 3-length($nr); $empty > 0; $empty--) {
    $output .= " ";
  }
  $output .= $nr . " of " . $max;
  $output .=">-----------------------------------.\n";


  while(true) {
    $line = <FILE>;
    if ($line =~ /^-- $/) {
      last;
    } else {
      chomp $line;
      $line = "|" . $line;
      for ($empty = 81-length($line); $empty > 0; $empty--) {
        $line .= " ";
      }
      $line .= "|\n"; 
      $output .= $line;
    }
  }
  $output .= "\`--------------------------------------------------------------------------------´\n";
  print $output;

#  $smtp = Net::SMTP->new('mailhost');
}
