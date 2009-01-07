#use 5.008;
use ExtUtils::MakeMaker;
# See lib/ExtUtils/MakeMaker.pm for details of how to influence
# the contents of the Makefile that is written.
WriteMakefile(
    'NAME'		=> 'HTML::Seamstress',
    'VERSION_FROM'	=> 'lib/HTML/Seamstress.pm', # finds $VERSION
    'EXE_FILES'         => ['sbase.pl', 'spkg.pl'],
    'PREREQ_PM'		=> 
	      {
	       File::Slurp => 9999.06,
	       HTML::Element::Library => 0.01,
	       HTML::PrettyPrinter => 0.03,
	       HTML::Tree => 3.18,
	       Pod::Usage => 1.14,
	       Class::Prototyped => 1.10,
	      },

);

sub MY::postamble { q{


docs:
	cd lib/HTML/Seamstress; ./tt.pl Quickstart.tt
	cd lib/HTML/Seamstress; cp Quickstart.tt-out Quickstart.pod
	cd lib/HTML/Seamstress; pod2html Quickstart.pod > Quickstart.html

  };
}
