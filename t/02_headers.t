use strict;
use warnings;

use Test::HTTP::Response;

use Test::Simple tests => 3;
		     
use CheckHeaders qw(getResponse);
		        
my $response = getResponse("https://privacyheroes.io");
my $headers = $response->headers_as_string;

status_matches($response, 200, 'Response is ok');

status_ok($response);

header_matches($response, 'strict-transport-security', 'max-age=31536000','hsts header is correctly formed');


