package # hide from PAUSE
    Params::Validate;

our $VERSION = '1.20';

BEGIN { $ENV{PARAMS_VALIDATE_IMPLEMENTATION} = 'XS' }
use Params::Validate;

1;
