#!/bin/sh

#
# prints a staticperl installation directory
#

RC_FILE=$HOME/.staticperlrc

if [ -f $RC_FILE ]; then
	. $RC_FILE
	echo "${STATICPERL}/perl"
fi

exit 0
