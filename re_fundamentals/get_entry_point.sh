#!/bin/bash

# Source the messages script
source ./messages.sh

# Check if argument is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <ELF_file>"
    exit 1
fi

file_name="$1"

# Check if file exists
if [ ! -f "$file_name" ]; then
    echo "Error: File does not exist."
    exit 1
fi

# Check if it's an ELF file
if ! file "$file_name" | grep -q "ELF"; then
    echo "Error: Not a valid ELF file."
    exit 1
fi

# Extract ELF header info
header=$(readelf -h "$file_name")

magic_number=$(echo "$header" | grep "Magic:" | cut -d: -f2 | xargs)
class=$(echo "$header" | grep "Class:" | cut -d: -f2 | xargs)
byte_order=$(echo "$header" | grep "Data:" | cut -d: -f2 | xargs)
entry_point_address=$(echo "$header" | grep "Entry point address:" | cut -d: -f2 | xargs)

# Display using messages.sh
display_elf_header_info
