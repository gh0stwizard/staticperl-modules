#!/bin/sh

# retrieve OS name
OSNAME=$(uname -s)
# dirpath where backups will be kept
BACKUP_DIR="$HOME/backup/SP"
# tar utility filepath 
# note: this file has been wroten with gtar in mind
if [ ${OSNAME} = "SunOS" ]; then
	TAR="/usr/pkg/bin/gtar"
elif [ ${OSNAME} = "OpenBSD" ]; then
	TAR="/usr/local/bin/gtar"
else
	TAR=tar
fi
# filepath to staticperlrc file
STATICPERLRC_FILE="$HOME/.staticperlrc"

# read the staticperlrc configuration file
# to retrieve a value of $STATICPERL variable, see below.
if [ -r ${STATICPERLRC_FILE} ]; then
	. ${STATICPERLRC_FILE}
else
	echo "Could not find file ${STATICPERLRC_FILE}"
	exit 1
fi

# staticperl installation directory
PERL_DIR=$(basename ${STATICPERL})
# filename for an archive
FILE=$(echo $PERL_DIR | sed 's/^\.//')
# epoch time (note: on solaris an option "%s" does not provided)
if [ ${OSNAME} = "SunOS" ]; then
	DATE=$(date +%Y%m%d_%H%M%S)
else
	DATE=$(date +%s)
fi
# backup archive filename
BACKUP_FILE="${BACKUP_DIR}/${FILE}-${DATE}.tar.gz"
# list of backuped files and dirs
FILES_LIST="${BACKUP_DIR}/${FILE}-${DATE}.filelist.txt"

# create a backup directory if neccessary
if [ ! -d ${BACKUP_DIR} ]; then
	echo -n "mkdir -p \`${BACKUP_DIR}'... "
	mkdir -p ${BACKUP_DIR} || exit 1
	echo "[ OK ]"
fi

# create an archive
${TAR} -zcvpf ${BACKUP_FILE} \
    --directory=${HOME} \
    --exclude="${PERL_DIR}/src/*" \
    --exclude="${PERL_DIR}/cpan/build/*" \
    --exclude="${PERL_DIR}/cpan/sources/*" \
    --exclude="${PERL_DIR}/cache/*" \
    ${PERL_DIR} > ${FILES_LIST} \
    2>&1 \
|| exit 1

echo ">>> ${BACKUP_FILE}"
echo ">>> ${FILES_LIST}"

exit 0
