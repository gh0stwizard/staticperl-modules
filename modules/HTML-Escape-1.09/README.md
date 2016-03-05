# NAME

HTML::Escape - Extremely fast HTML escape

# SYNOPSIS

    use HTML::Escape qw/escape_html/;

    escape_html("<^o^>");

# DESCRIPTION

This module escapes HTML's special chars. It's same as PHP's htmlspecialchars.

This module uses XS for better performance.
And also provides pure perl version.

# FAQ

- Is there a unescape\_html?

    No. Unescaping HTML needs a lot of code, gfx don't want to do it.
    Please use [HTML::Entities](https://metacpan.org/pod/HTML::Entities) for it.

# BENCHMARK

                     Rate HTML::Entities   HTML::Escape
    HTML::Entities 14.0/s             --           -91%
    HTML::Escape    150/s           975%             --

# AUTHOR

Goro Fuji

Tokuhiro Matsuno <tokuhirom AAJKLFJEF@ GMAIL COM>

# SEE ALSO

[Text::Xslate](https://metacpan.org/pod/Text::Xslate), [HTML::Entities](https://metacpan.org/pod/HTML::Entities)

# LICENSE

Copyright (C) Tokuhiro Matsuno

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.
