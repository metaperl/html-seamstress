#!/usr/bin/perl
package MySeamstress;
use strict;
use warnings;
use base 'HTML::Seamstress';
sub name_handler {
    my ($tree, $name) = @_;
    my $name_tag = $tree->look_down('id', 'name');
    $name_tag->detach_content; # delete dummy content ("ah, Clem")
    $name_tag->push_content($name);
}
sub date_handler {
    my ($tree, $date) = @_;
    my $name_tag = $tree->look_down('id', 'date');
    $name_tag->detach_content; # delete dummy content ("Oct 6, 2001")
    $name_tag->push_content($date);
}

1;

use strict;
use warnings;
use HTML::Seamstress;

my $html_file = 'synopsis.html';
my $tree = MySeamstress->new_from_file($html_file);
$tree->name_handler('bob');
$tree->date_handler(`date`);

print $tree->as_HTML;

1;
