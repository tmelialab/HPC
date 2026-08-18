#!/bin/bash
#SBATCH --job-name=08_star_align
#SBATCH --output=align_%j.log
#SBATCH --error=align_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=64G
#SBATCH --time=24:00:00

set -euo pipefail

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate training_qc 

# Set variables
GENOME="acacia_final.fasta.masked"
RNA_DIR="rnaseq"
THREADS="${SLURM_CPUS_PER_TASK:-16}"

# Increase open file limit for BAM sorting
ulimit -n 65535

echo "--- 1. Generating STAR Genome Index ---"
# Create a directory for the index
mkdir -p ${RNA_DIR}/star_index

# Generate the index. We run this without a GTF file since we are building
# the annotation from scratch with BRAKER3.
# --genomeSAindexNbases 13 is recommended for genome size ~862 Mb
STAR --runThreadN $THREADS \
     --runMode genomeGenerate \
     --genomeDir ${RNA_DIR}/star_index \
     --genomeFastaFiles $GENOME \
     --genomeSAindexNbases 13

echo "--- 2. Aligning Paired-End Reads ---"
# SRR25080411
STAR --runThreadN $THREADS \
     --genomeDir ${RNA_DIR}/star_index \
     --readFilesIn ${RNA_DIR}/SRR25080411_1.fastq ${RNA_DIR}/SRR25080411_2.fastq \
     --outFileNamePrefix ${RNA_DIR}/SRR25080411_ \
     --outSAMtype BAM SortedByCoordinate \
     --limitBAMsortRAM 50000000000

# SRR25080412
STAR --runThreadN $THREADS \
     --genomeDir ${RNA_DIR}/star_index \
     --readFilesIn ${RNA_DIR}/SRR25080412_1.fastq ${RNA_DIR}/SRR25080412_2.fastq \
     --outFileNamePrefix ${RNA_DIR}/SRR25080412_ \
     --outSAMtype BAM SortedByCoordinate \
     --limitBAMsortRAM 50000000000

# SRR25816559
STAR --runThreadN $THREADS \
     --genomeDir ${RNA_DIR}/star_index \
     --readFilesIn ${RNA_DIR}/SRR25816559_1.fastq ${RNA_DIR}/SRR25816559_2.fastq \
     --outFileNamePrefix ${RNA_DIR}/SRR25816559_ \
     --outSAMtype BAM SortedByCoordinate \
     --limitBAMsortRAM 50000000000

echo "--- 3. Aligning Single-End Reads ---"
# SRR1168433
STAR --runThreadN $THREADS \
     --genomeDir ${RNA_DIR}/star_index \
     --readFilesIn ${RNA_DIR}/SRR1168433.fastq \
     --outFileNamePrefix ${RNA_DIR}/SRR1168433_ \
     --outSAMtype BAM SortedByCoordinate \
     --limitBAMsortRAM 50000000000

echo "--- Alignment Complete! ---"