use strict;
use 5.10.0;

while(<>){
	s/pdf/png/g if (/includegraphics/);
	s/commands}/simple}/;
	say;
}
