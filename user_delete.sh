#!/bin/bash

# Check if the script is run as root
if [[ "${UID}" -ne 0 ]]; then
    echo "This script must be run as root or with sudo privileges."
    exit 1
fi

# Check if usernames are provided
if [[ "${#}" -lt 1 ]]; then
    echo "Usage: ${0} USERNAME [USERNAME2 USERNAME3 ...]"
    echo "Deletes the specified USERNAME(s)."
    exit 1
fi

# Loop through each username provided
for username in "${@}"; do
    # Delete the user
    userdel "${username}"

    # Check if user deletion was successful
    if [[ "${?}" -ne 0 ]]; then
        echo "Failed to delete the user ${username}."
    else
        echo "User ${username} has been successfully deleted."
    fi
done

