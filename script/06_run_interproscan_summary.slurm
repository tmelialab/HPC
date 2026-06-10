#!/bin/bash
#SBATCH --job-name=ipr_annot
#SBATCH --nodes=1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --mem=120G
#SBATCH --output=ipr_annot.%j.out
#SBATCH --error=ipr_annot.%j.err

set -euo pipefail

############################################
# USER SETTINGS
############################################

IPR=/mgpfs/home/tishalia/tool/interproscan-5.75-106.0
INPUT=/mgpfs/home/tishalia/assembly/annotation_braker2/augustus.hints.aa.noStop
OUTDIR=/mgpfs/home/tishalia/annotation/interproscan
PREFIX=augustus.hints.aa
CPUS=${SLURM_CPUS_PER_TASK:-16}

############################################
# PREP
############################################

mkdir -p "$OUTDIR"
cd "$OUTDIR"

echo "[$(date)] Starting InterProScan"

############################################
# STEP 1 — RUN INTERPROSCAN
############################################

"$IPR"/interproscan.sh \
  -i "$INPUT" \
  -f tsv \
  -dp \
  -goterms \
  -iprlookup \
  -cpu "$CPUS" \
  -appl Pfam,SMART,ProSiteProfiles,ProSitePatterns,SUPERFAMILY \
  -b "$PREFIX"

echo "[$(date)] InterProScan finished"

############################################
# STEP 2 — SUMMARY STATISTICS
############################################

TSV="${PREFIX}.tsv"

echo "[$(date)] Generating summary statistics"

# Total proteins
TOTAL_PROTEINS=$(grep -c "^>" "$INPUT")

# Proteins with any InterPro/Pfam hit
PROTEINS_WITH_HITS=$(cut -f1 "$TSV" | sort | uniq | wc -l)

# Unique GO terms
GO_TERMS=$(grep -o "GO:[0-9]\+" "$TSV" | sort | uniq | wc -l)

# Proteins with at least one GO term
PROTEINS_WITH_GO=$(grep "GO:" "$TSV" | cut -f1 | sort | uniq | wc -l)

# Top 20 Pfam domains
awk '$4=="Pfam"{print $6}' "$TSV" | sort | uniq -c | sort -nr  > pfam.txt

############################################
# WRITE SUMMARY FILE
############################################

SUMMARY=interproscan_summary.txt

{
  echo "InterProScan summary"
  echo "===================="
  echo "Input protein file: $INPUT"
  echo "InterProScan version: 5.75-106.0"
  echo ""
  echo "Total proteins: $TOTAL_PROTEINS"
  echo "Proteins with InterPro/Pfam hits: $PROTEINS_WITH_HITS"
  echo "Proteins with GO terms: $PROTEINS_WITH_GO"
  echo "Unique GO terms: $GO_TERMS"
  echo ""
  echo "Top 20 Pfam domains: see top20_pfam.txt"
} > "$SUMMARY"

echo "[$(date)] Summary written to $SUMMARY"
echo "[$(date)] Done."
