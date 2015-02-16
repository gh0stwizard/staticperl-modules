use ExtUtils::MakeMaker;

WriteMakefile(
  NAME => 'Params::Validate::XS',
  VERSION_FROM => '../lib/Params/Validate.pm',
  OBJECT => '$(O_FILES)',
);
