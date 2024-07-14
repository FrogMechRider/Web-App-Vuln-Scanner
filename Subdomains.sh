#!/bin/bash
find_subdomains() {
    local domain="$1"
    echo "Finding subdomains for $domain..."
    python3 Sublist3r/sublist3r.py -d "$domain" | tail -n +24 >> subdomains.txt
    cat subdomains.txt
}

#main script
if [ -z "$1" ]; then
    echo "Usage: $0 <domain|domain_file>"
    echo "Example: $0 example.com"
    echo "Example: $0 domains.txt"
    exit 1
fi 

input="$1"

if [ -f "$input" ]; then
    echo "Input is a file. Processing domains from file: $input"
    while IFS= read -r domain || [[ -n "$domain" ]]; do
        if [ -n "$domain" ]; then
            echo "Processing domain: $domain"
            subdomains=$(find_subdomains "$domain")
        fi
      done < "$input"
else
    echo "Input is a single domain. Processing domain: $input"
    subdomains=$(find_subdomains "$input")
fi