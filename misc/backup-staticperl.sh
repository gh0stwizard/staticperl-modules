#!/bin/sh

# path where backups will be kept
BACKUP_DIR="$HOME/tmp/backup"

. $HOME/.staticperlrc

PERL_DIR=".staticperl-$PERL_VERSION"
BACKUP_FILE="${BACKUP_DIR}/staticperl-$PERL_VERSION-$(date +%s).tar.gz"

tar -zcvpf ${BACKUP_FILE} \
    --directory=$HOME \
    --exclude="${PERL_DIR}/src/*" \
    --exclude="${PERL_DIR}/cpan/build/*" \
    --exclude="${PERL_DIR}/cpan/sources/*" \
    $PERL_DIR \
|| exit 1

echo ">>> ${BACKUP_FILE}"

exit 0
