#!/bin/bash

set -u

export INBOX="/volume1/ebooks/inbox"
export LIBRARY="/volume1/ebooks/calibre/calibre_library"
LOGDIR=${INBOX}/logs
LOGFILE="${LOGDIR}/new_books.log"
mkdir -p ${LIBRARY}
mkdir -p ${LOGDIR}

# check for the directory
[ -d "${INBOX}" ] || exit 1

# Function to add the new books if found
book_add () {
   calibredb add --with-library "${LIBRARY}" "${1}"
}

# Export the funtion
export -f book_add

# Find all new ebooks and add to library
find "$INBOX" -type f -name "*.epub" -exec bash -c 'book_add "$0"' {} \; | tee --append ${LOGFILE}
# find "$INBOX" -type f -name "*.pdf" -exec bash -c 'book_add "$0"' {} \; | tee --append ${LOGFILE}

exit 0

