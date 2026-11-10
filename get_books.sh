#!/bin/bash
set -euo pipefail

#check for missing arguments
if [ "$#" -ne 2 ]; then
    echo "Usage: $0 BUCKET BOOK_DIR" >&2
    exit 1
fi

#take two arguments: the name of your bucket and the directory for the books
BUCKET="$1"
DIRECTORY="$2"

#create the book directory if it does not exist yet
mkdir -p "$DIRECTORY"

#copy every .txt file of the bucket into the book directory, and nothing else
aws s3 cp "s3://$BUCKET" "$DIRECTORY" --recursive --exclude "*" --include "*.txt"

#write a new file book_list.txt in the current directory
echo "File path"  > book_list.txt

#list the absolute path of each book file and list books in sorted order
find "$DIRECTORY" -name "*.txt" | sort >> book_list.txt

#print how many books it listed
tail -n +2 book_list.txt | wc -l
