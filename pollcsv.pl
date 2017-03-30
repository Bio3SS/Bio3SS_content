use strict;
use 5.10.0;

$/ = "";

while (<>){
	next unless s/^\s*POLL\s*//;
	chomp;
	s/\s+/ /g;
	s/\S*\s*//;
	s/.*?[.?]\s*(\w)/$1/;
	my ($ques, $choices) = /(.*?[.?])(.*)/;
	my @choices = split /;\s*/, $choices;
	@choices = map {s/.*/"$&"/} @choices;
	print "Poll, ";
	if (@choices>1){
		print "Multiple choice, ";
	} else {
		print "Open-ended, ";
	}
	print '"' . $ques . '", ';
	say join ", ", @choices;
}
