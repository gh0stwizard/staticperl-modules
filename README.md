Description
==================

The repository contains notes, patches and re-packaged modules
for [staticperl](http://search.cpan.org/perldoc?staticperl).

Modules
==================

The main problem when building modules in a staticperl environment
is [Module::Build](http://search.cpan.org/perldoc?Module%3A%3ABuild).

It is a nice module, but staticperl does not contains patches for 
Module::Build to link against staticperl Perl binary file correctly.

The one of workarounds here is rewrite modules in a way to they used the
Makefile.PL (ExtUtils::MakeMaker) instead of the Build.PL (Module::Build)
file.

It would be much better create patches for staticperl and Module::Build,
I know. But I have not much experience to complete this task 
at the moment.

How to install a module?
-------------------

```
shell> cd staticperl-modules
shell> ~/staticperl instsrc modules/My-Module
```

Patches
====================

Some modules are unable to build due typos and mistakes in Makefile.PL.
Such typos mostly relies to staticperl only. And they are irrelevant
to "common" Perl (the perl provided by maintainers of GNU/Linux 
distributives and so on).

How to use patches?
-------------------

* Manual

```
# open cpan shell
shell> ~/staticperl cpan

# extract module via cpan and open shell inside that dir
cpan > look My-Module

# now you are in a My-Module directory
# copy patch file to working directory
shell> cp /path/to/staticperl-modules/patches/My-Module/patch-001.diff .

# apply a patch
shell> patch -p0 < patch-001.diff

# return back to cpan shell (Ctrl-D)
shell> exit

# install a module as usual
cpan > install My-Module
```

* via CPAN + DistroPrefs

[Documentation](http://search.cpan.org/perldoc?CPAN#Blueprint) 
about CPAN's DistroPrefs .

```
# open CPAN shell
shell> ~/staticperl cpan

# install a YAML module, e.g.
CPAN> install YAML::XS
CPAN> o conf yaml_module YAML::XS
CPAN> o conf patches_dir /path/to/staticperl-modules/patches
CPAN> o conf prefs_dir /path/to/staticperl-modules/cpan/prefs

# keep settings above persistent (optional)
CPAN> o conf commit

# install a module
CPAN> install My-Module
```

Notes and documentation
=======================

The <code>doc</code> directory contains some useful notes.
I could create issues in RT bug tracker for some of them.
Instead of that I found out quick workarounds and posted them
into this repo.

Some modules in CPAN have incorrect requirements. So you have to
install required modules manually before installing 
the target module. Otherwise, depending on module's quality you
will either get into troubles or do not.

FAQ
=======================

What did you changed exactly?
-----------------------------

1. Replaced Build.PL with almost exactly the same Makefile.PL.
2. Moved some \*.xs, \*.c, \*.h files to the root directory (mostly).
   This is much easer than writing a lot of strings to configure 
   Makefile.PL to find these files.

Have you posting issues you have found to RT tracker?
------------------------------------------------

* When I can -- I do.
* Some things is too complicated for me.
* Sometimes I've not enough time to do this.

Latest version of staticperl
============================

Can be found [here](http://cvs.schmorp.de/App-Staticperl/bin/staticperl\?revision\=HEAD).

