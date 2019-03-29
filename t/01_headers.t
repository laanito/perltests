use strict;
use warnings;
use v5.12;
use Test::HTTP::Response;

use Test::Simple;
		     
use CheckHeaders qw(getResponse);
use LoadConfig qw(getConfig);

my $Test = Test::Builder->new;
my $config = getConfig();
my $numTests = 0;
my $matchedServer;
my $hstsage;
my $hsts;
my $url;
my $csp;
my $cspvalue;

foreach my $section (keys %{$config}) {
	$matchedServer = 0;
        $hstsage = 0;
        $hsts = 0;
        $url = '';
	$csp = 0;
	foreach my $parameter (keys %{$config->{$section}}) {
	    given($parameter){
                when('server'){
		    $url=$config->{$section}->{$parameter};
		    $matchedServer = 1;
		    }
                when('hsts'){
                    $hstsage = $config->{$section}->{$parameter};
                    $hsts = 1;
                }
		when('csp'){
                    $cspvalue = $config->{$section}->{$parameter};
		    $csp = 1;
		}
            }
	}
	if ($matchedServer) {
	
	    my $response = getResponse($url);
	    my $headers = $response->headers_as_string;

	    $Test->diag("Testing server: ".$section." at url: ".$url."\n");
	    $Test->diag("Testing response...\n");
	    status_matches($response, 200, 'Response is ok');
	    $numTests++;
	    if ($hsts){
	    	$Test->diag("Testing Headers...\n");
	    	header_matches($response, 'strict-transport-security', 'max-age='.$hstsage,'hsts header is correctly formed');
	    	$numTests++;
		}
	    if ($csp){
		$Test->diag("Testing CSP...\n");
		header_matches($response, 'Content-Security-Policy ', $cspvalue, 'Content Security Policy is correctly formed');
		$numTests++;
	    }
        }
}
$Test->done_testing($numTests);

