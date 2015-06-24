#!/bin/sh

# path where backups will be kept
BACKUP_DIR="$HOME/backup/SP"


if [ -r $HOME/.staticperlrc ]; then
	. $HOME/.staticperlrc
else
	echo "Could not find file $HOME/.staticperlrc"
	exit 1
fi


PERL_DIR=$(basename ${STATICPERL})
FILE=$(echo $PERL_DIR | sed 's/^\.//')
BACKUP_FILE="${BACKUP_DIR}/${FILE}-$(date +%s).tar.gz"
FILES_LIST="${BACKUP_DIR}/${FILE}-$(date +%s).filelist.txt"


tar -zcvpf ${BACKUP_FILE} \
    --directory=$HOME \
    --exclude="${PERL_DIR}/src/*" \
    --exclude="${PERL_DIR}/cpan/build/*" \
    --exclude="${PERL_DIR}/cpan/sources/*" \
    --exclude="${PERL_DIR}/cache/*" \
    $PERL_DIR > ${FILES_LIST} \
|| exit 1

echo ">>> ${BACKUP_FILE}"
echo ">>> ${FILES_LIST}"

exit 0
