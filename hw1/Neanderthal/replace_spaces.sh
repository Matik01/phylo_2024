#!/bin/bash

# Loop through each file in the directory
for file in *.fasta; do
    # Replace spaces with underscores
    new_file=$(echo "$file" | tr ' ' '_')
    
    # Rename the file if necessary
    if [ "$file" != "$new_file" ]; then
        mv "$file" "$new_file"
        echo "Renamed '$file' to '$new_file'"
    fi
done

