#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#define NEED_newSVpvn_flags
#define NEED_sv_2pv_flags

#include "ppport.h"


static void /* doesn't care about raw-ness */
tx_sv_cat_with_escape_html_force(pTHX_ SV* const dest, SV* const src) {
    STRLEN len;
    const char*       cur = SvPV_const(src, len);
    const char* const end = cur + len;
    STRLEN const dest_cur = SvCUR(dest);
    char* d;

    (void)SvGROW(dest, dest_cur + ( len * ( sizeof("&quot;") - 1) ) + 1);
    if(!SvUTF8(dest) && SvUTF8(src)) {
        sv_utf8_upgrade(dest);
    }

    d = SvPVX(dest) + dest_cur;

#define CopyToken(token, to) STMT_START {          \
        Copy(token "", to, sizeof(token)-1, char); \
        to += sizeof(token)-1;                     \
    } STMT_END

    while(cur != end) {
        const char c = *(cur++);
        if(c == '&') {
            CopyToken("&amp;", d);
        }
        else if(c == '<') {
            CopyToken("&lt;", d);
        }
        else if(c == '>') {
            CopyToken("&gt;", d);
        }
        else if(c == '"') {
            CopyToken("&quot;", d);
        }
        else if(c == '`') {
            CopyToken("&#96;", d);
        }
        else if(c == '{') {
            CopyToken("&#123;", d);
        }
        else if(c == '}') {
            CopyToken("&#125;", d);
        }
        else if(c == '\'') {
            /* XXX: Internet Explorer (at least version 8) doesn't support &apos; in title */
            /* CopyToken("&apos;", d); */
            CopyToken("&#39;", d);
        }
        else {
            *(d++) = c;
        }
    }

#undef CopyToken

    SvCUR_set(dest, d - SvPVX(dest));
    *SvEND(dest) = '\0';
}

static SV*
tx_escape_html(pTHX_ SV* const str) {
    SvGETMAGIC(str);
    if(!( !SvOK(str) )) {
        SV* const dest = newSVpvs_flags("", SVs_TEMP);
        tx_sv_cat_with_escape_html_force(aTHX_ dest, str);
        return dest;
    }
    else {
        return str;
    }
}

MODULE = HTML::Escape    PACKAGE = HTML::Escape

PROTOTYPES: DISABLE

void
escape_html(SV* str)
CODE:
{
    ST(0) = tx_escape_html(aTHX_ str);
}

