# High Performance Computing Mahameru Guide

## Apa itu High Performance Computing?

High Performance Computing (HPC) atau komputasi kinerja tinggi adalah penggunaan klaster komputer, pemrosesan paralel, dan infrastruktur canggih untuk memecahkan masalah komputasi yang rumit dan menangani data dalam jumlah sangat besar dengan kecepatan tinggi.
Secara umum, HPC berguna untuk mempercepat penemuan ilmiah, memodelkan simulasi yang kompleks, dan mengoptimalkan hasil bisnis yang tidak mungkin ditangani oleh komputer standar. 

## Requirements 

1. Akun aktif ELSA BRIN, daftar melalui halaman berikut 
```bash
https://elsa.brin.go.id
```
2. Laptop / Komputer yang memakai Windows ataupun Linux
3. Internet
4. Pemahaman dalam menggunakan SSH

## Daftar Akun ELSA BRIN
1. Pada link diatas, arahkan ke bagian masuk. atau ke:
```bash
https://elsa.brin.go.id/akun
```
2. Daftarkan akun kamu dengan menyediakan Nama Lengkap, Alamat Email, dan Identitas diri
3. Setelah daftar, masuk ke akun ELSA BRIN untuk melakukan pengajuan layanan BRIN

## Daftar Layanan HPC Mahameru untuk Bioinformatika

```bash
https://elsa.brin.go.id/layanan/index/%20HPC%20untuk%20%20Bioinformatika%20/6393
```

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

To be Continued

## Cara Login ke SSH HPC Mahameru

Untuk melakukan koneksi, diperlukan terminal yang bisa menggunakan SSH dan sudah melakukan setup pada public key untuk digunakan pada akun HPC Mahameru. Login ke HPC Mahameru bisa digunakan dengan melakukan perintah:
``` bash
ssh <username>@login2.hpc.brin.go.id
```
