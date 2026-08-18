# Genome Assembly, Quality Control, Annotation, and Comparative Pipeline Scripts

This directory contains the scripts used for the genome assembly, polishing, quality assessment, repeat masking, structural gene annotation, functional annotation, and comparative genomics pipeline for *Acacia crassicarpa*. The scripts are numbered sequentially to reflect the true execution pipeline.

---

## English Version

### 1. De Novo Assembly & QC
*   **`01_assembly_nextdenovo.sh`** (`01_nextdenovo.cfg`, `01_input.fofn`):
    *   **Code Explanation**: SBATCH script running on the `short` partition with 64 CPUs and 240GB RAM. First performs pre-assembly read QC with `NanoPlot`, then executes `nextDenovo` utilizing Oxford Nanopore long reads to generate the initial contig assembly (`hasil/03.ctg_graph/nd.asm.fasta`).
*   **`02_polish_nextpolish.sh`** (`02_polish.cfg`, `02_sgs.fofn`):
    *   **Code Explanation**: Runs short-read polishing on the raw NextDenovo assembly using Illumina paired-end data (`Raw_97_R1.fq.gz`, `Raw_97_R2.fq.gz`). Sets `LD_LIBRARY_PATH` to resolve conda `libbz2` dependencies.
*   **`03_qc_busco.sh`**:
    *   **Code Explanation**: Assesses assembly completeness using `busco` against the `embryophyta_odb10` lineage database (offline mode) and generates a summary evaluation plot.

### 2. Repeat Identification & Masking
*   **`04_repeatmodeler_builddb.sh`**:
    *   **Code Explanation**: Builds a BLAST-formatted database (`BuildDatabase -name acacia_db`) from the polished assembly for repeat discovery.
*   **`05_run_repeatmodeler.sh`**:
    *   **Code Explanation**: Executes de novo repeat family modeling via `RepeatModeler -pa 62 -LTRStruct` in the `repeats` conda environment. Auto-resumes from checkpoint directory `RM_*/` on resubmission.
*   **`06_run_repeatmasker.sh`**:
    *   **Code Explanation**: Performs soft-masking (`RepeatMasker -xsmall`) using the custom consensus repeat library (`acacia_db-families.fa`), converting repetitive bases to lowercase.

### 3. Structural Gene Annotation
*   **`07_download_sra_reads.sh`**:
    *   **Code Explanation**: Parallel downloader using `fasterq-dump --split-files --threads 64` to fetch RNA-seq read archives listed in `sra_dump.txt` as transcriptomic evidence for annotation.
*   **`08_align_rnaseq_star.sh`**:
    *   **Code Explanation**: Two-stage STAR aligner: generates genome index on soft-masked FASTA (`--genomeSAindexNbases 13`), then aligns paired-end and single-end RNA-seq reads into coordinate-sorted BAM files.
*   **`09_run_braker3.sh`**:
    *   **Code Explanation**: Runs BRAKER3 (`braker.pl`) integrating soft-masked genome, RNA-seq BAMs, and plant protein homology (`Viridiplantae.fa`) via GeneMark-ETP and AUGUSTUS to predict structural gene models in GFF3 format.

### 4. Functional Annotation
*   **`10_run_interproscan.sh`**:
    *   **Code Explanation**: Runs InterProScan on predicted proteins across Pfam, SMART, ProSite, and SUPERFAMILY databases, extracting Gene Ontology (GO) terms and domain distributions.
*   **`11_run_trnascan.sh`**:
    *   **Code Explanation**: Predicts transfer RNA (tRNA) genes across the soft-masked genome using `tRNAscan-SE`.
*   **`12_diamond_swissprot.sh`**:
    *   **Code Explanation**: Fast protein homology alignment against curated Swiss-Prot database using `diamond blastp` (`--evalue 1e-5`, `--sensitive`).
*   **`13_diamond_uniref90.sh`**:
    *   **Code Explanation**: Large-scale protein homology search against the comprehensive UniRef90 database.
*   **`14_make_genome_annotation_tsv.py`**:
    *   **Code Explanation**: Python integration script (204 lines) that merges BRAKER GTF coordinates, InterProScan domain/GO annotations, Swiss-Prot best hits, and UniRef90 best hits into a master tabular file (`genome_annotation_final.tsv`).

### 5. Comparative Genomics (Bonus Step)
*   **`90_run_syri_sv_analysis.sh`**:
    *   **Code Explanation**: Performs whole-genome structural variation discovery by aligning query against reference via `minimap2 --eqx`, extracting 1-to-1 homologous chromosomes, detecting synteny/inversions with `SyRI`, and visualizing genome alignment via `plotsr`.

---

## Versi Indonesia (Indonesian Version)

### 1. Perakitan De Novo & QC
*   **`01_assembly_nextdenovo.sh`** (`01_nextdenovo.cfg`, `01_input.fofn`):
    *   **Penjelasan Kode**: Skrip SBATCH partisi `short` (64 CPU, 240GB RAM). Diawali QC *reads* pra-assembly dengan `NanoPlot`, lalu menjalankan `nextDenovo` pada data sekuens ONT untuk menghasilkan *contig* awal (`hasil/03.ctg_graph/nd.asm.fasta`).
*   **`02_polish_nextpolish.sh`** (`02_polish.cfg`, `02_sgs.fofn`):
    *   **Penjelasan Kode**: Memoles (polish) assembly mentah menggunakan *short reads* Illumina *paired-end* dengan `NextPolish`. Menyertakan `LD_LIBRARY_PATH` untuk pustaka conda `libbz2`.
*   **`03_qc_busco.sh`**:
    *   **Penjelasan Kode**: Evaluasi kelengkapan assembly genom menggunakan database silsilah tanaman `embryophyta_odb10` dan membuat plot statistik visual.

### 2. Identifikasi & Masking Sekuen Berulang
*   **`04_repeatmodeler_builddb.sh`**:
    *   **Penjelasan Kode**: Membangun database format BLAST (`BuildDatabase -name acacia_db`) dari hasil perakitan terpoles.
*   **`05_run_repeatmodeler.sh`**:
    *   **Penjelasan Kode**: Menjalankan pemodelan elemen repetitif *de novo* dengan `RepeatModeler -pa 62 -LTRStruct`. Mendukung *resume* otomatis jika job *timeout*.
*   **`06_run_repeatmasker.sh`**:
    *   **Penjelasan Kode**: Menutup sekuen berulang dengan metode *soft-masking* (`RepeatMasker -xsmall`) menggunakan pustaka konsensus kustom (`acacia_db-families.fa`).

### 3. Anotasi Gen Struktural
*   **`07_download_sra_reads.sh`**:
    *   **Penjelasan Kode**: Mengunduh arsip sekuens RNA-seq dari NCBI SRA secara paralel (`fasterq-dump --threads 64`) berdasarkan daftar di `sra_dump.txt`.
*   **`08_align_rnaseq_star.sh`**:
    *   **Penjelasan Kode**: Pemetaan RNA-seq dua tahap dengan STAR: pembuatan indeks genom (`--genomeSAindexNbases 13`) dan *alignment reads paired-end/single-end* menghasilkan file BAM terurut.
*   **`09_run_braker3.sh`**:
    *   **Penjelasan Kode**: Menjalankan pipeline BRAKER3 (`braker.pl`) menggabungkan genom *soft-masked*, bukti RNA-seq (BAM), dan database protein tumbuhan (`Viridiplantae.fa`) via GeneMark-ETP dan AUGUSTUS untuk prediksi model gen (GFF3).

### 4. Anotasi Fungsional
*   **`10_run_interproscan.sh`**:
    *   **Penjelasan Kode**: Anotasi domain protein (Pfam, SMART, SUPERFAMILY) dan istilah Gene Ontology (GO) dari sekuens asam amino hasil BRAKER.
*   **`11_run_trnascan.sh`**:
    *   **Penjelasan Kode**: Prediksi gen transfer RNA (tRNA) pada seluruh genom *soft-masked* dengan `tRNAscan-SE`.
*   **`12_diamond_swissprot.sh`**:
    *   **Penjelasan Kode**: Homologi protein cepat terhadap database terkurasi Swiss-Prot menggunakan `diamond blastp` (`--evalue 1e-5`, `--sensitive`).
*   **`13_diamond_uniref90.sh`**:
    *   **Penjelasan Kode**: Pencarian homologi protein komprehensif terhadap database UniRef90.
*   **`14_make_genome_annotation_tsv.py`**:
    *   **Penjelasan Kode**: Skrip Python integrator (204 baris) yang menggabungkan koordinat GTF BRAKER, anotasi domain/GO InterProScan, skor terbaik Swiss-Prot, dan skor terbaik UniRef90 menjadi satu tabel master (`genome_annotation_final.tsv`).

### 5. Genomika Komparatif (Langkah Tambahan)
*   **`90_run_syri_sv_analysis.sh`**:
    *   **Penjelasan Kode**: Deteksi variasi struktural genom utuh melalui *alignment* `minimap2 --eqx`, ekstraksi pasangan kromosom 1:1, identifikasi sinteni/inversi dengan `SyRI`, dan pembuatan grafik komparasi dengan `plotsr`.
