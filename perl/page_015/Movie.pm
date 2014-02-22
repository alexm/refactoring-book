package Movie;

use strict;
use warnings;

use Moo;

use constant REGULAR     => 0;
use constant NEW_RELEASE => 1;
use constant CHILDRENS   => 2;

has title => (
    is => 'ro',
);

has price_code => (
    is => 'rw',
);

1;
