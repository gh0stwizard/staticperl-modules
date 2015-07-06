requires "Attribute::Handlers" => "0.79";
requires "Carp" => "0";
requires "Exporter" => "0";
requires "Module::Implementation" => "0";
requires "Scalar::Util" => "1.10";
requires "XSLoader" => "0";
requires "attributes" => "0";
requires "perl" => "5.008001";
requires "strict" => "0";
requires "vars" => "0";
requires "warnings" => "0";

on 'build' => sub {
  requires "Module::Build" => "0.28";
};

on 'test' => sub {
  requires "Devel::Peek" => "0";
  requires "ExtUtils::MakeMaker" => "0";
  requires "File::Spec" => "0";
  requires "File::Temp" => "0";
  requires "Test::Fatal" => "0";
  requires "Test::More" => "0.96";
  requires "Test::Requires" => "0";
  requires "Tie::Array" => "0";
  requires "Tie::Hash" => "0";
  requires "base" => "0";
  requires "lib" => "0";
  requires "overload" => "0";
};

on 'test' => sub {
  recommends "CPAN::Meta" => "2.120900";
};

on 'configure' => sub {
  requires "Module::Build" => "0.28";
};

on 'develop' => sub {
  requires "File::Spec" => "0";
  requires "IO::Handle" => "0";
  requires "IPC::Open3" => "0";
  requires "Perl::Critic" => "1.123";
  requires "Perl::Tidy" => "20140711";
  requires "Pod::Coverage::TrustPod" => "0";
  requires "Readonly" => "1.03";
  requires "Scalar::Util" => "1.20";
  requires "Test::CPAN::Changes" => "0.19";
  requires "Test::EOL" => "0";
  requires "Test::LeakTrace" => "0.15";
  requires "Test::More" => "0.96";
  requires "Test::NoTabs" => "0";
  requires "Test::Pod" => "1.41";
  requires "Test::Pod::Coverage" => "1.08";
  requires "Test::Spelling" => "0.12";
  requires "Test::Synopsis" => "0";
  requires "Test::Taint" => "0.02";
};
