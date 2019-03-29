package LoadConfig;
use strict;
use warnings;

use Config::Tiny::Ordered;
use Data::Dumper;

use base 'Exporter';
our @EXPORT_OK = qw(getConfig);

sub getConfig {
	my $mycfg = new Config::Tiny->read('test.ini');
	
	return $mycfg;
}
my $matchedServer;
my $url='';
my $config = getConfig();
	foreach my $section (keys %{$config}) {
	    $matchedServer = 0;
	    foreach my $parameter (keys %{$config->{$section}}) {
	        if ($parameter eq 'server') {
	            $url=$config->{$section}->{$parameter};
	            $matchedServer = 1;
	       }
	}
	if ($matchedServer == 0) {
	    next;
	   }
	print "Probing server: ".$url."\n";   
}
1;
