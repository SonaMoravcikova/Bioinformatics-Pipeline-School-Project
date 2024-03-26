#!/bin/bash

#Define the working directory as the project directory
project_dir="$PWD/.."

# Change to the project directory; exit if unsuccessful
cd "$project_dir" || exit 1

# Activate conda environment
source activate bioinformatics_tools

# Run FastQC only for .gz files in raw_data
for file in raw_data/*.gz; do
    fastqc "$file" -o "$project_dir/results/fastqc_reports"
done

echo "FastQC completed."

# Prompt the user to choose default or custom Trimmomatic parameters
read -p "Do you want to use default Trimmomatic parameters (LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36)? (yes/no): " use_default

# Set default Trimmomatic parameters
default_params="LEADING:3 TRAILING:3 SLIDINGWINDOW:4:15 MINLEN:36"

# Set Trimmomatic parameters based on user choice
if [ "$use_default" == "yes" ]; then
    trimmomatic_params="$default_params"
else
    read -p "Enter custom Trimmomatic parameters: " custom_params
    trimmomatic_params="$custom_params"
fi

#Define the results file for storing read counts
results_file="$project_dir/results/deleted_reads_results.txt"
echo "Sample,Reads_Before,Reads_After,Deleted_Reads" > "$results_file"

#Define the naming conventions for forward and reverse reads
forward="_1_aaa.fastq.gz"
reverse="_2_aaa.fastq.gz"

# Run Trimmomatic for paired-end data
for forward_read in raw_data/*"${forward}"; do
    # Extract sample name from forward read filename
    sample_name=$(basename "$forward_read" ${forward})

    # Define the paths for the forward and reverse reads
    reverse_read="raw_data/${sample_name}${reverse}"

    # Run Trimmomatic for paired-end data with user-specified parameters
    trimmomatic PE -phred33 "$forward_read" "$reverse_read" \
        processed_data/"${sample_name}_paired${forward}" \
        processed_data/"${sample_name}_unpaired${forward}" \
        processed_data/"${sample_name}_paired${reverse}" \
        processed_data/"${sample_name}_unpaired${reverse}" \
        ILLUMINACLIP:/home/fc62932/miniconda3/envs/bioinformatics_tools/share/trimmomatic-0.39-2/adapters/TruSeq3-PE-2.fa:2:151:10 \
        $trimmomatic_params
 # Calculate the number of reads before and after Trimmomatic
    before_reads=$(($(zcat "$forward_read" | wc -l) / 4))
    after_reads=$(($(zcat "processed_data/${sample_name}_paired${forward}" | wc -l) / 4))
    deleted_reads=$((before_reads - after_reads))

    # Append the results to the file
    echo "$sample_name,$before_reads,$after_reads,$deleted_reads" >> "$results_file"
done

echo "Trimmomatic completed."
echo "Counting deleted reads completed. Results saved in $results_file."

#Deactivate the conda enviroment
conda deactivate
