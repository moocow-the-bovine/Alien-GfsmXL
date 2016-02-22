##-*- Mode: CPerl -*-
use strict;
use warnings;

use Alien::Base::ModuleBuild;
use Alien::Gfsm;

##-- maybe tweak alien build environment for local ('share') install of Alien::Gfsm
my %env;
if (Alien::Gfsm->install_type ne 'system') {
  my $pcdir = Alien::Gfsm->dist_dir."/lib/pkgconfig";
  $env{PKG_CONFIG_PATH} = join(":", $pcdir, ($ENV{PKG_CONFIG_PATH} ? $ENV{PKG_CONFIG_PATH} : qw()));
}

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
   alien_env => \%env,
   alien_build_commands => [
			    '%c --prefix=%s --enable-shared --enable-static --disable-doc',
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

