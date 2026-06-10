#!/bin/bash

export GENEMARK_PATH=/mgpfs/home/damedihardjo/etpbraker/bin

eval "$(conda shell.bash hook)"
conda activate training_qc

RNA_DIR="rnaseq"
BAMS="${RNA_DIR}/SRR1168433_Aligned.sortedByCoord.out.bam,${RNA_DIR}/SRR25080411_Aligned.sortedByCoord.out.bam,${RNA_DIR}/SRR25080412_Aligned.sortedByCoord.out.bam,${RNA_DIR}/SRR25816559_Aligned.sortedByCoord.out.bam"

echo "--- Menjalankan BRAKER3 dengan RNA-seq + Protein ---"

braker.pl --genome=acacia_final.fasta.masked --bam=$BAMS --prot_seq=Viridiplantae.fa --softmasking --threads=62 --GENEMARK_PATH=/mgpfs/home/damedihardjo/etpbraker/bin --species=acacia_crassicarpa --workingdir=./braker_combined_result --gff3

echo "--- BRAKER Selesai ---"
