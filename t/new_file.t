use strict;
use warnings;

use HTML::Seamstress;

my $t = HTML::Seamstress->new_file(
	't/html/new_file/new_file.html',
	store_comments => 1
	);

warn $t->as_HTML('  ');
