use LWP::UserAgent;
use HTTP::Request;

use Test::HTTP::Response;

sub getResponse {
	# get arguments

	my $path = $_[0];	
	my $ua = new LWP::UserAgent;
	$ua->agent("hcat/1.0");
	my $request = new HTTP::Request("GET", $path);
	my $response = $ua->request($request);
	return $response;
}
my $response = getResponse("https://duckduckgo.com");
my $headers = $response->headers_as_string;

status_matches($response, 200, 'Response is ok');
 
status_ok($response);

header_matches($response, 'strict-transport-security', 'max-age=31536000','hsts header'); 
