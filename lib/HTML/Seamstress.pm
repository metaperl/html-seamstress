package HTML::Seamstress;

use strict;
use warnings;

use Carp qw(confess);
use Cwd;
use Data::Dumper;
use File::Slurp;
use File::Spec;



use HTML::Element::Library;
use HTML::Elemental;
use HTML::Element::Replacer;
use base qw/HTML::TreeBuilder HTML::Element/;


our $VERSION = '5.0g' ;


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

  $class = ref $class ? ref $class : $class ;

  my $new = HTML::TreeBuilder->new_from_file($file);
  bless_tree($new, $class);
  #warn "CLASS: $class TREE:", $new;
#  warn "here is new: $new ", $new->as_HTML;
  $new;

}

sub new_file { # or from a FH

  my ($class, $file, %args) = @_;

  -e $file or die 'File $file does not exist';

  my $new = HTML::TreeBuilder->new;

  for my $k (keys %args) {
    next if $k =~ /guts/ ; # scales for more actions later
    $new->$k($args{$k});
  }

  -e $file or die "$file does not exist";
  $new->parse_file($file);
  bless_tree($new, $class);

  if ($args{guts}) {
    $new->guts;
  } else {
    $new;
  }

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

