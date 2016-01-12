#!/bin/sh

# path where backups will be kept
BACKUP_DIR="$HOME/backup/SP"
# tar utility filepath
TAR=tar
#TAR="/usr/pkg/bin/gtar"
# staticperlrc file
STATICPERLRC_FILE="$HOME/.staticperlrc"


# read staticperlrc configuration file
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
# backup archive filename
BACKUP_FILE="${BACKUP_DIR}/${FILE}-$(date +%s).tar.gz"
# list of backuped files and dirs
FILES_LIST="${BACKUP_DIR}/${FILE}-$(date +%s).filelist.txt"

# create backup directory when neccessary
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
|| exit 1

echo ">>> ${BACKUP_FILE}"
echo ">>> ${FILES_LIST}"

exit 0
