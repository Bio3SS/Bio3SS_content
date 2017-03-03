use strict;
use 5.10.0;

while (<>){
	next unless s/^\s*POLL\s*//;
	s/\S*\s*//;
	s/.*?[.?]\s*(\w)/$1/;
	print;
}
