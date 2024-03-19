#!/bin/bash

# Function to display usage information
display_usage() {
    echo "Usage: $0 where-to-look [criteria]"
    echo "Options:"
    echo "  -name <specified name>       Search for files by name"
    echo "  -mmin <specified minutes>    Search for files modified within the specified minutes"
    echo "  -inum <specified i-node>     Search for files with the specified i-node number"
    echo "  -delete                      Delete matching files"
    echo "  -exec <command>              Execute specified command on matching files"
    exit 1
}

# Validate the number of arguments
if [ "$#" -lt 2 ]; then
    display_usage
fi

# Set the directory to search
where_to_look=${1:-.}

# Check if the criteria is specified and perform the corresponding action
if [ "$2" == "-name" ]; then
    # Check if enough arguments are provided
    if [ "$#" -lt 3 ]; then
        display_usage
    fi
    # Use the find command to search for files by name
    find "$where_to_look" -name "${3}" "${@:4}"
    # Use the find command to search for files modified within specified minutes
elif [ "$2" == "-mmin" ]; then
    # Check if enough arguments are provided
    if [ "$#" -lt 3 ]; then
        display_usage
    fi
    find "$where_to_look" -mmin "${3}" "${@:4}"
    # Use the find command to search for files with the specified i-node number
elif [ "$2" == "-inum" ]; then
    # Check if enough arguments are provided
    if [ "$#" -lt 3 ]; then
        display_usage
    fi
    find "$where_to_look" -inum "${3}" "${@:4}"
elif [ "$2" == "-delete" ]; then
    # Use the find command to delete matching files
    find "$where_to_look" -name "${3}" -delete "${@:4}"
elif [ "$2" == "-exec" ]; then
    # Check if enough arguments are provided
    if [ "$#" -lt 4 ]; then
        display_usage
    fi
    # Use the find command to execute the specified command on matching files
    find "$where_to_look" -name "${3}" -exec "${4}" '{}' \;
else
    # If no specific criteria are provided, use the find command without additional options
    find "$where_to_look"
fi
