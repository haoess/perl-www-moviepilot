use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'WWW::Moviepilot',
    AUTHOR              => q{Frank Wiegand <frank.wiegand@gmail.com>},
    VERSION_FROM        => 'lib/WWW/Moviepilot.pm',
    ABSTRACT_FROM       => 'lib/WWW/Moviepilot.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Test::More' => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'WWW-Moviepilot-*' },
);
