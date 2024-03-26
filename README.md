# Bioinformatics Pipeline
This repository contains a collection of scripts designed to streamline the processing of sequencing data, a critical task in bioinformatics research. As the volume of genomic data continues to grow exponentially, efficient data processing pipelines are essential for extracting meaningful insights from raw sequencing data. Developed as part of a school project, this bioinformatics pipeline automates key steps, including data quality assessment using FastQC, preprocessing with Trimmomatic, and analysis of the resulting data. By automating these processes, researchers can save time and ensure reproducibility in their analyses, ultimately advancing our understanding of biological systems.

## Scripts

### 1. createNewProjectDir.sh

This shell script creates the directory structure required for the bioinformatics project. It sets up directories for storing raw data, processed data, and results. See directory structure below.


### 2. fastqc_trimm_count.sh

This script runs FastQC on raw sequencing data files and saves them in fastqc_reports/ then it performs quality trimming using Trimmomatic either with general or custom parameters to prepare the raw data for downstream analyses. Furthermore it counts the number of deleted reads during trimming for each sample and saves the results in deleted_reads_results.txt .


### 3. fastqc_after_trimm.sh

This script runs FastQC again on the processed data after trimming. It assesses the quality of the trimmed data to ensure that the trimming process was successful.


### Directory Structure

- **raw_data/**: Contains raw sequencing data files.
- **processed_data/**: Stores processed data files after trimming.
- **results/**: Contains output files and reports generated during the analysis.
  - **fastqc_reports/**: FastQC reports for raw data.
  - **fastqc_reports_after_trimm/**: FastQC reports for processed data after trimming.
  - **deleted_reads_results.txt**: Records the number of reads deleted during trimming for each sample.

### Usage

1. Clone this repository to your local machine.
2. Navigate to the repository directory.
3. Run the desired scripts according to your workflow.

### Dependencies

- FastQC
- Trimmomatic

Ensure that these dependencies are installed and accessible in your environment before running the scripts.
