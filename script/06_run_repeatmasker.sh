#!/bin/bash
#SBATCH --job-name=06_repeatmasker
#SBATCH --output=repeatmasker_%j.log
#SBATCH --error=repeatmasker_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=64
#SBATCH --mem=128G
#SBATCH --time=24:00:00

set -euo pipefail

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate repeats

echo "--- Mulai RepeatMasker ---"
RepeatMasker -pa 62 -lib acacia_db-families.fa -gff -xsmall acacia_final.fasta
echo "--- RepeatMasker Selesai ---"