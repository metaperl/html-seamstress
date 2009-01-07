package HTML::Seamstress;

use strict;
use warnings;

use Carp qw(confess);
use Cwd;
use Data::Dumper;
use File::Slurp;
use File::Spec;



use base qw/HTML::Element::Library HTML::TreeBuilder HTML::Element/;


our $VERSION = '5.0b' ;


sub bless_tree {

  my ($node, $class) = @_;


  if (ref $node) {
 #   warn "root node($class): ", $node->as_HTML;
    bless $node, $class ;

    foreach my $c ($node->content_list) {
      bless_tree($c, $class);
    }
  }
}



sub new_from_file { # or from a FH

  my ($class, $file) = @_;


  my $new = HTML::TreeBuilder->new_from_file($file);
  bless_tree($new, $class);
#  warn "here is new: $new ", $new->as_HTML;
  $new;

}


sub html {
  my ($class, $file, $extension) = @_;

  $extension ||= 'html';

  my $pm = File::Spec->rel2abs($file);
  $pm =~ s!pm$!$extension!;
  $pm;
}


sub eval_require {
  my $module = shift;

  return unless $module;

  eval "require $module";

  confess $@ if $@;
}

sub HTML::Element::expand_replace {
    my $node = shift;
    
    my $seamstress_module = ($node->content_list)[0]  ;
    eval "require $seamstress_module";
    die $@ if $@;
    $node->replace_content($seamstress_module->new) ;

}


1;
__END__

