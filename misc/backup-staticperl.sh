#!/bin/sh

# path where backups will be kept
BACKUP_DIR="$HOME/backup/SP"

. $HOME/.staticperlrc

PERL_DIR=$(basename ${STATICPERL})
BACKUP_FILE="${BACKUP_DIR}/staticperl-$PERL_VERSION-$(date +%s).tar.gz"
FILES_LIST="${BACKUP_DIR}/staticperl-$PERL_VERSION-$(date +%s).filelist.txt"

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
