#!/bin/bash
 
# Prompt the user for the project name
read -p "Enter the project name: " project_name

# Prompt the user for the parent directory
read -p "Enter the parent directory (default is ~/fc62932/projects): " parent_dir
parent_dir=${parent_dir:-~/projects}

# Construct the project directory path
project_dir="$parent_dir/$project_name"

if [ -d "$project_dir" ]; then
        echo "The directory $project_dir already exists."
else
        echo "The directory $project_dir does not exist. Creating it now..."
        #Create new directory with subdirectories
        mkdir -p "$project_dir/raw_data" \
                 "$project_dir/processed_data" \
                 "$project_dir/scripts" \
                 "$project_dir/results/fastqc_reports" \
                 "$project_dir/results/fastqc_reports_afterTrimm"

  
        # Save the script in the "scripts" subdirectory
        script_path="$project_dir/scripts/$(basename "$0")"
        cp "$0" "$script_path"
  
        echo "Project directory and subdirectories created successfully."
        echo "Script saved in $script_path."
fi
