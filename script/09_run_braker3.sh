#!/bin/bash
#SBATCH --job-name=09_braker3
#SBATCH --output=braker3_%j.log
#SBATCH --error=braker3_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --mem=128G
#SBATCH --time=24:00:00

set -euo pipefail

export GENEMARK_PATH=/mgpfs/home/damedihardjo/etpbraker/bin

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate training_qc

RNA_DIR="rnaseq"
BAMS="${RNA_DIR}/SRR1168433_Aligned.sortedByCoord.out.bam,${RNA_DIR}/SRR25080411_Aligned.sortedByCoord.out.bam,${RNA_DIR}/SRR25080412_Aligned.sortedByCoord.out.bam,${RNA_DIR}/SRR25816559_Aligned.sortedByCoord.out.bam"

echo "--- Menjalankan BRAKER3 dengan RNA-seq + Protein ---"

braker.pl \
    --genome=acacia_final.fasta.masked \
    --bam="${BAMS}" \
    --prot_seq=Viridiplantae.fa \
    --softmasking \
    --threads=32 \
    --GENEMARK_PATH="${GENEMARK_PATH}" \
    --species=acacia_crassicarpa \
    --workingdir=./braker_combined_result \
    --gff3

echo "--- BRAKER Selesai ---"