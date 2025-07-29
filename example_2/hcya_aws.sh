#!/bin/bash

# Function to sync folders for multiple subjects from AWS S3 to a local directory.
#
# Written by: Aleksij Kraljic and Jure Demsar, 2025

get_args() {
    arg="$1"
    shift 1
    for fn in "$@" ; do
        if [ `echo $fn | grep -- "^${arg}=" | wc -w` -gt 0 ]; then
            echo $fn | sed "s/^${arg}=//"
            return 0
        fi
    done
}

aws_hcya() {
    local sessions=`get_args "--sessions" $@`
    local source_folder=`get_args "--source_folder" $@`
    local target_folder=`get_args "--target_folder" $@`
    local access_key=`get_args "--access_key" $@`
    local secret_key=`get_args "--secret_key" $@`

    # If access key and secret key are provided, configure AWS CLI
    if [[ -n "$access_key" && -n "$secret_key" ]]; then
        aws configure set aws_access_key_id "$access_key"
        aws configure set aws_secret_access_key "$secret_key"
    fi

    # Loop through each session in the sessions list
    IFS=',' read -ra session_array <<< "$sessions"
    for session in "${session_array[@]}"; do
        echo " "
        echo "... syncing data for session: $session"

        echo "... fetching data from: s3://hcp-openaccess/HCP_1200/$session/$source_folder"
        echo "... saving to: $target_folder/$session/$source_folder"

        mkdir -p "$target_folder/$session/$source_folder"

        # Use AWS CLI to sync data from AWS S3 to the local folder
        sync_target="$target_folder/$session/$source_folder"
        aws s3 sync \
            s3://hcp-openaccess/HCP_1200/$session/$source_folder \
            $sync_target \
            --region us-east-1

        # Check if sync was successful by verifying folder size
        if [ -d "$sync_target" ]; then
            folder_size=$(du -s "$sync_target" 2>/dev/null | cut -f1)
            # Check if folder size is greater than 1KB (threshold)
            if [ "$folder_size" -gt 100 ]; then
                echo "... sync completed successfully for session: $session (size: ${folder_size}KB)"
            else
                echo "... ERROR: sync failed for session: $session - folder is empty or too small"
                exit 1
            fi
        else
            echo "... ERROR: sync failed for session: $session - target folder does not exist"
            exit 1
        fi
    done

    echo "All syncs completed successfully!"
    exit 0
}

# If no input parameters provided, display usage instructions
if [ $# -eq 0 ]; then
    echo "Function to sync folders for multiple subjects from AWS S3 to a local directory."
    echo ""
    echo "Usage: ./aws_hcya.sh --sessions=<sessions> --source_folder=<source_folder> --target_folder=<target_folder> [--access_key=<access_key>] [--secret_key=<secret_key>]"
    echo ""
    echo "  <sessions>: A comma-separated list of sessions (e.g. \"100307,111716\")"
    echo "  <source_folder>: Source folder on AWS for each subject's data from each subject's root folder"
    echo "                   (e.g. s3://hcp-openaccess/HCP_1200/\$subject/\$source_folder)"
    echo "  <target_folder>: Local root folder where data will be stored"
    echo "  <access_key> (optional): AWS access key ID"
    echo "  <secret_key> (optional): AWS secret access key"
    echo ""
    echo "Example use:"
    echo "./aws_hcya.sh --sessions=100307,111716 --source_folder=T1w --target_folder=/data/jdemsar/data/hcya --access_key=YOUR_ACCESS_KEY_HERE --secret_key=YOUR_SECRET_KEY_HERE"
    echo ""
    exit 1
fi

# Otherwise, call the function with provided input parameters
aws_hcya "$1" "$2" "$3" "$4" "$5"
