# High Performance Computing Mahameru Guide

## Apa itu High Performance Computing?

High Performance Computing (HPC) atau komputasi kinerja tinggi adalah penggunaan klaster komputer, pemrosesan paralel, dan infrastruktur canggih untuk memecahkan masalah komputasi yang rumit dan menangani data dalam jumlah sangat besar dengan kecepatan tinggi.
Secara umum, HPC berguna untuk mempercepat penemuan ilmiah, memodelkan simulasi yang kompleks, dan mengoptimalkan hasil bisnis yang tidak mungkin ditangani oleh komputer standar. 

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

Pada link diatas, mohon dibaca terlebih dahulu standar pelayanan yang ada. Setelah dibaca, mohon tekan tombol 'AJUKAN LAYANAN'. ada beberapa hal yang harus kamu isi, diantaranya adalah:

1. RENCANA TANGGAL PELAKSANAAN
Isi selama 3 Bulan, dimulai dari awal kamu melakukan ajuan layanan dan berakhir untuk 3 bulan kedepan
2. JUDUL PROPOSAL
Isi dengan memasukkan judul proposal/skripsi yang kamu kerjakan, masukkan secara jelas bahwa kamu menggunakan HPC di dalam judulnya
3. Abstrak
Isi dengan abstrak yang ada di dalam proposal/skripsi yang sedang kamu kerjakan
4. Kata Kunci
Sama seperti diatas, masukkan saja sesuai dengan kata kunci yang ada di dalam proposal/skripsi
5. Tujuan
Masukkan tujuan dari penggunaan HPC
6. Metodologi
7. Daftar Anggota
Untuk daftar anggota, masukkan nama kamu sebagai nama utama, lalu masukkan nama dosen pembimbing setelahnya
8. Perangkat Lunak
untuk pengisian perangkat lunak, tergantung dari dosen pembimbing dan kamu. sebagai awalan, bisa dengan memasukkan perangkat lunak seperti SLURM, CONDA, dan sesuai dengan kebutuhan
9. Sumber Dana
Tanyakan kepada dosen pembimbing lebih lanjut
10. Catatan
11. Keluaran
Sesuaikan luarannya
12. Public Key
masukkan public key yang kamu sudah siapkan

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

``` bash
srun --partition=interactive --pty /bin/bash
```