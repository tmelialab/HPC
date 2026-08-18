#!/bin/bash
#SBATCH --job-name=04_builddb
#SBATCH --output=builddb_%j.log
#SBATCH --error=builddb_%j.err
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=4
#SBATCH --mem=16G
#SBATCH --time=02:00:00

set -euo pipefail

source "$(conda info --base)/etc/profile.d/conda.sh"
conda activate repeats

echo "--- Mulai BuildDatabase ---"
BuildDatabase -name acacia_db -engine ncbi acacia_final.fasta
echo "--- BuildDatabase Selesai ---"