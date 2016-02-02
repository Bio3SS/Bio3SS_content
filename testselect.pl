use strict;

my $version = shift(@ARGV);

$version--;

undef $/;
my $sa = <>;

my $num = "[\\w\\\\]*[.]?[\\w\\\\]*";

## Split 5 ways first (in case there's an extra, like for the final)
while (my($head, $choice, $tail) = ($sa =~ m|(.*?)($num/$num/$num/$num/$num)(.*)|s)){
	my @choice=(split m|[/]|, $choice);
	$choice="$choice[$version]";
	$sa = "$head$choice$tail";
}

## Now split 4 ways
while (my($head, $choice, $tail) = ($sa =~ m|(.*?)($num/$num/$num/$num)(.*)|s)){
	my @choice=(split m|[/]|, $choice);
	$choice="$choice[$version]";
	$sa = "$head$choice$tail";
}

print "$sa\n";

