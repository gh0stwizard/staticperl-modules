#define PERL_NO_GET_CONTEXT 1
#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"

#define PERL_VERSION_DECIMAL(r,v,s) (r*1000000 + v*1000 + s)
#define PERL_DECIMAL_VERSION \
	PERL_VERSION_DECIMAL(PERL_REVISION,PERL_VERSION,PERL_SUBVERSION)
#define PERL_VERSION_GE(r,v,s) \
	(PERL_DECIMAL_VERSION >= PERL_VERSION_DECIMAL(r,v,s))

#ifndef croak
# define croak Perl_croak_nocontext
#endif /* !croak */

#define Q_MUST_WORKAROUND (!PERL_VERSION_GE(5,12,0))
#define Q_HAVE_COP_HINTS_HASH PERL_VERSION_GE(5,9,4)

#if Q_MUST_WORKAROUND

# if !PERL_VERSION_GE(5,9,3)
typedef OP *(*Perl_check_t)(pTHX_ OP *);
# endif /* <5.9.3 */

# if !PERL_VERSION_GE(5,10,1)
typedef unsigned Optype;
# endif /* <5.10.1 */

# ifndef wrap_op_checker
#  define wrap_op_checker(c,n,o) THX_wrap_op_checker(aTHX_ c,n,o)
static void THX_wrap_op_checker(pTHX_ Optype opcode,
Perl_check_t new_checker, Perl_check_t *old_checker_p)
{
	if(*old_checker_p) return;
	OP_REFCNT_LOCK;
	if(!*old_checker_p) {
		*old_checker_p = PL_check[opcode];
		PL_check[opcode] = new_checker;
	}
	OP_REFCNT_UNLOCK;
}
# endif /* !wrap_op_checker */

# define refcounted_he_free(he) Perl_refcounted_he_free(aTHX_ he)

static OP *pp_squashhints(pTHX)
{
	/*
	 * SAVEHINTS() won't actually localise %^H unless the
	 * HINT_LOCALIZE_HH bit is set.  Normally that bit would be set if
	 * there were anything in %^H, but when affected by [perl #73174]
	 * the core's swash-loading code clears $^H without # changing
	 * %^H, so we set the bit here.  We localise $^H while doing this,
	 * in order to not clobber $^H across a normal require where the
	 * bit is legitimately clear, except on Perl 5.11, where the bit
	 * needs to stay set in order to get proper restoration of %^H.
	 */
# if !PERL_VERSION_GE(5,11,0)
	SAVEI32(PL_hints);
# endif /* <5.11.0 */
	PL_hints |= HINT_LOCALIZE_HH;
	SAVEHINTS();
	hv_clear(GvHV(PL_hintgv));
# if Q_HAVE_COP_HINTS_HASH
	if(PL_compiling.cop_hints_hash) {
		refcounted_he_free(PL_compiling.cop_hints_hash);
		PL_compiling.cop_hints_hash = NULL;
	}
# endif /* Q_HAVE_COP_HINTS_HASH */
	return PL_op->op_next;
}

#define gen_squashhints_op() THX_gen_squashhints_op(aTHX)
static OP *THX_gen_squashhints_op(pTHX)
{
	OP *squashhints_op = newOP(OP_PUSHMARK, 0);
	squashhints_op->op_type = OP_RAND;
	squashhints_op->op_ppaddr = pp_squashhints;
	return squashhints_op;
}

static OP *(*nxck_require)(pTHX_ OP *op);

static OP *myck_require(pTHX_ OP *op)
{
	op = nxck_require(aTHX_ op);
	op = append_list(OP_LINESEQ, (LISTOP*)gen_squashhints_op(),
					(LISTOP*)op);
	op = prepend_elem(OP_LINESEQ, newOP(OP_ENTER, 0), op);
	op->op_type = OP_LEAVE;
	op->op_ppaddr = PL_ppaddr[OP_LEAVE];
	op->op_flags |= OPf_PARENS;
	return op;
}

#endif /* Q_MUST_WORKAROUND */

MODULE = Lexical::SealRequireHints PACKAGE = Lexical::SealRequireHints

PROTOTYPES: DISABLE

void
import(SV *classname)
CODE:
	PERL_UNUSED_VAR(classname);
#if Q_MUST_WORKAROUND
	wrap_op_checker(OP_REQUIRE, myck_require, &nxck_require);
#endif /* Q_MUST_WORKAROUND */

void
unimport(SV *classname, ...)
CODE:
	PERL_UNUSED_VAR(classname);
	croak("Lexical::SealRequireHints does not support unimportation");
