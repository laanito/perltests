package CheckHeaders;
use strict;
use warnings;
use LWP::UserAgent;
use HTTP::Request;


use base 'Exporter';
our @EXPORT_OK = qw(getResponse);

sub getResponse {
	# get arguments

	my $path = $_[0];	
	my $ua = new LWP::UserAgent;
	$ua->agent("hcat/1.0");
	my $request = new HTTP::Request("GET", $path);
	my $response = $ua->request($request);
	return $response;
}
1;
