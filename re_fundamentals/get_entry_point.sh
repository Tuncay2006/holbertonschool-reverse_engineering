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

# Extract ELF header
header=$(readelf -h "$file_name")

# Parse values safely (no xargs!)
magic_number=$(echo "$header" | grep "Magic:" | sed 's/.*: *//')
class=$(echo "$header" | grep "Class:" | sed 's/.*: *//')
byte_order=$(echo "$header" | grep "Data:" | sed 's/.*: *//' | grep -o "little endian\|big endian")
entry_point_address=$(echo "$header" | grep "Entry point address:" | sed 's/.*: *//')

# Display formatted output
display_elf_header_info
