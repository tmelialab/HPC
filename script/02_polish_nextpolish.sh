#!/bin/bash
#SBATCH --job-name=02_nextpolish
#SBATCH --partition=short
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=32
#SBATCH --mem=240G
#SBATCH --time=23:00:00
#SBATCH --output=polish_%j.out
#SBATCH --error=polish_%j.err

set -euo pipefail

# NextPolish butuh libbz2.so.1.0 dari conda env di LD_LIBRARY_PATH
export PATH="/mgpfs/home/damedihardjo/.conda/envs/training_qc/bin:$PATH"
export LD_LIBRARY_PATH="/mgpfs/home/damedihardjo/.conda/envs/training_qc/lib:${LD_LIBRARY_PATH:-}"
export NEXT_POLISH="/mgpfs/home/damedihardjo/acacia_project/tools/NextPolish"

CONFIG_FILE="02_polish.cfg"

echo "[$(date '+%Y-%m-%d %H:%M:%S')] Mulai NextPolish..."
${NEXT_POLISH}/nextPolish "${CONFIG_FILE}"
echo "[$(date '+%Y-%m-%d %H:%M:%S')] NextPolish selesai."
