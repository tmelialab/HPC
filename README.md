# High Performance Computing Mahameru Guide

## Apa itu High Performance Computing?

High Performance Computing (HPC) atau komputasi kinerja tinggi adalah penggunaan klaster komputer, pemrosesan paralel, dan infrastruktur canggih untuk memecahkan masalah komputasi yang rumit dan menangani data dalam jumlah sangat besar dengan kecepatan tinggi.
Secara umum, HPC berguna untuk mempercepat penemuan ilmiah, memodelkan simulasi yang kompleks, dan mengoptimalkan hasil bisnis yang tidak mungkin ditangani oleh komputer standar.

## Tentang MAHAMERU BRIN HPC

MAHAMERU adalah komputer klaster yang dikelola oleh Direktorat Pengelolaan Laboratorium, Fasilitas Riset, dan Kawasan Sains dan Teknologi (DPLFRKST), Badan Riset dan Inovasi Nasional (BRIN). Berikut spesifikasi utamanya:

### Sumber Daya Komputasi
| Komponen | Spesifikasi |
|---|---|
| Computing Nodes | 92 nodes (2 × 36 cores per node, 256 GB RAM per node) |
| Total Cores | ± 5.888 cores |
| High Memory Node | 1 node (8 × 28 cores, 1.5 TB RAM) — Lenovo SR950 |
| Login/Management Nodes | 2 nodes (SR630V2 + DE2000H Shared Storage) |
| Storage | 4.5 PB (DSS-G240) |
| GPU Cluster | NVIDIA DGX A100, DGX 1 (8 Card GPU V100), IBM Watson (2×2 GPU V100), 8 Blade Servers (1 GPU A100 each), HP 24 Computing Nodes (10 GPU P100) |
| Interconnect | InfiniBand HDR untuk computing network |

### Infrastruktur Jaringan
- Dedicated koneksi metro dan internet dedicated.
- IDREN metro 100 Mbps, internet 100 Mbps.
- Akses internet untuk download data/aplikasi **hanya dapat dilakukan melalui login node**. Pastikan sebelum bekerja di worker node, data yang akan diolah telah tersedia di local storage.

## Requirements 

1. Akun aktif ELSA BRIN, daftar melalui halaman berikut [https://elsa.brin.go.id](https://elsa.brin.go.id)
2. Laptop / Komputer yang memakai Windows ataupun Linux
3. Internet
4. Pemahaman dalam menggunakan SSH

## Daftar Akun ELSA BRIN
1. Pada link diatas, arahkan ke bagian masuk. atau ke: [https://elsa.brin.go.id/akun](https://elsa.brin.go.id/akun)
2. Daftarkan akun kamu dengan menyediakan Nama Lengkap, Alamat Email, dan Identitas diri
3. Setelah daftar, masuk ke akun ELSA BRIN untuk melakukan pengajuan layanan BRIN

## Daftar Layanan HPC Mahameru untuk Bioinformatika

[https://elsa.brin.go.id/layanan/index/%20HPC%20untuk%20%20Bioinformatika%20/6393](https://elsa.brin.go.id/layanan/index/%20HPC%20untuk%20%20Bioinformatika%20/6393)

Pada link diatas, mohon dibaca terlebih dahulu standar pelayanan yang ada. Setelah dibaca, mohon tekan tombol 'AJUKAN LAYANAN'. Lengkapi formulir sesuai dengan yang diminta, termasuk SSH Public Key untuk login. Ada beberapa hal yang harus kamu isi, diantaranya:

1. **RENCANA TANGGAL PELAKSANAAN** — Tanggal pelaksanaan layanan diisi dengan masa maksimal **1 tahun** (dapat diperpanjang di kemudian hari).
2. **JUDUL PROPOSAL** — Isi dengan memasukkan judul proposal/skripsi yang kamu kerjakan, masukkan secara jelas bahwa kamu menggunakan HPC di dalam judulnya.
3. **Abstrak** — Isi dengan abstrak yang ada di dalam proposal/skripsi yang sedang kamu kerjakan.
4. **Kata Kunci** — Masukkan sesuai dengan kata kunci yang ada di dalam proposal/skripsi.
5. **Tujuan** — Masukkan tujuan dari penggunaan HPC.
6. **Metodologi**
7. **Daftar Anggota** — Masukkan nama kamu sebagai nama utama, lalu masukkan nama dosen pembimbing setelahnya. **Bagi sivitas eksternal BRIN yang berstatus siswa/mahasiswa, wajib mencantumkan nama dosen pembimbing dari universitas dan/atau kolaborator dari BRIN.**
8. **Perangkat Lunak** — Tergantung dari dosen pembimbing dan kamu. Sebagai awalan, bisa memasukkan perangkat lunak seperti SLURM, CONDA, dan sesuai kebutuhan.
9. **Sumber Dana** — Tanyakan kepada dosen pembimbing lebih lanjut.
10. **Catatan**
11. **Keluaran** — Sesuaikan luarannya.
12. **Public Key** — Wajib mengunggah SSH public key. Lihat panduan di bawah untuk cara membuatnya.

### Catatan Penting Pengajuan:
- Pengelola layanan akan me-review ajuan layanan kamu.
- Keputusan berupa status **diterima/ditolak/ubah jadwal** berdasarkan hasil review terhadap isian formulir pengajuan.
- Notifikasi keputusan akan terkirim melalui **email** atau bisa dilihat melalui status layanan di ELSA.
- Akun yang dibuat dapat dilihat melalui menu **'Akun'** setelah login ke ELSA.
- Email kamu akan dimasukkan ke dalam mailing-list pengguna MAHAMERU BRIN HPC.

### Cara Mendapatkan Public Key

Untuk Windows

Jika SSH Belum terinstall, maka jalankan perintah berikut di dalam Powershell/Terminal (Run as Administrator)
``` bash
Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
```
lalu cek instalasi ssh dengan menggunakan command:
``` bash
ssh -V
```

setelah selesai terinstall, buat SSH Key baru dengan menggunakan command ssh-keygen
``` bash
ssh-keygen
```
untuk lokasi default, ikuti saja sesuai dari commandnya. seharusnya berada di C:\Users\<Username>\.ssh\

### Menggunakan SSH Key yang Telah Dibuat
Sebelum bisa login dengan key, kamu harus menyalin isi dari Public Key ke server tujuan. Setelah disalin, kamu cukup mengetikkan perintah ssh yang sama, dan sistem akan mengotentikasi menggunakan kunci kamu secara otomatis.

## Cara Login ke SSH HPC Mahameru

Untuk melakukan koneksi, diperlukan terminal yang bisa menggunakan SSH dan sudah melakukan setup pada public key untuk digunakan pada akun HPC Mahameru. Login ke HPC Mahameru bisa digunakan dengan melakukan perintah:
``` bash
ssh <username>@login2.hpc.brin.go.id
```

## Basic command Linux

``` bash
pwd             # Tampilkan direktori kerja saat ini
ls              # Daftar isi direktori
ls -l           # Daftar isi format panjang
ls -la          # Daftar isi semua file termasuk yang tersembunyi
cd              # Pindah ke direktori home
cd ..           # Kembali ke direktori sebelumnya (satu tingkat di atas)
cd ~            # Pindah ke direktori home pengguna
mkdir folder    # Buat direktori baru
touch file      # Buat file kosong baru
cp namafile     # Salin file atau direktori
mv namafile     # Pindahkan atau ganti nama file
rm namafile     # Hapus file
rm -rf namafile # Hapus direktori dan isinya secara paksa
cat namafile    # Tampilkan isi file
```

## Command yang sering digunakan dalam HPC

``` bash
module avail             # Lihat daftar modul software yang tersedia
module load namamodule   # Memuat modul software tertentu ke environment
module list              # Lihat daftar modul yang sedang aktif
module purge             # Menghapus semua modul yang sedang dimuat

sbatch namascript.sh    # Menjalankan script job ke antrian (Slurm)
squeue --me             # Lihat status antrian job milik sendiri
sacct                   # Lihat riwayat dan statistik job
scancel                 # Membatalkan atau menghentikan job
```

## Interactive mode HPC

Mode interaktif memungkinkan kamu untuk menjalankan perintah secara langsung pada compute node untuk keperluan debugging atau komputasi ringan. Jalankan perintah berikut untuk masuk ke mode interaktif:

``` bash
srun --partition=interactive --pty /bin/bash
```

# Contoh Skrip SLURM

Berikut adalah blueprint skrip SLURM yang umum digunakan. Kamu dapat menyesuaikan parameter sesuai dengan kebutuhan sumber daya komputasi kamu.

## Konfigurasi Parameter SLURM

Setiap parameter diawali dengan `#SBATCH` agar dibaca oleh job scheduler Slurm:

``` bash
#!/bin/bash
#SBATCH --job-name=nama_job        # Nama pekerjaan yang akan muncul di squeue
#SBATCH --output=logs/%j.log       # Path file output log (%j otomatis diganti dengan Job ID)
#SBATCH --error=logs/%j.err        # Path file error log
#SBATCH --nodes=1                  # Jumlah node yang diminta
#SBATCH --ntasks=1                 # Jumlah tugas (task) yang dijalankan
#SBATCH --cpus-per-task=4          # Jumlah CPU per task (cocok untuk multithreading)
#SBATCH --mem=16G                  # Total memori (RAM) yang dialokasikan
#SBATCH --time=02:00:00            # Batas waktu maksimal (Format: HH:MM:SS)
```

### Penjelasan Parameter Penting:
- **`--job-name`**: Memudahkan kamu memantau status job di antrian.
- **`--output` & `--error`**: Sangat penting untuk melacak proses dan troubleshooting jika terjadi kegagalan.
- **`--cpus-per-task`**: Sesuaikan dengan pengaturan *threads* pada perangkat lunak yang kamu gunakan.
- **`--mem`**: Pastikan alokasi memori mencukupi untuk menghindari error *Out of Memory* (OOM).
- **`--time`**: Job akan dihentikan paksa jika melewati batas waktu ini. Gunakan estimasi yang realistis.

### Konfigurasi yang bisa kamu gunakan dalam HPC Mahameru

HPC Mahameru menyediakan sumber daya komputasi yang besar untuk mendukung berbagai skala pekerjaan. Setiap computing node memiliki **256 GB RAM** dan **72 cores** (2 × 36). Sedangkan High Memory Node memiliki **1.5 TB RAM** dan **224 cores** (8 × 28).

## Arsitektur Partisi (Queue) SLURM

Sistem HPC Mahameru menggunakan partisi untuk membagi beban kerja berdasarkan durasi dan kebutuhan sumber daya. Berikut adalah data partisi aktual berdasarkan output `sinfo`:

| Partisi | Status | Walltime Limit | Jumlah Nodes | Keterangan |
|---|---|---|---|---|
| `short` (default) | Up | 1 hari (`1-00:00:00`) | 48 nodes | Partisi default untuk sebagian besar job |
| `medium-small` | Up | 3 hari (`3-00:00:00`) | 22 nodes | Untuk pekerjaan berdurasi menengah |
| `interactive` | Up | 2 jam (`2:00:00`) | 2 nodes | Untuk debugging dan komputasi ringan |

### 1. Interactive
Digunakan untuk pengujian skrip, debugging, atau komputasi ringan secara langsung.
- **Walltime Limit**: Maksimal **2 jam**.
- **Nodes**: 2 nodes dedicated (trembesi91, trembesi92).
- **Cara akses**: `srun --partition=interactive --pty /bin/bash`
- **Restrictions**: Gunakan hanya untuk keperluan interaktif, bukan job batch.

### 2. Short (Default)
Partisi default yang digunakan jika kamu tidak menentukan `--partition` dalam skrip SLURM.
- **Walltime Limit**: Maksimal **1 hari** (24 jam).
- **Nodes**: 48 nodes (trembesi03-50).
- **Cocok untuk**: Preprocessing data, analisis singkat, validasi pipeline.

### 3. Medium-Small
Untuk pekerjaan komputasi yang memerlukan waktu lebih lama dari partisi short.
- **Walltime Limit**: Maksimal **3 hari** (72 jam).
- **Nodes**: 22 nodes (trembesi51-72).
- **Cocok untuk**: Simulasi, analisis bioinformatika skala menengah, pembuatan database.


## Catatan Penting

### Masa Aktif Akun (Keep-Alive Check)
Sebagai mekanisme *keep-alive check*, akses pengguna akan **expired secara otomatis** secara berkala:
- **Sivitas BRIN**: Expired setiap **6 bulan**.
- **Sivitas eksternal BRIN**: Expired setiap **3 bulan**.

Jika akses telah expired, lakukan langkah berikut:
1. Isi **Laporan Penggunaan** di ELSA.
2. Kirim email ke `hpc [at] brin [dot] go [dot] id` dengan:
   - **Subyek**: AKTIVASI
   - **Isi**: Username yang digunakan dan nomor ID proposal di ELSA.

### Akses Internet dari Node
Akses internet untuk download data/aplikasi **hanya dapat dilakukan melalui login node**. Pastikan sebelum bekerja di worker node, semua data yang akan diolah telah tersedia di local storage.
