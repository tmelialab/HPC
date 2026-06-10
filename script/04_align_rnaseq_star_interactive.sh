#!/bin/bash

# Pastikan conda siap (opsional jika sudah aktif di shell)
source ~/miniconda3/etc/profile.d/conda.sh
conda activate training_qc 

# Set variables
GENOME="acacia_final.fasta.masked"
RNA_DIR="rnaseq"
THREADS=16

# Penting untuk interaktif agar tidak error "too many open files"
ulimit -n 65535

# Pastikan folder output ada
mkdir -p ${RNA_DIR}

echo "--- 1. Generating STAR Genome Index ---"
mkdir -p ${RNA_DIR}/star_index

STAR --runThreadN $THREADS \
     --runMode genomeGenerate \
     --genomeDir ${RNA_DIR}/star_index \
     --genomeFastaFiles $GENOME \
     --genomeSAindexNbases 13
