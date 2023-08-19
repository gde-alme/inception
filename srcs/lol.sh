#!/bin/bash

# Function to display a spinner
spinner() {
    local pid=$1
    local delay=0.75
    local spinstr='|/-\'
    while [ "$(ps a | awk '{print $1}' | grep $pid)" ]; do
        local temp=${spinstr#?}
        printf " [%c]  " "$spinstr"
        local spinstr=$temp${spinstr%"$temp"}
        sleep $delay
        printf "\b\b\b\b\b\b"
    done
    printf "    \b\b\b\b"
}

# Run docker-compose in the background and suppress its output
docker-compose up -d > /dev/null 2>&1 &
# Get the PID of the docker-compose command
PID=$!

# Run the spinner with the PID of the docker-compose
spinner $PID

