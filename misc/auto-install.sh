#!/bin/sh

#
# automatic installer for staticperl
#

PWD=$(pwd)
BASEDIR=$(dirname $0)
RC_FALL=${BASE_DIR:-$PWD}/staticperlrc
RC_FILE=${1:-$RC_FALL}
SP_FILE="$HOME/staticperl"
OURFILE="/tmp/staticperlrc-autoinstall"


get_rc() {
	if [ -r $RC_FILE ]; then
		. ${RC_FILE}
	else
		echo "Usage: auto-install.sh [staticperlrc-file]"
		exit 1
	fi
}

backup() {
	cp $RC_FILE $OURFILE || exit 1
}

cleanup() {
	rcfile=$HOME/.staticperlrc

	if [ -r $rcfile ]; then
		NEWFILE="${rcfile}-auto-$(date +%Y-%m-%d_%H-%M)"
		echo "*** Copying $OURFILE $NEWFILE"
		cp $OURFILE $NEWFILE || exit 1
	else
		echo "*** Copying $OURFILE $rcfile"
		cp $OURFILE $rcfile || exit 1
	fi

	rm -f $OURFILE
}

status() {
	echo ">>> Using staticperlrc file: $RC_FILE"
	echo ">>> Temporary file: $OURFILE"
	echo "*** Perl version: $PERL_VERSION"
	echo "*** Installation directory: $STATICPERL"

	if [ "$GW_MODULES" != "" ]; then
		if [ -d $GW_MODULES ]; then
			echo "*** gh0stwizard's modules: $GW_MODULES"
			[ -d $GW_PATCHES ] && 
			echo "***               patches: $GW_PATCHES"
		else
			echo "!!! $GW_MODULES: is not a directory"
			exit 1
		fi
	fi

	echo "*** EMAIL = $EMAIL"
	echo "*** PERL_CONFIGURE = $PERL_CONFIGURE"
}

STAGE=-1
checkstage() {
	if [ -d "$STATICPERL" ]; then
		if [ "$STAGE" -eq 0 ]; then
			STAGE=1
		else
			echo
			echo "!!! Already installed?!"
			echo
			exit 1
		fi
	else
		STAGE=0
	fi
}

Pgcsections() {
	#
	# Using pre-defined PERL_LDFLAGS while 'configure',
	# and hide them while 'install' stages.
	#
	# See misc/staticperlrc file for details.
	#

	stage=${1:-configure}
	commented=$(grep -- '^#export PERL_LDFLAGS=' $OURFILE)

	if [ "$commented" != "" ]; then
		[ "$stage" = "configure" ] &&
		sed -i 's/^#*\(export PERL_LDFLAGS=\)/\1/' $OURFILE
	else
		[ "$stage" = "install" ] &&
		sed -i 's/^\(export PERL_LDFLAGS=\)/#\1/' $OURFILE
	fi
	
	unset stage
}

preparerc() {
	if [ $STAGE -eq 1 ]; then
		# install
		COMMAND="install"
	else
		# configure
		COMMAND="configure"
	fi

	Pgcsections $stage
}


if [ -r "$OURFILE" ]; then
	echo ">>> Resuming, using \`$OURFILE'"
	. $OURFILE
else 
	get_rc
	backup
fi

status
sleep 5

# configure stage
checkstage
preparerc
export STATICPERLRC=$OURFILE
$SP_FILE $COMMAND || exit 1

# install stage
checkstage
preparerc
$SP_FILE $COMMAND || exit 1

cleanup

echo "*****************************************************"
if [ "$NEWFILE" != "" ]; then
	echo "  STATICPERLRC=$NEWFILE $SP_FILE perl -v"
else
	echo "  $SP_FILE perl -v"
fi
echo "*****************************************************"

exit 0
