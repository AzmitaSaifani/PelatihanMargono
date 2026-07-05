Website Pendaftaran Pelatihan Diklat RSUD Prof. Dr. Margono Soekarjo

Website Pendaftaran Pelatihan Diklat merupakan sistem informasi berbasis web yang dikembangkan untuk mendukung proses pengelolaan pelatihan di Bidang Diklat RSUD Prof. Dr. Margono Soekarjo Purwokerto. Sistem ini memfasilitasi proses pendaftaran peserta, pengelolaan program pelatihan, verifikasi administrasi, pembayaran, serta pengiriman notifikasi secara otomatis melalui Email dan WhatsApp.

> Repository ini dibuat sebagai bagian dari kegiatan **Kerja Praktik** Program Studi Teknik Informatika.

A. Fitur Utama
 1. Halaman Pengguna
- Home
- Profil Diklat
- Program Pelatihan
- Kalender Pelatihan
- Alur Pendaftaran
- Tim dan Mitra
- Dokumentasi
- Kontak
- Kritik dan Saran
- Form Pendaftaran Pelatihan
- Upload Bukti Pembayaran

 2. Halaman Administrator
- Dashboard
- Kelola Program Pelatihan
- Kelola Kalender Pelatihan
- Kelola Data Pendaftaran
- Verifikasi Berkas
- Kelola Pembayaran
- Verifikasi Pembayaran
- Kelola Profil Institusi
- Kelola Struktur Organisasi
- Kelola Tim Kerja
- Kelola Tim Penyelenggara
- Kelola Fasilitator
- Kelola Institusi Kerjasama
- Kelola Dokumentasi
- Kelola Sertifikat Akreditasi
- Kelola User Admin (Super Admin)
- Log Aktivitas Admin
- Log Pengiriman Email
- Log Pengiriman WhatsApp

B. Teknologi yang Digunakan
 1. Frontend
- HTML5
- CSS3
- Bootstrap 5
- JavaScript

 2. Backend
- Node.js
- Express.js

 3. Database
- MySQL

 4. Library & Package
- Multer
- Nodemailer
- ExcelJS
- JWT Authentication
- bcrypt
- Axios
- dotenv
- CORS

C. Struktur Project
project/
│
├── backend/
│   ├── config/
│   ├── middleware/
│   ├── routes/
│   ├── uploads/
│   ├── utils/
│   └── server.js
│
├── frontend/
│   ├── admin/
│   ├── assets/
│   ├── css/
│   ├── js/
│   ├── uploads/
│   └── index.html
│
└── database/
    └── pelatihanmargono1.sql

D. Fitur Sistem
- Manajemen Program Pelatihan
- Pendaftaran Peserta Online
- Upload Berkas Persyaratan
- Upload Bukti Pembayaran
- Verifikasi Administrasi
- Verifikasi Pembayaran
- Kalender Pelatihan
- Manajemen Profil Institusi
- Manajemen Tim & Mitra
- Struktur Organisasi
- Pengiriman Notifikasi Email
- Pengiriman Notifikasi WhatsApp
- Export Data ke Microsoft Excel
- Log Aktivitas Sistem


E. Hak Akses
 1. Super Admin
- Mengelola seluruh fitur sistem
- Mengelola akun administrator
- Monitoring log aktivitas

 2. Admin
- Mengelola pelatihan
- Mengelola peserta
- Verifikasi berkas
- Verifikasi pembayaran
- Mengelola konten website
- Monitoring notifikasi

 3. Peserta
- Melihat informasi pelatihan
- Mendaftar pelatihan
- Upload pembayaran
- Menerima notifikasi Email & WhatsApp


F. Pengujian
Metode pengujian menggunakan:
- Black Box Testing
Seluruh fitur utama telah diuji dan berjalan sesuai kebutuhan fungsional sistem.


G. Dokumentasi
Sistem dikembangkan menggunakan metode **Waterfall** yang meliputi:
- Analisis Kebutuhan
- Perancangan Sistem
- Implementasi
- Pengujian
- Deployment (Planned)


H. Developer
**Azmita Saifani Aqilah**
Program Studi Teknik Informatika
Universitas Muhammadiyah Purwokerto


I. Lisensi
Repository ini dibuat untuk keperluan akademik sebagai proyek Kerja Praktik. Seluruh hak cipta dan penggunaan sistem mengikuti ketentuan yang berlaku di RSUD Prof. Dr. Margono Soekarjo Purwokerto.
