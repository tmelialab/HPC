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

echo "--- 2. Aligning Reads ---"
# Daftar SRR yang akan diproses
SAMPLES=("SRR25080411" "SRR25080412" "SRR25816559")

for SRR in "${SAMPLES[@]}"; do
echo "Processing Paired-End: $SRR"
STAR --runThreadN $THREADS \
     --genomeDir ${RNA_DIR}/star_index \
     --readFilesIn ${RNA_DIR}/${SRR}_1.fastq ${RNA_DIR}/${SRR}_2.fastq \
     --outFileNamePrefix ${RNA_DIR}/${SRR}_ \
     --outSAMtype BAM SortedByCoordinate \
     --outSAMstrandField intronMotif \
     --limitBAMsortRAM 50000000000
done

echo "Processing Single-End: SRR1168433"
STAR --runThreadN $THREADS \
     --genomeDir ${RNA_DIR}/star_index \
     --readFilesIn ${RNA_DIR}/SRR1168433.fastq \
     --outFileNamePrefix ${RNA_DIR}/SRR1168433_ \
     --outSAMtype BAM SortedByCoordinate \
     --outSAMstrandField intronMotif \
     --limitBAMsortRAM 50000000000

echo "--- Alignment Complete! ---"