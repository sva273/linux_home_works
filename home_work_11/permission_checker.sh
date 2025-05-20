#!/bin/bash

FILE_LIST="/opt/210225-ptm"

# List of all files in the directory
find "$FILE_LIST" -type f -name "*.sh" | while read FILE; do
	if [ ! -x "$FILE" ]; then
	chmod +x "$FILE"
	echo "Added file execution rights: $FILE"
	else
	echo "already executable: $FILE"
	fi
	done

echo "Done"
