##-*- Mode: CPerl -*-
use strict;
use warnings;

use Alien::Base::ModuleBuild;
use Alien::Gfsm;

my $builder = Alien::Base::ModuleBuild->new
  (
   module_name => 'Alien::GfsmXL',
   license => 'perl',
   configure_requires => {
			  'Alien::Base'   => '0.001',
			  'Module::Build' => '0.38',
			 },
   test_requires => {
		     #'File::Which'   => 0,
		    },
   requires => {
		'perl'        => '5.8.9',
		'Alien::Base' => '0.005',
	       },
   dist_author => 'Bryan Jurish <moocow@cpan.org>',
   alien_name => 'gfsmxl',
   alien_repository => {
			protocol => 'http',
			host     => 'kaskade.dwds.de',
			location => '~moocow/mirror/projects/gfsm/',
			pattern  => qr/^gfsmxl-([\d\.\-]+)\.tar\.gz$/,
		       },
   extra_compiler_flags => Alien::Gfsm->cflags,
   extra_linker_flags   => Alien::Gfsm->libs,
   alien_build_commands => [
			    '%c --prefix=%s --enable-shared --enable-static',
			    'make',
			   ],
   alien_isolate_dynamic => 1,
   ##
   #sign => 1,
   #meta_merge => { ... },
   ##
   create_readme => 1,
  );
$builder->create_build_script;

