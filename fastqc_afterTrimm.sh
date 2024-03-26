#!/bin/bash

# Use the current working directory as the project directory
project_dir="$PWD/.."

# Change to the project directory
cd "$project_dir" || exit 1

# Activate conda environment
source activate bioinformatics_tools

# Run FastQC only for .gz files
for file in processed_data/*.gz; do
    fastqc "$file" -o "$project_dir/results/fastqc_reports_afterTrimm"
done

echo "FastQC completed."

conda deactivate
