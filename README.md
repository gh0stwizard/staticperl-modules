Description
==================

The repository contains notes, patches and re-packaged modules
for [staticperl](http://search.cpan.org/perldoc?staticperl).

Modules
==================

The main problem when building modules in staticperl environment
is [Module::Build](http://search.cpan.org/perldoc?Module%3A%3ABuild).

It is a nice module, but staticperl does not contains patches for 
Module::Build for linking against staticperl's perl binary correctly.

The workaround is to re-write modules so they uses Makefile.PL
(ExtUtils::MakeMaker) instead of Build.PL (Module::Build).

It would be much better create patches for staticperl/Module::Build,
I know, but I have not so much experience at the moment.

How to use my modules?
-------------------

```
$ ~/staticperl instsrc staticperl-modules/modules/My-Module
```

Patches
====================

Some modules unable to build due some typos, mistakes in Makefile.PL.
Such typos mostly relies to staticperl only. For common perl 
(shared perl, provided by maintainers of GNU/Linux distributives and so on)
such typos is irrelevant.

How to use patches?
-------------------

```
~/staticperl cpan
cpan > look My-Module

# now you are in My-Module directory
# copy the path file to working directory
$ cp /path/to/staticperl-modules/patches/My-Module/patch-001.diff .

# apply the patch
$ patch -p0 < patch-001.diff

# return to cpan shell
$ Ctrl-D

# install module as usual
cpan > install My-Module
```

Notes and documentation
=======================

In doc directory you may find some useful notes. I should create
issues in RT bug tracker for some of them.
Instead I found out quick workarounds.

Also, many modules in CPAN have incorrect requirements. And you must
install required modules manually before installing target module.

FAQ
=======================

What is you changed exactly?
-----------------------------

1. Replace Build.PL with almost exactly same Makefile.PL
2. Moving some \*.xs, \*.c, \*.h files to root directory (mostly).

Why you did not post issues in bug tracker, create patches?
-----------------------------------------------------------

When I can -- I do this.
Some things is too complicated for me.
And sometimes I've not enough time to resolve a problem.

