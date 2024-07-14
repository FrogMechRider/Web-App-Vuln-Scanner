#!/bin/bash

subdomains_file="subdomains.txt"
output_file="subdomains_alive.txt"

check_ports() {
    local subdomains_file="$1"


    while IFS= read -r subdomain || [ -n "$subdomain" ]; do
        if [ -n "$subdomain" ]; then
            python -m httpx "$subdomain" -ports 443,80,8080,8000,8888 >> "$output_file"
        fi
     done < "$subdomains_file"
}

if [ ! -f "$subdomains_file" ]; then
    exit 1
fi

check_ports "$subdomains_file"