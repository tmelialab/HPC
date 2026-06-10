#!/bin/bash
#SBATCH --job-name=sra_dump        # Job name
#SBATCH --cpus-per-task=64         # CPUs per task (match your --threads)
#SBATCH --mem=128GB                # Memory (adjust based on file size)
#SBATCH --time=24:00:00           # Time limit (hrs:min:sec)
#SBATCH --output=sra_dump_%j.out     # Stdout log
#SBATCH --error=sra_dump_%j.err      # Stderr log


# Aktivasi Lingkungan Conda
    : "${ENV_NAME:=training_qc}"
    source "$(conda info --base)/etc/profile.d/conda.sh"
    conda activate "$ENV_NAME"
    log_message "Conda environment '${ENV_NAME}' activated."
    echo ""

# Your loop from before
while read -r srr; do
    fasterq-dump "$srr" --split-files --threads 64
done < sra_dump.txt

echo "Processing complete!"