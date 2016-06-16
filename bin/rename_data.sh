#/bin/bash

# remove spaces in filenames
find -iname "* *" -type f | rename 's/ /_/g'

# rename files based on modification date
counter=1; for f in $(ls -1rt); do printf -v new "%02d %s" "$counter" "$f"; mv "$f" "$new"; ((counter++)); done
