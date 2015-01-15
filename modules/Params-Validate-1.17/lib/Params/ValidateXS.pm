package # hide from PAUSE
    Params::Validate;

BEGIN { $ENV{PARAMS_VALIDATE_IMPLEMENTATION} = 'XS' }
use Params::Validate;

1;
