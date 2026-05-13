-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3307
-- Generation Time: Mar 26, 2026 at 12:29 PM
-- Server version: 10.4.32-MariaDB
-- PHP Version: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `pelatihanmargono1`
--

-- --------------------------------------------------------

--
-- Table structure for table `anggota_jabatan`
--

CREATE TABLE `anggota_jabatan` (
  `id` int(11) NOT NULL,
  `id_anggota` int(11) NOT NULL,
  `id_jabatan` int(11) NOT NULL,
  `is_utama` tinyint(1) DEFAULT 1,
  `mulai_menjabat` date DEFAULT NULL,
  `selesai_menjabat` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `anggota_jabatan`
--

INSERT INTO `anggota_jabatan` (`id`, `id_anggota`, `id_jabatan`, `is_utama`, `mulai_menjabat`, `selesai_menjabat`) VALUES
(2, 1, 2, 1, '2026-02-25', NULL),
(3, 2, 3, 1, '2026-02-25', NULL),
(7, 6, 12, 1, '2026-02-25', NULL),
(8, 7, 13, 1, '2026-02-25', NULL),
(9, 8, 14, 1, '2026-02-25', NULL),
(17, 1, 1, 1, '2026-02-27', NULL),
(22, 9, 21, 1, '2026-02-27', NULL),
(23, 10, 8, 1, '2026-02-27', NULL),
(24, 11, 10, 1, '2026-03-13', NULL),
(25, 4, 24, 1, '2026-03-13', NULL),
(26, 5, 25, 1, '2026-03-13', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `anggota_organisasi`
--

CREATE TABLE `anggota_organisasi` (
  `id_anggota` int(11) NOT NULL,
  `nama_lengkap` varchar(150) NOT NULL,
  `nip` varchar(30) DEFAULT NULL,
  `email` varchar(100) DEFAULT NULL,
  `no_hp` varchar(20) DEFAULT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `status` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `anggota_organisasi`
--

INSERT INTO `anggota_organisasi` (`id_anggota`, `nama_lengkap`, `nip`, `email`, `no_hp`, `foto`, `status`, `created_at`) VALUES
(1, 'Arikh Ratna Purwadi, S.Kep.Ns., MH', '2203040407', 'arikh@gmail.com', '087878787878', '1770654634607.JPG', 1, '2026-02-09 16:20:36'),
(2, 'dr. JUANITA INDRATI, MM', '', '', '', '1771956973293.jpg', 1, '2026-02-24 18:16:13'),
(4, 'RADITYA NORISKI, SKM', '', '', '', '1771957007274.jpg', 1, '2026-02-24 18:16:47'),
(5, 'SALSABILLA RUSHDA, SKM', '', '', '', '1771957032225.jpg', 1, '2026-02-24 18:17:12'),
(6, 'TIO AMIRUDIN, S.Kom', '', '', '', '1771957047876.jpg', 1, '2026-02-24 18:17:27'),
(7, 'ARA AMALIA, SKM', '', '', '', '1771957064041.jpg', 1, '2026-02-24 18:17:44'),
(8, 'DENY INDRIANTO', '', '', '', '1771957075192.jpg', 1, '2026-02-24 18:17:55'),
(9, 'ZANUAR FAUZI', '', '', '', '1771957086160.jpg', 1, '2026-02-24 18:18:06'),
(10, 'ABDUL ROSID', '', '', '', '1772425608776.jpg', 1, '2026-02-26 18:17:46'),
(11, 'Hesti Yunita, S.Pd', '', '', '', '1773376497036.jpg', 1, '2026-03-13 04:34:57');

-- --------------------------------------------------------

--
-- Table structure for table `dokumentasi_tb`
--

CREATE TABLE `dokumentasi_tb` (
  `id` int(11) NOT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `kategori` enum('pelatihan','sarpras','diskusi') NOT NULL,
  `status` enum('1','0') DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `dokumentasi_tb`
--

INSERT INTO `dokumentasi_tb` (`id`, `keterangan`, `foto`, `kategori`, `status`) VALUES
(61, 'DIKLAT RSMS', '1772376412400-940935904.jpg', 'sarpras', '1'),
(62, 'RUANG DISKUSI', '1772376422576-238436654.jpg', 'sarpras', '1'),
(63, 'RENOVASI RUANG DIKLIT', '1772376432913-287728490.jpg', 'sarpras', '1'),
(64, 'FASILITAS PELATIHAN RSMS', '1772376449872-708192439.jpg', 'sarpras', '1'),
(65, 'KOORDINASI BANGKOMAR DIGDAYA', '1772376687762-437165502.jpeg', 'diskusi', '1'),
(66, 'PERSAMAAN PERSEPSI BIMBINGAN MAHASISWA PRAKTIK KEPERAWATAN STASE MANAJEMEN', '1772376733406-199245804.jpeg', 'diskusi', '1'),
(67, 'USULAN KEBUTUHAN PENGEMBANGAN KOMPETENSI PENDIDIKAN DAN PELATIHAN 2026', '1772376794272-522958499.JPG', 'diskusi', '1'),
(68, 'MENTORING MAHASISWA', '1772376835773-788779795.jpeg', 'pelatihan', '1'),
(69, 'PELATIHAN ACLS', '1772376848286-505267000.jpeg', 'pelatihan', '1'),
(70, 'PENERIMAAN MAHASISWA MAGANG 2', '1772376870465-296409966.jpeg', 'pelatihan', '1'),
(71, 'PELATIHAN RSMS', '1772376926181-426255543.JPG', 'pelatihan', '1'),
(72, 'MANEKIN BREAST CARE', '1773382235789-941006617.jpeg', 'sarpras', '1'),
(73, 'PELATIHAN PTO', '1774524329502-931570763.jpeg', 'pelatihan', '1');

-- --------------------------------------------------------

--
-- Table structure for table `email_log_tb`
--

CREATE TABLE `email_log_tb` (
  `id_email_log` int(11) NOT NULL,
  `id_pendaftaran` int(11) DEFAULT NULL,
  `email` varchar(150) DEFAULT NULL,
  `nama_penerima` varchar(150) DEFAULT NULL,
  `jenis_email` enum('BERKAS_PENDING','BERKAS_VALID','BERKAS_INVALID','PEMBAYARAN_PENDING','PEMBAYARAN_VALID','PEMBAYARAN_INVALID') DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `status` enum('TERKIRIM','GAGAL') DEFAULT 'TERKIRIM',
  `error_message` text DEFAULT NULL,
  `sent_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `email_log_tb`
--

INSERT INTO `email_log_tb` (`id_email_log`, `id_pendaftaran`, `email`, `nama_penerima`, `jenis_email`, `subject`, `status`, `error_message`, `sent_at`) VALUES
(1, 47, 'saifaniazmita@gmail.com', 'Maemunah Sarif', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-01-14 17:57:59'),
(2, 47, 'saifaniazmita@gmail.com', 'Maemunah Sarif', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-01-14 17:58:10'),
(3, 47, 'saifaniazmita@gmail.com', 'Maemunah Sarif', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-01-14 17:58:32'),
(4, 47, 'saifaniazmita@gmail.com', 'Maemunah Sarif', 'PEMBAYARAN_VALID', 'Konfirmasi Pembayaran & Pendaftaran Diterima', 'GAGAL', 'sent is not defined', '2026-01-14 18:00:09'),
(5, 48, 'saifaniazmita@gmail.com', 'Sultanul Arimaza', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-01-14 18:04:05'),
(6, 48, 'saifaniazmita@gmail.com', 'Sultanul Arimaza', 'PEMBAYARAN_VALID', 'Konfirmasi Pembayaran & Pendaftaran Diterima', 'GAGAL', 'sent is not defined', '2026-01-14 18:05:32'),
(7, 44, 'saifaniazmita@gmail.com', 'Saifani A', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-01-14 18:09:05'),
(8, 44, 'saifaniazmita@gmail.com', 'Saifani A', 'PEMBAYARAN_VALID', 'Konfirmasi Pembayaran & Pendaftaran Diterima', 'TERKIRIM', NULL, '2026-01-14 18:13:04'),
(9, NULL, 'saifaniazmita@gmail.com', 'Saifani Aweawe', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-01-14 18:16:56'),
(10, NULL, 'saifaniazmita@gmail.com', 'Maemunah Sarif', '', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-01-14 18:27:37'),
(11, NULL, 'saifaniazmita@gmail.com', 'Mamamiamaia', '', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-01-14 18:34:34'),
(12, NULL, 'saifaniazmita@gmail.com', 'Azmita', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-01-14 18:46:43'),
(13, 51, 'saifaniazmita@gmail.com', 'Saifani Aweawe', 'BERKAS_VALID', 'Berkas Dinyatakan Valid – Menunggu Pembayaran', 'GAGAL', 'Gagal kirim email', '2026-01-14 18:47:23'),
(14, 56, 'saifaniazmita@gmail.com', 'Azmitassdadada', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-01-14 18:59:27'),
(15, 56, 'saifaniazmita@gmail.com', 'Azmitassdadada', 'BERKAS_VALID', 'Berkas Dinyatakan Valid – Menunggu Pembayaran', 'GAGAL', 'Gagal kirim email', '2026-01-14 19:00:08'),
(16, 53, 'saifaniazmita@gmail.com', 'Maemunahhhhh', 'BERKAS_VALID', 'Berkas Dinyatakan Valid – Menunggu Pembayaran', 'TERKIRIM', NULL, '2026-01-14 19:23:20'),
(17, 54, 'saifaniazmita@gmail.com', 'Mamamiamaia', 'BERKAS_INVALID', 'Berkas Tidak Valid', 'TERKIRIM', NULL, '2026-01-14 19:23:47'),
(18, 51, 'saifaniazmita@gmail.com', 'Saifani Aweawe', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-01-14 19:24:32'),
(19, 51, 'saifaniazmita@gmail.com', 'Saifani Aweawe', 'PEMBAYARAN_INVALID', 'Informasi Pembayaran Belum Valid', 'TERKIRIM', NULL, '2026-01-14 19:24:47'),
(20, 56, 'saifaniazmita@gmail.com', 'Azmitassdadada', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-01-14 19:33:27'),
(21, 52, 'saifaniazmita@gmail.com', 'Maemunah Sarif', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-01-14 19:40:03'),
(22, 52, 'saifaniazmita@gmail.com', 'Maemunah Sarif', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-01-14 19:57:56'),
(23, 52, 'saifaniazmita@gmail.com', 'Maemunah Sarif', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-01-14 20:13:33'),
(24, 52, 'saifaniazmita@gmail.com', 'Maemunah Sarif', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-01-14 20:21:11'),
(25, 52, 'saifaniazmita@gmail.com', 'Maemunah Sarif', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-01-14 20:21:24'),
(26, 52, 'saifaniazmita@gmail.com', 'Maemunah Sarif', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-01-14 20:21:39'),
(27, 52, 'saifaniazmita@gmail.com', 'Maemunah Sarif', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-01-14 20:25:57'),
(28, 55, 'saifaniazmita@gmail.com', 'Azmita', 'BERKAS_INVALID', 'Berkas Tidak Valid', 'TERKIRIM', NULL, '2026-01-16 15:00:08'),
(29, 56, 'saifaniazmita@gmail.com', 'Azmitassdadada', 'PEMBAYARAN_VALID', 'Konfirmasi Pembayaran & Pendaftaran Diterima', 'GAGAL', 'link_grup_wa is not defined', '2026-01-21 13:29:23'),
(30, 52, 'saifaniazmita@gmail.com', 'Maemunah Sarif', 'PEMBAYARAN_VALID', 'Konfirmasi Pembayaran & Pendaftaran Diterima', 'TERKIRIM', NULL, '2026-01-21 13:51:13'),
(31, 57, 'saifaniazmita@gmail.com', 'Azmitas', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-01-21 14:37:32'),
(32, 57, 'saifaniazmita@gmail.com', 'Azmitas', 'BERKAS_VALID', 'Berkas Dinyatakan Valid – Menunggu Pembayaran', 'TERKIRIM', NULL, '2026-01-21 14:40:39'),
(33, 57, 'saifaniazmita@gmail.com', 'Azmitas', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-01-21 14:41:13'),
(34, 57, 'saifaniazmita@gmail.com', 'Azmitas', 'PEMBAYARAN_VALID', 'Konfirmasi Pembayaran & Pendaftaran Diterima', 'GAGAL', 'lokasi is not defined', '2026-01-21 14:41:40'),
(35, 53, 'saifaniazmita@gmail.com', 'Maemunahhhhh', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-01-21 14:43:24'),
(36, 53, 'saifaniazmita@gmail.com', 'Maemunahhhhh', 'PEMBAYARAN_VALID', 'Konfirmasi Pembayaran & Pendaftaran Diterima', 'GAGAL', 'lokasi is not defined', '2026-01-21 14:43:46'),
(37, 58, 'saifaniazmita@gmail.com', 'Azmita', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-01-21 14:54:11'),
(38, 58, 'saifaniazmita@gmail.com', 'Azmita', 'BERKAS_VALID', 'Berkas Dinyatakan Valid – Menunggu Pembayaran', 'TERKIRIM', NULL, '2026-01-21 14:54:24'),
(39, 58, 'saifaniazmita@gmail.com', 'Azmita', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-01-21 14:55:02'),
(40, 58, 'saifaniazmita@gmail.com', 'Azmita', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-01-21 14:55:05'),
(41, 58, 'saifaniazmita@gmail.com', 'Azmita', 'PEMBAYARAN_VALID', 'Konfirmasi Pembayaran & Pendaftaran Diterima', 'TERKIRIM', NULL, '2026-01-21 14:55:37'),
(42, 59, 'saifaniazmita@gmail.com', 'Azmita', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-01-21 15:02:51'),
(43, 59, 'saifaniazmita@gmail.com', 'Azmita', 'BERKAS_VALID', 'Berkas Dinyatakan Valid – Menunggu Pembayaran', 'TERKIRIM', NULL, '2026-01-21 15:03:07'),
(44, 59, 'saifaniazmita@gmail.com', 'Azmita', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-01-21 15:03:32'),
(45, 59, 'saifaniazmita@gmail.com', 'Azmita', 'PEMBAYARAN_VALID', 'Konfirmasi Pembayaran & Pendaftaran Diterima', 'TERKIRIM', NULL, '2026-01-21 15:04:08'),
(46, 60, 'saifaniazmita@gmail.com', 'Azmita', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-01-21 15:07:48'),
(47, 60, 'saifaniazmita@gmail.com', 'Azmita', 'BERKAS_VALID', 'Berkas Dinyatakan Valid – Menunggu Pembayaran', 'TERKIRIM', NULL, '2026-01-21 15:08:00'),
(48, 60, 'saifaniazmita@gmail.com', 'Azmita', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-01-21 15:08:26'),
(49, 60, 'saifaniazmita@gmail.com', 'Azmita', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-01-21 15:08:29'),
(50, 60, 'saifaniazmita@gmail.com', 'Azmita', 'PEMBAYARAN_VALID', 'Konfirmasi Pembayaran & Pendaftaran Diterima', 'TERKIRIM', NULL, '2026-01-21 15:08:50'),
(51, 61, 'saifaniazmita@gmail.com', 'Azmita', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-01-21 15:10:31'),
(52, 61, 'saifaniazmita@gmail.com', 'Azmita', 'BERKAS_VALID', 'Berkas Dinyatakan Valid – Menunggu Pembayaran', 'TERKIRIM', NULL, '2026-01-21 15:10:57'),
(53, 61, 'saifaniazmita@gmail.com', 'Azmita', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-01-21 15:11:43'),
(54, 61, 'saifaniazmita@gmail.com', 'Azmita', 'PEMBAYARAN_VALID', 'Konfirmasi Pembayaran & Pendaftaran Diterima', 'TERKIRIM', NULL, '2026-01-21 15:12:23'),
(55, 60, 'saifaniazmita@gmail.com', 'Azmita', 'PEMBAYARAN_VALID', 'Konfirmasi Pembayaran & Pendaftaran Diterima', 'TERKIRIM', NULL, '2026-01-21 16:54:05'),
(56, 55, 'saifaniazmita@gmail.com', 'Azmita', 'BERKAS_VALID', 'Berkas Dinyatakan Valid – Menunggu Pembayaran', 'TERKIRIM', NULL, '2026-01-21 17:02:51'),
(57, 62, 'saifaniazmita@gmail.com', 'Saifani ', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-01-21 19:30:36'),
(58, 62, 'saifaniazmita@gmail.com', 'Saifani ', 'BERKAS_VALID', 'Berkas Dinyatakan Valid – Menunggu Pembayaran', 'TERKIRIM', NULL, '2026-01-21 19:31:26'),
(59, 62, 'saifaniazmita@gmail.com', 'Saifani ', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-01-21 19:32:30'),
(60, 55, 'saifaniazmita@gmail.com', 'Azmita', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-01-21 19:41:51'),
(61, 62, 'saifaniazmita@gmail.com', 'Saifani ', 'PEMBAYARAN_VALID', 'Konfirmasi Pembayaran & Pendaftaran Diterima', 'TERKIRIM', NULL, '2026-01-21 19:42:45'),
(62, 63, 'saifaniazmita@gmail.com', 'Azmita', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-01-23 22:26:05'),
(63, 64, 'saifaniazmita@gmail.com', 'azmitmit', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-02-15 18:06:09'),
(64, 64, 'saifaniazmita@gmail.com', 'azmitmit', 'BERKAS_VALID', 'Berkas Dinyatakan Valid – Menunggu Pembayaran', 'TERKIRIM', NULL, '2026-02-15 18:07:25'),
(65, 64, 'saifaniazmita@gmail.com', 'azmitmit', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-02-15 18:12:12'),
(66, 64, 'saifaniazmita@gmail.com', 'azmitmit', 'PEMBAYARAN_VALID', 'Konfirmasi Pembayaran & Pendaftaran Diterima', 'TERKIRIM', NULL, '2026-02-15 18:12:55'),
(67, 55, 'saifaniazmita@gmail.com', 'Azmita', 'PEMBAYARAN_VALID', 'Konfirmasi Pembayaran & Pendaftaran Diterima', 'TERKIRIM', NULL, '2026-02-22 00:06:19'),
(68, 51, 'saifaniazmita@gmail.com', 'Saifani Aweawe', 'PEMBAYARAN_VALID', 'Konfirmasi Pembayaran & Pendaftaran Diterima', 'TERKIRIM', NULL, '2026-02-22 00:06:33'),
(69, 54, 'saifaniazmita@gmail.com', 'Mamamiamaia', 'BERKAS_VALID', 'Berkas Dinyatakan Valid – Menunggu Pembayaran', 'TERKIRIM', NULL, '2026-02-22 00:07:14'),
(70, 63, 'saifaniazmita@gmail.com', 'Azmita', 'BERKAS_VALID', 'Berkas Dinyatakan Valid – Menunggu Pembayaran', 'TERKIRIM', NULL, '2026-02-23 15:15:50'),
(71, 63, 'saifaniazmita@gmail.com', 'Azmita', 'PEMBAYARAN_VALID', 'Konfirmasi Pembayaran & Pendaftaran Diterima', 'TERKIRIM', NULL, '2026-02-23 15:20:09'),
(72, 66, 'saifaniazmita@gmail.com', 'aixaixxxx', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-02-24 21:57:43'),
(73, 67, 'saifaniazmita@gmail.com', 'sadsadad', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-02-24 22:06:39'),
(74, 68, 'galihdwia007@gmail.com', 'galihhh', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-02 10:03:50'),
(75, 68, 'galihdwia007@gmail.com', 'galihhh', 'BERKAS_VALID', 'Berkas Dinyatakan Valid – Menunggu Pembayaran', 'TERKIRIM', NULL, '2026-03-02 10:08:38'),
(76, 68, 'galihdwia007@gmail.com', 'galihhh', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-03-02 10:25:52'),
(77, 68, 'galihdwia007@gmail.com', 'galihhh', 'PEMBAYARAN_VALID', 'Konfirmasi Pembayaran & Pendaftaran Diterima', 'TERKIRIM', NULL, '2026-03-02 10:26:39'),
(78, 63, 'saifaniazmita@gmail.com', 'Azmita', 'PEMBAYARAN_VALID', 'Konfirmasi Pembayaran & Pendaftaran Diterima', 'TERKIRIM', NULL, '2026-03-11 01:55:23'),
(79, 69, 'saifaniazmita@gmail.com', 'AZMITAAA', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-11 10:35:20'),
(80, 69, 'saifaniazmita@gmail.com', 'AZMITAAA', 'BERKAS_VALID', 'Berkas Dinyatakan Valid – Menunggu Pembayaran', 'TERKIRIM', NULL, '2026-03-11 10:36:07'),
(81, 69, 'saifaniazmita@gmail.com', 'AZMITAAA', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-03-11 10:37:07'),
(82, 69, 'saifaniazmita@gmail.com', 'AZMITAAA', 'PEMBAYARAN_VALID', 'Konfirmasi Pembayaran & Pendaftaran Diterima', 'TERKIRIM', NULL, '2026-03-11 10:38:07'),
(83, 70, 'saifaniazmita@gmail.com', 'AZMIT', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-13 01:13:21'),
(84, 70, 'saifaniazmita@gmail.com', 'AZMIT', 'BERKAS_VALID', 'Berkas Dinyatakan Valid – Menunggu Pembayaran', 'TERKIRIM', NULL, '2026-03-13 01:13:54'),
(85, 70, 'saifaniazmita@gmail.com', 'AZMIT', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-03-13 11:49:56'),
(86, 70, 'saifaniazmita@gmail.com', 'AZMIT', 'PEMBAYARAN_VALID', 'Konfirmasi Pembayaran & Pendaftaran Diterima', 'TERKIRIM', NULL, '2026-03-13 11:50:13'),
(87, 71, 'saifaniazmita@gmail.com', 'azmi', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-13 12:01:58'),
(88, 71, 'saifaniazmita@gmail.com', 'azmi', 'BERKAS_VALID', 'Berkas Dinyatakan Valid – Menunggu Pembayaran', 'TERKIRIM', NULL, '2026-03-13 12:02:45'),
(89, 71, 'saifaniazmita@gmail.com', 'azmi', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-03-13 12:05:33'),
(90, 71, 'saifaniazmita@gmail.com', 'azmi', 'PEMBAYARAN_VALID', 'Konfirmasi Pembayaran & Pendaftaran Diterima', 'TERKIRIM', NULL, '2026-03-13 12:05:57'),
(91, 71, 'saifaniazmita@gmail.com', 'azmi', 'BERKAS_VALID', 'Berkas Dinyatakan Valid – Menunggu Pembayaran', 'TERKIRIM', NULL, '2026-03-13 12:15:07'),
(92, 71, 'saifaniazmita@gmail.com', 'azmi', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-03-13 12:15:49'),
(93, 71, 'saifaniazmita@gmail.com', 'azmi', 'PEMBAYARAN_VALID', 'Konfirmasi Pembayaran & Pendaftaran Diterima', 'TERKIRIM', NULL, '2026-03-13 12:16:11'),
(94, 71, 'saifaniazmita@gmail.com', 'azmi', 'BERKAS_VALID', 'Berkas Dinyatakan Valid – Menunggu Pembayaran', 'TERKIRIM', NULL, '2026-03-13 14:20:19'),
(95, 70, 'saifaniazmita@gmail.com', 'AZMIT', 'BERKAS_VALID', 'Berkas Dinyatakan Valid – Menunggu Pembayaran', 'GAGAL', NULL, '2026-03-13 14:21:21'),
(96, 70, 'saifaniazmita@gmail.com', 'AZMIT', 'BERKAS_VALID', 'Berkas Dinyatakan Valid – Menunggu Pembayaran', 'TERKIRIM', NULL, '2026-03-13 14:27:26'),
(97, 70, 'saifaniazmita@gmail.com', 'AZMIT', 'BERKAS_VALID', 'Berkas Dinyatakan Valid – Menunggu Pembayaran', 'TERKIRIM', NULL, '2026-03-13 14:32:41'),
(98, 70, 'saifaniazmita@gmail.com', 'AZMIT', 'BERKAS_VALID', 'Berkas Dinyatakan Valid – Menunggu Pembayaran', 'TERKIRIM', NULL, '2026-03-13 14:33:56'),
(99, 70, 'saifaniazmita@gmail.com', 'AZMIT', 'BERKAS_VALID', 'Berkas Dinyatakan Valid – Menunggu Pembayaran', 'TERKIRIM', NULL, '2026-03-13 14:35:51'),
(100, 70, 'saifaniazmita@gmail.com', 'AZMIT', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-03-13 14:36:33'),
(101, 71, 'saifaniazmita@gmail.com', 'azmi', 'BERKAS_VALID', 'Berkas Dinyatakan Valid – Menunggu Pembayaran', 'TERKIRIM', NULL, '2026-03-13 14:37:27'),
(102, 72, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-13 14:58:14'),
(103, 73, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-13 15:04:41'),
(104, 74, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-13 15:08:48'),
(105, 75, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-13 15:13:11'),
(106, 76, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-13 15:16:19'),
(107, 77, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-13 15:18:59'),
(108, 78, 'saifaniazmita@gmail.com', 'Wahyu', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-13 15:21:04'),
(109, 79, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-13 15:25:10'),
(110, 80, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'GAGAL', 'nomorWA is not defined', '2026-03-13 15:29:47'),
(111, 81, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'GAGAL', 'nomorWA is not defined', '2026-03-13 15:32:31'),
(112, 82, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-13 15:35:21'),
(113, 83, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-13 15:36:34'),
(114, 84, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-14 00:04:44'),
(115, 85, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-14 01:10:05'),
(116, 86, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-14 01:16:04'),
(117, 87, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-14 01:18:49'),
(118, 88, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-14 01:23:06'),
(119, 89, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'GAGAL', 'Cannot access \'pesanWA\' before initialization', '2026-03-14 01:25:29'),
(120, 90, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-14 01:27:55'),
(121, 91, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-14 01:32:42'),
(122, 92, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-14 01:35:47'),
(123, 93, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-17 15:46:21'),
(124, 97, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-17 16:02:29'),
(125, 98, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-17 16:06:24'),
(126, 99, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-17 16:12:05'),
(127, 100, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-17 16:15:23'),
(128, 101, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-17 16:20:09'),
(129, 102, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-17 16:21:57'),
(130, 103, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-17 16:27:38'),
(131, 105, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-17 16:29:04'),
(132, 106, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-17 16:37:06'),
(133, 107, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-17 16:41:12'),
(134, 108, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-17 20:08:49'),
(135, 109, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'GAGAL', 'nomorWA is not defined', '2026-03-17 20:11:44'),
(136, 110, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-17 20:13:26'),
(137, 111, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-17 20:20:09'),
(138, 112, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-17 20:23:05'),
(139, 113, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-17 20:27:29'),
(140, 114, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-17 20:28:59'),
(141, 115, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-17 20:37:19'),
(142, 116, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-17 20:41:28'),
(143, 117, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-17 20:44:11'),
(144, 118, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-17 20:49:40'),
(145, 119, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-17 20:51:44'),
(146, 120, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-17 22:50:03'),
(147, 121, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-17 23:01:22'),
(148, 122, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-17 23:04:54'),
(149, 123, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-17 23:08:03'),
(150, 124, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-17 23:13:03'),
(151, 125, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-17 23:26:10'),
(152, 125, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_VALID', 'Berkas Dinyatakan Valid – Menunggu Pembayaran', 'TERKIRIM', NULL, '2026-03-20 23:20:41'),
(153, 124, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_VALID', 'Berkas Dinyatakan Valid – Menunggu Pembayaran', 'TERKIRIM', NULL, '2026-03-20 23:40:59'),
(154, 123, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_VALID', 'Berkas Dinyatakan Valid – Menunggu Pembayaran', 'TERKIRIM', NULL, '2026-03-20 23:45:11'),
(155, 122, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_VALID', 'Berkas Valid', 'TERKIRIM', NULL, '2026-03-20 23:59:27'),
(156, 126, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-21 00:00:33'),
(157, 126, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_VALID', 'Berkas Valid', 'TERKIRIM', NULL, '2026-03-21 00:04:04'),
(158, 121, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_VALID', 'Berkas Valid', 'TERKIRIM', NULL, '2026-03-21 00:08:13'),
(159, 120, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_VALID', 'Berkas Valid', 'TERKIRIM', NULL, '2026-03-21 00:13:02'),
(160, 109, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_VALID', 'Berkas Valid', 'TERKIRIM', NULL, '2026-03-21 00:14:35'),
(161, 119, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_INVALID', 'Berkas Tidak Valid', 'TERKIRIM', NULL, '2026-03-21 00:22:13'),
(162, 120, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'GAGAL', 'tglMulaiFormatted is not defined', '2026-03-21 00:52:59'),
(163, 120, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'PEMBAYARAN_VALID', 'Konfirmasi Pembayaran & Pendaftaran Diterima', 'TERKIRIM', NULL, '2026-03-21 00:53:34'),
(164, 118, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_VALID', 'Berkas Valid', 'TERKIRIM', NULL, '2026-03-21 01:02:32'),
(165, 118, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-03-21 01:03:19'),
(166, 118, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'PEMBAYARAN_VALID', 'Konfirmasi Pembayaran & Pendaftaran Diterima', 'GAGAL', 'tglMulaiFormatted is not defined', '2026-03-21 01:09:08'),
(167, 120, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'PEMBAYARAN_VALID', 'Konfirmasi Pembayaran & Pendaftaran Diterima', 'GAGAL', 'tglMulaiFormatted is not defined', '2026-03-21 01:10:33'),
(168, 117, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_VALID', 'Berkas Valid', 'TERKIRIM', NULL, '2026-03-21 01:15:13'),
(169, 117, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-03-21 01:15:43'),
(170, 117, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'PEMBAYARAN_INVALID', 'Informasi Pembayaran Belum Valid', 'GAGAL', 'tglMulaiFormatted is not defined', '2026-03-21 01:15:56'),
(171, 115, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_VALID', 'Berkas Valid', 'TERKIRIM', NULL, '2026-03-21 01:37:53'),
(172, 115, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-03-21 01:40:00'),
(173, 115, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'PEMBAYARAN_INVALID', 'Informasi Pembayaran Belum Valid', 'TERKIRIM', NULL, '2026-03-21 01:40:14'),
(174, 114, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_VALID', 'Berkas Valid', 'TERKIRIM', NULL, '2026-03-21 01:48:59'),
(175, 114, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-03-21 01:50:00'),
(176, 114, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'PEMBAYARAN_INVALID', 'Informasi Pembayaran Belum Valid', 'GAGAL', 'token is not defined', '2026-03-21 01:50:26'),
(177, 108, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_VALID', 'Berkas Valid', 'TERKIRIM', NULL, '2026-03-25 10:34:43'),
(178, 108, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-03-25 10:35:46'),
(179, 108, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'PEMBAYARAN_INVALID', 'Informasi Pembayaran Belum Valid', 'GAGAL', 'token is not defined', '2026-03-25 10:36:00'),
(180, 107, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_VALID', 'Berkas Valid', 'TERKIRIM', NULL, '2026-03-25 10:42:58'),
(181, 103, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_VALID', 'Berkas Valid', 'TERKIRIM', NULL, '2026-03-25 10:43:29'),
(182, 103, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-03-25 10:44:01'),
(183, 103, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'PEMBAYARAN_INVALID', 'Informasi Pembayaran Belum Valid', 'GAGAL', 'token is not defined', '2026-03-25 10:44:14'),
(184, 102, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_VALID', 'Berkas Valid', 'TERKIRIM', NULL, '2026-03-25 11:56:41'),
(185, 102, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-03-25 11:57:08'),
(186, 92, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_VALID', 'Berkas Valid', 'TERKIRIM', NULL, '2026-03-25 12:00:18'),
(187, 92, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-03-25 12:00:43'),
(188, 92, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'PEMBAYARAN_INVALID', 'Informasi Pembayaran Belum Valid', 'TERKIRIM', NULL, '2026-03-25 12:01:01'),
(189, 92, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-03-25 12:02:33'),
(190, 92, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-03-25 12:23:39'),
(191, 102, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'PEMBAYARAN_PENDING', 'Konfirmasi Penerimaan Bukti Pembayaran', 'TERKIRIM', NULL, '2026-03-25 12:24:59'),
(192, 102, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'PEMBAYARAN_VALID', 'Konfirmasi Pembayaran & Pendaftaran Diterima', 'GAGAL', 'tglMulaiFormatted is not defined', '2026-03-25 12:25:18'),
(193, 103, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'PEMBAYARAN_VALID', 'Konfirmasi Pembayaran & Pendaftaran Diterima', 'GAGAL', 'tglMulaiFormatted is not defined', '2026-03-25 12:26:35'),
(194, 106, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_INVALID', 'Berkas Tidak Valid', 'TERKIRIM', NULL, '2026-03-25 12:44:58'),
(195, 85, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_INVALID', 'Berkas Tidak Valid', 'TERKIRIM', NULL, '2026-03-25 12:49:54'),
(196, 127, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-25 13:16:36'),
(197, 127, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_INVALID', 'Berkas Tidak Valid', 'TERKIRIM', NULL, '2026-03-25 13:16:53'),
(198, 127, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-25 13:30:20'),
(199, 127, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_INVALID', 'Berkas Tidak Valid', 'TERKIRIM', NULL, '2026-03-25 13:33:48'),
(200, 127, 'saifaniazmita@gmail.com', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', 'TERKIRIM', NULL, '2026-03-25 13:34:57');

-- --------------------------------------------------------

--
-- Table structure for table `fasilitator_tb`
--

CREATE TABLE `fasilitator_tb` (
  `id_fasilitator` int(11) NOT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `nama` varchar(255) DEFAULT NULL,
  `keterangan` varchar(50) DEFAULT NULL,
  `created_at` datetime DEFAULT NULL,
  `updated_at` datetime DEFAULT NULL,
  `author` varchar(255) DEFAULT NULL,
  `status` char(1) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `fasilitator_tb`
--

INSERT INTO `fasilitator_tb` (`id_fasilitator`, `foto`, `nama`, `keterangan`, `created_at`, `updated_at`, `author`, `status`) VALUES
(64, '1766470925431-179125229.jpg', 'ARINY PURNOMOWATI, S.Kep.Ns', 'Fasilitator dan Instruktur PPI', '2025-12-23 13:22:05', '2025-12-23 13:22:05', 'admin', '1'),
(65, '1766471018787-107512481.png', 'Dr. ARIADNE TIARA H, Sp.A(K)', 'Fasilitator dan Instruktur Pelatihan Gadar Mat Neo', '2025-12-23 13:23:38', '2025-12-23 13:23:38', 'admin', '1'),
(66, '1766471139844-550466148.jpg', 'Dr. HERMAN SUMAWAN, Sp.OG(K)', 'Fasilitator dan Instruktur Pelatihan Gadar Mat Neo', '2025-12-23 13:25:39', '2025-12-23 13:26:40', 'admin', '1'),
(67, '1766471184070-70886197.jpg', 'Dr. MARTA ISYANA DEWI, Sp.OG', 'Fasilitator dan Instruktur Pelatihan Gadar Mat Neo', '2025-12-23 13:26:24', '2025-12-23 13:26:24', 'admin', '1'),
(68, '1766471242782-557835825.jpg', 'PUJI LESTARI, S.Kep.Ns', 'Instruktur Pelatihan Gadar Mat Neo', '2025-12-23 13:27:22', '2025-12-23 13:27:22', 'admin', '1'),
(70, '1766471317240-365206872.jpg', 'SITI NUR KHASANAH, SST', 'Fasilitator dan Instruktur Pelatihan Gadar Mat Neo', '2025-12-23 13:28:37', '2025-12-23 13:28:37', 'admin', '1'),
(71, '1766471360141-755290630.jpg', 'PUJI LESTARI, S.Kep.Ns', 'Instruktur Pelatihan Gadar Mat Neo', '2025-12-23 13:29:20', '2025-12-23 13:29:20', 'admin', '1'),
(72, '1766471406973-128715126.jpg', 'SUPRAPTI, SST', 'Fasilitator dan Instruktur Pelatihan Gadar Mat Neo', '2025-12-23 13:30:06', '2025-12-23 13:30:06', 'admin', '1'),
(73, '1766471449430-991635574.png', 'dr. Untung GUNARTO, Sp.S, MM', 'Fasilitator dan Instruktur', '2025-12-23 13:30:49', '2025-12-23 13:30:49', 'admin', '1'),
(79, '1771831299570-753525785.jpg', 'Arikh Ratna Purwadi, S.Kep.Ns., MH', 'Fasilitator dan Instruktur', '2026-02-23 14:21:39', '2026-02-23 14:21:54', 'admin', '1');

-- --------------------------------------------------------

--
-- Table structure for table `histori_akreditasi`
--

CREATE TABLE `histori_akreditasi` (
  `id` int(11) NOT NULL,
  `institusi_id` int(11) NOT NULL,
  `periode` varchar(50) DEFAULT NULL,
  `keterangan` text NOT NULL,
  `nomor_sk` varchar(100) DEFAULT NULL,
  `link_sk` text DEFAULT NULL,
  `kategori_akreditasi` varchar(10) DEFAULT NULL,
  `masa_berlaku` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `histori_akreditasi`
--

INSERT INTO `histori_akreditasi` (`id`, `institusi_id`, `periode`, `keterangan`, `nomor_sk`, `link_sk`, `kategori_akreditasi`, `masa_berlaku`) VALUES
(1, 1, '2018–2019', 'Berawal dari pengampuan oleh BAPELKES Provinsi Jawa Tengah dan Divisi Diklat RSMS', 'HK.02.02/I/1826/2020', 'http://asik.rsmargono.go.id:7222/pelatihan_diklat/assets/download/SK%20RSUD%20PROF%20DR.MARGONO%20SOEKARJO%20(UTAMA%20FK%20UNIV.JENDERAL%20SOEDIRMAN).pdf', 'A', '5 Tahun');

-- --------------------------------------------------------

--
-- Table structure for table `institusi_kerjasama_tb`
--

CREATE TABLE `institusi_kerjasama_tb` (
  `id_institusi` int(11) NOT NULL,
  `nama` varchar(255) NOT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `link_terkait` varchar(500) DEFAULT NULL,
  `status` char(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `institusi_kerjasama_tb`
--

INSERT INTO `institusi_kerjasama_tb` (`id_institusi`, `nama`, `foto`, `link_terkait`, `status`) VALUES
(25, 'Universitas Jendral Soedirman', '1766471741922-37080506.png', 'https://unsoed.ac.id/', '1'),
(26, 'Universitas Harapan Bangsa', '1766471767766-365417082.png', 'https://uhb.ac.id/id/', '1'),
(27, 'Universitas Muhammadiyah Gombong', '1766471783255-49446505.png', 'https://unimugo.ac.id/', '1'),
(28, 'Universitas Pembangunan Nasional \"Veteran\" Jakarta', '1766471829853-829198423.png', 'https://www.upnvj.ac.id/id.html', '1'),
(29, 'Bapelkes Jateng', '1766471857685-616993340.png', 'https://bapelkesjateng.id/', '1'),
(30, 'Universitas Muhammadiyah Purwokerto', '1766471884533-725993626.png', 'https://ump.ac.id/', '1'),
(31, 'Dinas Kesehatan Pemerintah Kabupaten Banyumas', '1766471911808-37313006.png', 'http://dinkes.banyumaskab.go.id/', '1');

-- --------------------------------------------------------

--
-- Table structure for table `institusi_pelatihan`
--

CREATE TABLE `institusi_pelatihan` (
  `id` int(11) NOT NULL,
  `nama_institusi` varchar(255) NOT NULL,
  `deskripsi` text NOT NULL,
  `kategori_rs` varchar(100) DEFAULT NULL,
  `tahun_berdiri` year(4) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `institusi_pelatihan`
--

INSERT INTO `institusi_pelatihan` (`id`, `nama_institusi`, `deskripsi`, `kategori_rs`, `tahun_berdiri`, `created_at`, `updated_at`) VALUES
(1, 'RSUD Prof. Dr. Margono Soekarjo Purwokerto', 'RSUD Prof. Dr. Margono Soekarjo Purwokerto merupakan RS rujukan pelayanan kesehatan kelas A, RS pendidikan dan institusi penyelenggara pelatihan bidang kesehatan terakreditasi A sejak tahun 2023', 'RS Kelas A', '1990', '2026-01-20 04:13:35', '2026-02-11 14:40:45');

-- --------------------------------------------------------

--
-- Table structure for table `jabatan`
--

CREATE TABLE `jabatan` (
  `id_jabatan` int(11) NOT NULL,
  `nama_jabatan` varchar(100) NOT NULL,
  `level_jabatan` int(11) NOT NULL,
  `parent_id` int(11) DEFAULT NULL,
  `urutan` int(11) DEFAULT 0,
  `keterangan` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `jabatan`
--

INSERT INTO `jabatan` (`id_jabatan`, `nama_jabatan`, `level_jabatan`, `parent_id`, `urutan`, `keterangan`, `created_at`) VALUES
(1, 'Kabid Pendidikan dan Penelitian', 1, NULL, 1, '', '2026-02-09 15:58:16'),
(2, 'Plt. Kasi Pelatihan', 2, 1, 2, 'Membidangi pendidikan', '2026-02-09 16:08:16'),
(3, 'Kasi Pendidikan', 2, 1, 2, 'Membidangi pelatihan', '2026-02-09 16:08:16'),
(8, 'Administrasi Pelatihan Logistik', 3, 2, 3, '', '2026-02-24 17:53:04'),
(10, 'Administrasi Pelatihan', 3, 2, 3, '', '2026-02-24 17:57:15'),
(12, 'Administrasi Pendidikan', 3, 3, 3, '', '2026-02-24 17:58:14'),
(13, 'Administrasi Pendidikan', 3, 3, 3, '', '2026-02-24 17:58:55'),
(14, 'Administrasi Penelitian', 3, 3, 3, '', '2026-02-24 17:59:21'),
(21, 'Administrasi Umum', 3, 3, 3, NULL, '2026-02-26 17:38:25'),
(24, 'Administrasi Pelatihan', 3, 2, 3, NULL, '2026-03-13 04:15:42'),
(25, 'Administrasi Pelatihan', 3, 2, 3, NULL, '2026-03-13 04:36:40');

-- --------------------------------------------------------

--
-- Table structure for table `kalender_pelatihan`
--

CREATE TABLE `kalender_pelatihan` (
  `id_kalender` int(11) NOT NULL,
  `tahun` year(4) NOT NULL,
  `judul` varchar(200) NOT NULL,
  `file_kalender` varchar(255) NOT NULL,
  `tipe_file` enum('pdf','image','excel','lainnya') NOT NULL DEFAULT 'pdf',
  `status` enum('aktif','nonaktif') NOT NULL DEFAULT 'aktif',
  `uploaded_by` int(11) NOT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `updated_at` timestamp NULL DEFAULT NULL ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kalender_pelatihan`
--

INSERT INTO `kalender_pelatihan` (`id_kalender`, `tahun`, `judul`, `file_kalender`, `tipe_file`, `status`, `uploaded_by`, `uploaded_at`, `updated_at`) VALUES
(7, '2026', 'Kalender Pelatihan 2026 RSUD Prof. Dr. Margono Soekarjo Provinsi Jawa Tengah', 'kalender-2026.pdf', 'pdf', 'aktif', 17, '2026-01-31 10:41:40', '2026-03-12 17:47:51'),
(12, '2019', 'Jadwal Pelatihan 2025', 'kalender-2019.jpg', 'image', 'nonaktif', 17, '2026-03-12 17:48:20', '2026-03-12 17:49:04');

-- --------------------------------------------------------

--
-- Table structure for table `kritik_saran_tb`
--

CREATE TABLE `kritik_saran_tb` (
  `id_kritik` int(11) NOT NULL,
  `nama_lengkap` varchar(150) DEFAULT NULL,
  `is_anonim` enum('Y','N') DEFAULT 'N',
  `no_hp` varchar(20) NOT NULL,
  `kritik` text DEFAULT NULL,
  `saran` text DEFAULT NULL,
  `status` enum('AKTIF','NONAKTIF') DEFAULT 'NONAKTIF',
  `created_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `kritik_saran_tb`
--

INSERT INTO `kritik_saran_tb` (`id_kritik`, `nama_lengkap`, `is_anonim`, `no_hp`, `kritik`, `saran`, `status`, `created_at`) VALUES
(75, NULL, 'Y', '087878787878', 'Materi pelatihan\n\nMateri yang disampaikan sudah cukup baik, namun beberapa bagian masih terlalu teoritis sehingga kurang memberikan gambaran penerapan di lapangan.\n\nDurasi pelatihan\n\nWaktu pelaksanaan pelatihan terasa cukup singkat sehingga beberapa materi belum dapat dipahami secara mendalam oleh peserta.\n\nMetode penyampaian\n\nMetode pembelajaran masih didominasi oleh ceramah, sehingga interaksi antara peserta dan fasilitator masih terbatas.\n\nFasilitas pelatihan\n\nFasilitas ruangan sudah memadai, namun kualitas audio dan proyektor perlu ditingkatkan agar materi dapat terlihat dan terdengar lebih jelas.\n\nManajemen waktu\n\nJadwal pelatihan terkadang mengalami keterlambatan sehingga beberapa sesi harus dipersingkat', 'Pengembangan metode pembelajaran\n\nSebaiknya pelatihan dilengkapi dengan studi kasus, simulasi, atau praktik langsung agar peserta lebih memahami penerapan materi dalam pelayanan rumah sakit.\n\nPenambahan waktu diskusi\n\nDisarankan untuk menyediakan waktu diskusi yang lebih banyak agar peserta dapat bertanya dan berbagi pengalaman terkait praktik di unit kerja masing-masing.\n\nPenyempurnaan materi\n\nMateri pelatihan dapat diperbarui secara berkala sesuai dengan perkembangan ilmu pengetahuan dan standar pelayanan kesehatan terbaru.\n\nPeningkatan fasilitas\n\nPerlu peningkatan kualitas fasilitas seperti sistem suara, proyektor, serta kenyamanan ruang pelatihan agar proses belajar lebih optimal.\n\nEvaluasi pelatihan\n\nDisarankan untuk melakukan evaluasi pasca pelatihan guna mengetahui sejauh mana materi yang diberikan dapat diterapkan dalam pekerjaan sehari-hari.', 'NONAKTIF', '2026-03-11 02:49:35'),
(80, NULL, 'Y', '087878787878', 'Pelatihan sangat bermanfaat dan materinya relevan dengan pekerjaan di rumah sakit. Ke depan diharapkan dapat ditambahkan sesi praktik atau simulasi agar peserta lebih memahami penerapan materi secara langsung.', '', 'NONAKTIF', '2026-03-11 03:23:05'),
(81, 'Mita', 'N', '08783029136', 'Pelatihannya mantap, serasa di hotel mewah, hanya saja jumlah kamar mandinya masih kurang, dan tempat sholat yang belum terpisah antara perempuan dan laki laki, semoga kedepannya menjadi pusat pelatihan terbaik di jawa tengah', '', 'AKTIF', '2026-03-11 03:25:49'),
(82, NULL, 'Y', '08783029136', 'Pelatihannya terjangkau banget harganya.. murah tapi gak murahan.. Semoga pelatihannya makin banyak, dan harganya jangan mahal mahal..', '', 'AKTIF', '2026-03-11 03:26:30'),
(83, 'Fulan', 'N', '087830736311', 'Pelatihannya menyenangkan, ga membosankan fasilitator asik diajak diskusi..', '', 'AKTIF', '2026-03-11 03:27:00');

-- --------------------------------------------------------

--
-- Table structure for table `log_admin`
--

CREATE TABLE `log_admin` (
  `id_log` int(11) NOT NULL,
  `id_user` int(11) DEFAULT NULL,
  `email` varchar(150) NOT NULL,
  `nama_lengkap` varchar(150) NOT NULL,
  `ip_address` varchar(45) DEFAULT NULL,
  `user_agent` text DEFAULT NULL,
  `aktivitas` enum('LOGIN','LOGIN_BERHASIL','LOGIN_GAGAL','LOGIN_DITOLAK','LOGIN_ERROR','LOGOUT','AKSI') NOT NULL,
  `keterangan` text DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `log_admin`
--

INSERT INTO `log_admin` (`id_log`, `id_user`, `email`, `nama_lengkap`, `ip_address`, `user_agent`, `aktivitas`, `keterangan`, `created_at`) VALUES
(1, 15, 'admin@gmail.com', 'Administrator', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-01-11 13:47:00'),
(2, 15, 'admin@gmail.com', 'Administrator', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-01-11 13:47:34'),
(6, 15, 'admin@gmail.com', 'Administrator', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-01-11 17:09:20'),
(7, 15, 'admin@gmail.com', 'Administrator', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 50 (Maemunah Sarif)', '2026-01-11 17:09:40'),
(8, 15, 'admin@gmail.com', 'Administrator', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'AKSI', 'Validasi pembayaran VALID untuk ID pendaftaran 50 (Maemunah Sarif)', '2026-01-11 17:12:11'),
(9, 15, 'admin@gmail.com', 'Administrator', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'AKSI', 'Validasi pembayaran VALID untuk ID pendaftaran 49 (Saifaniiii)', '2026-01-11 17:16:22'),
(10, 15, 'admin@gmail.com', 'Administrator', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-01-13 17:10:21'),
(11, 15, 'admin@gmail.com', 'Administrator', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-01-14 05:40:06'),
(12, 15, 'admin@gmail.com', 'Administrator', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-01-14 08:00:38'),
(13, 15, 'admin@gmail.com', 'Administrator', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'AKSI', 'Validasi pembayaran VALID untuk ID pendaftaran 46 (Azmita)', '2026-01-14 10:53:27'),
(14, 15, 'admin@gmail.com', 'Administrator', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'AKSI', 'Validasi pembayaran VALID untuk ID pendaftaran 47 (Maemunah Sarif)', '2026-01-14 11:00:09'),
(15, 15, 'admin@gmail.com', 'Administrator', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'AKSI', 'Validasi pembayaran VALID untuk ID pendaftaran 48 (Sultanul Arimaza)', '2026-01-14 11:05:32'),
(16, 15, 'admin@gmail.com', 'Administrator', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'AKSI', 'Validasi pembayaran VALID untuk ID pendaftaran 44 (Saifani A)', '2026-01-14 11:13:04'),
(17, 15, 'admin@gmail.com', 'Administrator', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 51 (Saifani Aweawe)', '2026-01-14 11:47:23'),
(18, 15, 'admin@gmail.com', 'Administrator', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 56 (Azmitassdadada)', '2026-01-14 12:00:08'),
(19, 15, 'admin@gmail.com', 'Administrator', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 53 (Maemunahhhhh)', '2026-01-14 12:23:20'),
(20, 15, 'admin@gmail.com', 'Administrator', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas INVALID untuk ID 54 (Mamamiamaia)', '2026-01-14 12:23:47'),
(21, 15, 'admin@gmail.com', 'Administrator', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'AKSI', 'Validasi pembayaran INVALID untuk ID pendaftaran 51 (Saifani Aweawe)', '2026-01-14 12:24:47'),
(22, 15, 'admin@gmail.com', 'Administrator', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-01-16 04:47:53'),
(23, 15, 'admin@gmail.com', 'Administrator', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-01-16 05:31:31'),
(24, 15, 'admin@gmail.com', 'Administrator', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-01-16 05:44:24'),
(25, 15, 'admin@gmail.com', 'Administrator', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas INVALID untuk ID 55 (Azmita)', '2026-01-16 08:00:08'),
(26, 15, 'admin@gmail.com', 'Administrator', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-01-19 03:23:20'),
(27, 15, 'admin@gmail.com', 'Administrator', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-01-20 04:08:32'),
(28, 15, 'admin@gmail.com', 'Administrator', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-01-20 06:37:49'),
(29, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-01-20 06:43:52'),
(30, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-01-21 06:28:37'),
(31, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'AKSI', 'Validasi pembayaran VALID untuk ID pendaftaran 56 (Azmitassdadada)', '2026-01-21 06:29:23'),
(32, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'AKSI', 'Validasi pembayaran VALID untuk ID pendaftaran 52 (Maemunah Sarif)', '2026-01-21 06:51:13'),
(33, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 57 (Azmitas)', '2026-01-21 07:40:39'),
(34, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'AKSI', 'Validasi pembayaran VALID untuk ID pendaftaran 57 (Azmitas)', '2026-01-21 07:41:40'),
(35, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'AKSI', 'Validasi pembayaran VALID untuk ID pendaftaran 53 (Maemunahhhhh)', '2026-01-21 07:43:46'),
(36, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 58 (Azmita)', '2026-01-21 07:54:24'),
(37, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'AKSI', 'Validasi pembayaran VALID untuk ID pendaftaran 58 (Azmita)', '2026-01-21 07:55:37'),
(38, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 59 (Azmita)', '2026-01-21 08:03:07'),
(39, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'AKSI', 'Validasi pembayaran VALID untuk ID pendaftaran 59 (Azmita)', '2026-01-21 08:04:08'),
(40, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 60 (Azmita)', '2026-01-21 08:08:00'),
(41, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'AKSI', 'Validasi pembayaran VALID untuk ID pendaftaran 60 (Azmita)', '2026-01-21 08:08:50'),
(42, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 61 (Azmita)', '2026-01-21 08:10:57'),
(43, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'AKSI', 'Validasi pembayaran VALID untuk ID pendaftaran 61 (Azmita)', '2026-01-21 08:12:23'),
(44, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'AKSI', 'Validasi pembayaran VALID untuk ID pendaftaran 60 (Azmita)', '2026-01-21 09:54:05'),
(45, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 55 (Azmita)', '2026-01-21 10:02:51'),
(46, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-01-21 12:31:15'),
(47, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 62 (Saifani )', '2026-01-21 12:31:26'),
(48, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'AKSI', 'Validasi pembayaran VALID untuk ID pendaftaran 62 (Saifani )', '2026-01-21 12:42:45'),
(49, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-01-27 13:42:12'),
(50, 15, 'admin@gmail.com', 'Azmita Saifani A', '::ffff:127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-01-28 05:13:34'),
(51, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-01-29 10:47:47'),
(52, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-01-29 13:37:18'),
(53, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-01-29 15:45:05'),
(54, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '', 'Menambahkan pelatihan: percobaan', '2026-01-29 16:37:59'),
(55, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '', 'Update pelatihan ID 25', '2026-01-29 16:38:15'),
(56, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '', 'Update pelatihan ID 25', '2026-01-29 16:44:19'),
(57, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '', 'Update pelatihan ID 26', '2026-01-29 16:44:31'),
(58, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '', 'Update pelatihan ID 25', '2026-01-29 16:44:42'),
(59, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '', 'Update pelatihan ID 23', '2026-01-29 16:48:27'),
(60, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '', 'Update pelatihan ID 23', '2026-01-29 16:49:02'),
(61, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '', 'Update pelatihan ID 23', '2026-01-29 16:49:21'),
(62, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '', 'Update pelatihan ID 22', '2026-01-29 16:50:39'),
(63, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '', 'Update pelatihan ID 24', '2026-01-29 16:54:33'),
(64, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '', 'Update pelatihan ID 21', '2026-01-29 16:56:16'),
(65, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '', 'Menambahkan pelatihan [ID:27] percobaan1111', '2026-01-29 17:04:56'),
(66, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', '', 'Update pelatihan ID 27', '2026-01-29 17:05:23'),
(67, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'AKSI', 'Menambahkan pelatihan [ID:28] percobaan2222', '2026-01-29 17:09:45'),
(68, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'AKSI', 'Menambahkan pelatihan [ID:29] percobaan3333', '2026-01-29 17:24:23'),
(69, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'AKSI', 'Update pelatihan ID 27', '2026-01-29 17:48:04'),
(70, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-01-29 17:52:36'),
(71, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-01-29 17:54:29'),
(72, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-01-29 18:08:52'),
(73, 1, 'test@gmail.com', 'TEST ADMIN', '127.0.0.1', 'TEST-UA', 'LOGIN', 'TEST MANUAL', '2026-01-29 18:10:45'),
(74, 1, 'test@gmail.com', 'TEST ADMIN', '127.0.0.1', 'TEST-UA', 'LOGIN', 'TEST MANUAL', '2026-01-29 18:10:59'),
(75, 999, 'x@x.com', 'X', NULL, NULL, 'LOGIN', NULL, '2026-01-29 18:14:55'),
(76, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-01-29 18:19:21'),
(77, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'AKSI', 'Update pelatihan ID 28', '2026-01-29 18:21:01'),
(78, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'AKSI', 'Hapus pelatihan ID 27', '2026-01-29 18:24:25'),
(79, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/143.0.0.0 Safari/537.36', 'AKSI', 'Hapus pelatihan ID 26', '2026-01-29 18:26:17'),
(80, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-01-31 08:51:28'),
(81, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'PostmanRuntime/7.51.1', 'AKSI', 'Menambahkan kalender pelatihan tahun 2026', '2026-01-31 10:17:36'),
(82, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'PostmanRuntime/7.51.1', 'AKSI', 'Menambahkan kalender pelatihan tahun 2026', '2026-01-31 10:24:49'),
(83, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'PostmanRuntime/7.51.1', 'AKSI', 'Menambahkan kalender pelatihan tahun 2026', '2026-01-31 10:33:00'),
(84, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'PostmanRuntime/7.51.1', 'AKSI', 'Menambahkan kalender pelatihan tahun 2026', '2026-01-31 10:41:40'),
(85, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-01-31 11:42:47'),
(86, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-01 12:01:38'),
(87, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Update pelatihan ID 17', '2026-02-01 13:16:08'),
(88, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Update pelatihan ID 17', '2026-02-01 13:16:46'),
(89, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '', 'Password salah', '2026-02-01 14:47:11'),
(90, NULL, 'admin555@gmail.com', 'UNKNOWN', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '', 'Email tidak ditemukan atau nonaktif', '2026-02-01 15:00:52'),
(91, NULL, 'admin555@gmail.com', 'UNKNOWN', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '', 'Email tidak ditemukan atau nonaktif', '2026-02-01 15:03:31'),
(92, 15, 'admin@gmail.com', 'Azmita Saifani A', '::1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '', 'Admin login berhasil', '2026-02-01 15:03:51'),
(94, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-01 15:15:07'),
(95, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-01 15:24:15'),
(96, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-01 15:26:18'),
(97, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-01 15:33:13'),
(98, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-01 15:36:23'),
(99, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-01 15:45:39'),
(100, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-01 15:50:23'),
(101, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-01 15:55:53'),
(102, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-01 16:02:04'),
(103, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-01 16:07:22'),
(104, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGOUT', 'Admin logout', '2026-02-01 16:07:28'),
(105, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-01 16:08:27'),
(106, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-01 16:13:30'),
(107, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGOUT', 'Admin logout', '2026-02-01 16:13:41'),
(108, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-01 16:14:58'),
(109, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Update pelatihan ID 29', '2026-02-01 16:15:09'),
(110, NULL, '-', 'UNKNOWN', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Edit histori akreditasi ID 1', '2026-02-01 17:14:01'),
(111, NULL, '-', 'UNKNOWN', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Edit histori akreditasi ID 1', '2026-02-01 17:14:08'),
(112, NULL, '-', 'UNKNOWN', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Edit histori akreditasi ID 1', '2026-02-01 17:16:01'),
(113, NULL, '-', 'UNKNOWN', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Edit histori akreditasi ID 1', '2026-02-01 17:16:11'),
(114, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-02 02:10:55'),
(115, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGOUT', 'Admin logout', '2026-02-02 02:28:53'),
(116, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-02 03:09:44'),
(117, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-04 13:59:57'),
(118, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Update kalender pelatihan tahun 2026', '2026-02-04 17:45:30'),
(119, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Update kalender pelatihan tahun 2026', '2026-02-04 17:46:18'),
(120, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-06 04:27:35'),
(121, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Hapus pelatihan ID 29', '2026-02-06 05:59:21'),
(122, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Update pelatihan ID 18', '2026-02-06 06:07:52'),
(123, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Update pelatihan ID 19', '2026-02-06 06:08:02'),
(124, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Update pelatihan ID 23', '2026-02-06 06:08:21'),
(125, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-06 08:30:09'),
(126, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-06 10:02:10'),
(127, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-06 10:49:59'),
(128, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-06 10:54:38'),
(129, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-06 11:00:22'),
(130, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-06 13:30:37'),
(131, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-06 13:52:01'),
(132, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-06 13:52:30'),
(133, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-06 13:54:08'),
(134, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-06 13:57:48'),
(135, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-06 13:58:06'),
(136, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-06 14:25:58'),
(137, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-06 14:26:19'),
(138, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-06 14:29:48'),
(139, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-06 14:56:50'),
(140, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-09 13:23:46'),
(141, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Tambah jabatan Kabid Pendidikan & Penelitian', '2026-02-09 15:58:16'),
(142, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Update jabatan ID 1', '2026-02-09 15:58:33'),
(143, NULL, '-', 'SYSTEM', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Tambah anggota Arikh Ratna Purwadi, S.Kep.Ns., MH', '2026-02-09 16:20:36'),
(144, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Update jabatan ID 1', '2026-02-09 16:22:38'),
(145, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Update jabatan ID 1', '2026-02-09 16:22:44'),
(146, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-11 10:19:03'),
(147, NULL, '-', 'UNKNOWN', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Edit institusi pelatihan ID 1', '2026-02-11 10:47:11'),
(148, NULL, '-', 'UNKNOWN', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Edit institusi pelatihan ID 1', '2026-02-11 10:47:15'),
(149, NULL, '-', 'UNKNOWN', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Edit tim kerja ID 5', '2026-02-11 14:24:00'),
(150, NULL, '-', 'UNKNOWN', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Edit tim kerja ID 5', '2026-02-11 14:24:07'),
(151, NULL, '-', 'UNKNOWN', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Delete tim kerja ID 5', '2026-02-11 14:24:13'),
(152, NULL, '-', 'UNKNOWN', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Tambah tim kerja ID 8', '2026-02-11 14:36:45'),
(153, NULL, '-', 'UNKNOWN', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Tambah institusi pelatihan ID 2', '2026-02-11 14:38:33'),
(154, NULL, '-', 'UNKNOWN', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Delete institusi pelatihan ID 2', '2026-02-11 14:39:04'),
(155, NULL, '-', 'UNKNOWN', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Edit institusi pelatihan ID 1', '2026-02-11 14:40:23'),
(156, NULL, '-', 'UNKNOWN', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Edit institusi pelatihan ID 1', '2026-02-11 14:40:35'),
(157, NULL, '-', 'UNKNOWN', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Edit institusi pelatihan ID 1', '2026-02-11 14:40:41'),
(158, NULL, '-', 'UNKNOWN', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Edit institusi pelatihan ID 1', '2026-02-11 14:40:45'),
(159, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-11 14:41:11'),
(160, NULL, '-', 'UNKNOWN', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Update sertifikat ID 2', '2026-02-11 16:04:31'),
(161, NULL, '-', 'UNKNOWN', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Update sertifikat ID 2', '2026-02-11 16:04:36'),
(162, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-11 16:44:38'),
(163, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-13 08:20:50'),
(164, NULL, '-', 'UNKNOWN', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Update sertifikat ID 2 (Judul: Sertifikat Rumah Sakit Pendidikan Utama RSUD Prof. Dr. Margono Soekarjo)', '2026-02-13 08:49:44'),
(165, NULL, '-', 'UNKNOWN', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Update sertifikat ID 2 (Judul: Sertifikat Rumah Sakit Pendidikan Utama RSUD Prof. Dr. Margono Soekarjo sdadasda)', '2026-02-13 08:49:50'),
(166, NULL, '-', 'UNKNOWN', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Update sertifikat ID 2 (Judul: Sertifikat Rumah Sakit Pendidikan Utama RSUD Prof. Dr. Margono Soekarjo)', '2026-02-13 08:49:58'),
(167, NULL, '-', 'UNKNOWN', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Update sertifikat ID 2 (Judul: Sertifikat Rumah Sakit Pendidikan Utama RSUD Prof. Dr. Margono Soekarjo sadsadas)', '2026-02-13 08:52:14'),
(168, NULL, '-', 'UNKNOWN', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Update sertifikat ID 2 (Judul: Sertifikat Rumah Sakit Pendidikan Utama RSUD Prof. Dr. Margono Soekarjo)', '2026-02-13 08:52:26'),
(169, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-13 09:38:38'),
(170, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-13 10:30:05'),
(171, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-13 10:39:35'),
(172, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-13 10:41:57'),
(173, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-13 10:45:54'),
(174, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-13 10:48:42'),
(175, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-13 10:52:17'),
(176, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-13 10:59:50'),
(177, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-13 11:01:37'),
(178, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-13 11:08:29'),
(179, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-13 11:40:20'),
(180, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-13 12:02:51'),
(181, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-13 12:52:03'),
(182, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '', 'Update status admin ID 15 menjadi 0', '2026-02-13 12:52:16'),
(183, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '', 'Update status admin ID 15 menjadi 1', '2026-02-13 12:52:17'),
(184, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '', 'Update status admin ID 15 menjadi 0', '2026-02-13 12:53:25'),
(185, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '', 'Update status admin ID 15 menjadi 1', '2026-02-13 12:53:31'),
(186, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '', 'Menambah admin baru (admin1@gmail.com)', '2026-02-13 12:54:26'),
(187, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGOUT', 'Admin logout', '2026-02-13 12:54:49'),
(188, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN_DITOLAK', 'Bukan akun admin', '2026-02-13 12:54:57'),
(189, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-13 12:55:21'),
(190, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-13 13:01:08'),
(191, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-13 13:01:20'),
(192, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-13 13:05:25'),
(193, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-13 13:05:38'),
(194, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGOUT', 'Admin logout', '2026-02-13 13:05:46'),
(195, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN_GAGAL', 'Password salah', '2026-02-13 13:18:22'),
(196, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-13 13:18:52'),
(197, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-13 13:24:22'),
(198, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN_GAGAL', 'Password salah', '2026-02-13 13:30:53'),
(199, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-13 13:30:56'),
(200, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '', 'Update status admin ID 15 menjadi 0', '2026-02-13 13:31:47'),
(201, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '', 'Update status admin ID 15 menjadi 1', '2026-02-13 13:31:51'),
(202, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 09:26:34'),
(203, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 09:34:46'),
(204, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '', 'Update status admin ID 17 menjadi 0', '2026-02-14 09:35:09'),
(205, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', '', 'Update status admin ID 17 menjadi 1', '2026-02-14 09:35:11'),
(206, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 09:39:50'),
(207, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Update status admin ID 17 menjadi 0', '2026-02-14 09:40:09'),
(208, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Update status admin ID 17 menjadi 1', '2026-02-14 09:40:11'),
(209, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Update status admin ID 17 menjadi 0', '2026-02-14 09:40:36'),
(210, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 09:43:05'),
(211, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Update status admin ID 17 menjadi 1', '2026-02-14 09:43:28'),
(212, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 09:44:19'),
(213, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Update status admin ID 17 menjadi 0', '2026-02-14 09:44:29'),
(214, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Update status admin ID 17 menjadi 1', '2026-02-14 09:44:33'),
(215, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 09:53:57'),
(216, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Update status admin ID 17 menjadi 0', '2026-02-14 09:54:09'),
(217, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Update status admin ID 17 menjadi 1', '2026-02-14 09:54:15'),
(218, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 09:59:33'),
(219, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 10:00:31');
INSERT INTO `log_admin` (`id_log`, `id_user`, `email`, `nama_lengkap`, `ip_address`, `user_agent`, `aktivitas`, `keterangan`, `created_at`) VALUES
(220, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 10:02:39'),
(221, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Update status admin ID 17 menjadi 0', '2026-02-14 10:02:50'),
(222, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Update status admin ID 17 menjadi 1', '2026-02-14 10:03:01'),
(223, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Update status admin ID 17 menjadi 0', '2026-02-14 10:03:05'),
(224, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGOUT', 'Admin logout', '2026-02-14 10:03:42'),
(225, NULL, 'admin1@gmail.com', 'UNKNOWN', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN_GAGAL', 'Email tidak ditemukan atau nonaktif', '2026-02-14 10:03:57'),
(226, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 10:04:06'),
(227, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Menambah admin baru (aaa@gmail.com)', '2026-02-14 10:07:52'),
(228, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGOUT', 'Admin logout', '2026-02-14 10:08:08'),
(229, 18, 'aaa@gmail.com', 'Azmita', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 10:08:12'),
(230, 18, 'aaa@gmail.com', 'Azmita', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGOUT', 'Admin logout', '2026-02-14 10:08:24'),
(231, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 10:08:29'),
(232, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 10:59:06'),
(233, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 11:18:57'),
(234, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 11:58:38'),
(235, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 12:38:17'),
(236, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 12:45:49'),
(237, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 12:49:50'),
(238, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 14:11:37'),
(239, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 14:20:22'),
(240, NULL, 'admin1@gmail.com', 'UNKNOWN', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN_GAGAL', 'Email tidak ditemukan atau nonaktif', '2026-02-14 14:22:28'),
(241, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 14:22:35'),
(242, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 14:24:31'),
(243, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Update status admin ID 18 menjadi 0', '2026-02-14 14:25:31'),
(244, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Update status admin ID 17 menjadi 1', '2026-02-14 14:25:34'),
(245, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 14:25:56'),
(246, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 14:27:50'),
(247, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 14:44:46'),
(248, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN_GAGAL', 'Password salah', '2026-02-14 14:50:19'),
(249, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 14:50:25'),
(250, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 14:53:38'),
(251, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 14:59:15'),
(252, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 15:33:59'),
(253, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 16:01:07'),
(254, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGOUT', 'Admin [ID:15] Azmita Saifani A melakukan logout', '2026-02-14 16:01:14'),
(255, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 16:01:22'),
(256, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGOUT', 'Admin [ID:15] Azmita Saifani A melakukan logout', '2026-02-14 16:02:06'),
(257, NULL, 'admin2@gmail.com', 'UNKNOWN', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN_GAGAL', 'Email tidak ditemukan atau nonaktif', '2026-02-14 16:02:14'),
(258, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN_GAGAL', 'Password salah', '2026-02-14 16:02:23'),
(259, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 16:02:29'),
(260, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 16:21:04'),
(261, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 16:26:02'),
(262, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN_GAGAL', 'Password salah', '2026-02-14 16:40:20'),
(263, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 16:40:25'),
(264, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 16:43:27'),
(265, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'UPDATE FASILITATOR [ID:74] dari \"undefined\" menjadi \"Arikh Ratna Purwadi, S.Kep.Ns., MH\"', '2026-02-14 16:43:37'),
(266, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'UPDATE FASILITATOR [ID:74] dari \"undefined\" menjadi \"Arikh Ratna Purwadi, S.Kep.Ns., MH\"', '2026-02-14 16:43:44'),
(267, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'CREATE FASILITATOR [ID:75] Ariny Purnomowati, S.Kep.Ns', '2026-02-14 16:44:00'),
(268, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 16:45:53'),
(269, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'CREATE FASILITATOR [ID:76] Ariny Purnomowati, S.Kep.Ns', '2026-02-14 16:46:10'),
(270, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 16:47:01'),
(271, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'CREATE FASILITATOR [ID:77] Ariny Purnomowati, S.Kep.Ns', '2026-02-14 16:47:18'),
(272, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'DELETE FASILITATOR [ID:77] undefined', '2026-02-14 16:47:24'),
(273, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 16:52:45'),
(274, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'CREATE FASILITATOR [ID:78] Puji Lestari, S.Kep.Ns', '2026-02-14 16:53:02'),
(275, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'DELETE FASILITATOR [ID:78] undefined', '2026-02-14 16:53:06'),
(276, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'UPDATE FASILITATOR [ID:74] dari \"undefined\" menjadi \"Arikh Ratna Purwadi, S.Kep.Ns., MH\"', '2026-02-14 16:53:20'),
(277, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-14 17:00:19'),
(278, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'UPDATE FASILITATOR [ID:74] dari \"undefined\" menjadi \"Arikh Ratna Purwadi, S.Kep.Ns., MH\"', '2026-02-14 17:00:30'),
(279, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-15 10:59:52'),
(280, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-15 11:03:27'),
(281, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 64 (azmitmit)', '2026-02-15 11:07:25'),
(282, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'AKSI', 'Validasi pembayaran VALID untuk ID pendaftaran 64 (azmitmit)', '2026-02-15 11:12:55'),
(283, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGOUT', 'Admin [ID:17] aaa melakukan logout', '2026-02-15 11:55:15'),
(284, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-15 11:55:23'),
(285, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/144.0.0.0 Safari/537.36', 'LOGOUT', 'Admin [ID:15] Azmita Saifani A melakukan logout', '2026-02-15 11:55:49'),
(286, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-19 08:56:51'),
(287, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-19 09:11:19'),
(288, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-19 09:15:33'),
(289, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-19 09:23:14'),
(290, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-19 09:30:06'),
(291, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGOUT', 'Admin [ID:17] aaa melakukan logout', '2026-02-19 09:32:34'),
(292, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-19 09:32:41'),
(293, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-19 09:42:38'),
(294, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-19 10:01:40'),
(295, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-19 10:20:40'),
(296, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-19 10:46:35'),
(297, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-19 10:51:56'),
(298, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-19 10:54:17'),
(299, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-19 11:16:36'),
(300, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-19 11:20:40'),
(301, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-19 11:23:54'),
(302, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-19 13:38:48'),
(303, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-19 13:43:47'),
(304, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-19 13:45:54'),
(305, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-19 13:57:23'),
(306, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-19 14:00:19'),
(307, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'UPDATE FASILITATOR [ID:74] dari \"undefined\" menjadi \"Arikh Ratna Purwadi, S.Kep.Ns., MH\"', '2026-02-19 14:00:30'),
(308, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'UPDATE FASILITATOR [ID:74] dari \"undefined\" menjadi \"Arikh Ratna Purwadi, S.Kep.Ns., MH\"', '2026-02-19 14:00:34'),
(309, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-21 15:57:55'),
(310, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-21 16:06:46'),
(311, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-21 16:14:03'),
(312, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-21 16:16:16'),
(313, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-21 16:17:12'),
(314, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-21 16:28:19'),
(315, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-21 16:31:50'),
(316, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-21 16:33:37'),
(317, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-21 16:35:27'),
(318, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-21 16:37:13'),
(319, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-21 16:40:20'),
(320, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-21 16:47:00'),
(321, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-21 16:48:05'),
(322, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-21 17:03:23'),
(323, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-21 17:04:51'),
(324, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Validasi pembayaran VALID untuk ID pendaftaran 55 (Azmita)', '2026-02-21 17:06:19'),
(325, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Validasi pembayaran VALID untuk ID pendaftaran 51 (Saifani Aweawe)', '2026-02-21 17:06:33'),
(326, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 54 (Mamamiamaia)', '2026-02-21 17:07:14'),
(327, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-23 06:51:43'),
(328, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-23 06:56:20'),
(329, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-23 07:00:22'),
(330, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-23 07:02:33'),
(331, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-23 07:04:04'),
(332, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-23 07:07:21'),
(333, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-23 07:12:33'),
(334, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-23 07:15:24'),
(335, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-23 07:21:06'),
(336, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'UPDATE FASILITATOR [ID:74] dari \"undefined\" menjadi \"Arikh Ratna Purwadi, S.Kep.Ns., MH\"', '2026-02-23 07:21:16'),
(337, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'DELETE FASILITATOR [ID:74] undefined', '2026-02-23 07:21:22'),
(338, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'CREATE FASILITATOR [ID:79] Arikh Ratna Purwadi, S.Kep.Ns., MH', '2026-02-23 07:21:39'),
(339, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'UPDATE FASILITATOR [ID:79] dari \"undefined\" menjadi \"Arikh Ratna Purwadi, S.Kep.Ns., MH\"', '2026-02-23 07:21:54'),
(340, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-23 07:41:21'),
(341, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-23 07:46:09'),
(342, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-23 07:49:48'),
(343, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-23 07:54:34'),
(344, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update pelatihan ID 17', '2026-02-23 07:54:48'),
(345, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update pelatihan ID 17', '2026-02-23 07:54:56'),
(346, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-23 07:56:07'),
(347, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menambahkan pelatihan [ID:30]', '2026-02-23 07:56:33'),
(348, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-23 07:57:45'),
(349, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Hapus pelatihan ID 30', '2026-02-23 07:57:58'),
(350, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-23 08:07:04'),
(351, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-23 08:10:27'),
(352, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-23 08:14:14'),
(353, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 63 (Azmita)', '2026-02-23 08:15:50'),
(354, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-23 08:19:35'),
(355, NULL, '-', 'SYSTEM', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Validasi pembayaran VALID untuk ID pendaftaran 63 (Azmita)', '2026-02-23 08:20:09'),
(356, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-24 14:32:22'),
(357, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-24 14:35:23'),
(358, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-24 14:36:47'),
(359, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-24 14:58:05'),
(360, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-24 15:16:25'),
(361, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-24 16:48:11'),
(362, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-24 16:52:31'),
(363, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-24 17:08:13'),
(364, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-24 17:08:39'),
(365, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-24 17:28:27'),
(366, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-24 17:34:42'),
(367, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-24 17:40:49'),
(368, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menempatkan anggota 1 ke jabatan 1', '2026-02-24 17:41:20'),
(369, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-24 17:47:34'),
(370, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update jabatan ID 2', '2026-02-24 17:51:17'),
(371, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update jabatan ID 3', '2026-02-24 17:51:35'),
(372, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Tambah jabatan Administrasi Pelatihan Logistik', '2026-02-24 17:53:04'),
(373, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Tambah jabatan Administrasi Pelatihan Logistik', '2026-02-24 17:53:40'),
(374, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update jabatan ID 8', '2026-02-24 17:56:14'),
(375, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update jabatan ID 8', '2026-02-24 17:56:24'),
(376, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update jabatan ID 8', '2026-02-24 17:56:30'),
(377, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Tambah jabatan Administrasi Pelatihan', '2026-02-24 17:57:15'),
(378, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update jabatan ID 8', '2026-02-24 17:57:28'),
(379, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Tambah jabatan Administrasi Pelatihan', '2026-02-24 17:57:46'),
(380, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Tambah jabatan Administrasi Pelatihan dan Sistem Informasi', '2026-02-24 17:58:14'),
(381, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update jabatan ID 8', '2026-02-24 17:58:23'),
(382, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update jabatan ID 10', '2026-02-24 17:58:30'),
(383, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update jabatan ID 11', '2026-02-24 17:58:37'),
(384, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Tambah jabatan Administrasi Pendidikan', '2026-02-24 17:58:55'),
(385, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Tambah jabatan Administrasi Penelitian', '2026-02-24 17:59:21'),
(386, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Tambah jabatan Administrasi Umum', '2026-02-24 18:00:39'),
(387, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-24 18:15:53'),
(388, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Tambah anggota dr. JUANITA INDRATI, MM', '2026-02-24 18:16:13'),
(389, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Tambah anggota dr. JUANITA INDRATI, MM  ABDUL ROSID', '2026-02-24 18:16:32'),
(390, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Tambah anggota RADITYA NORISKI, SKM', '2026-02-24 18:16:47'),
(391, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Tambah anggota SALSABILLA RUSHDA, SKM', '2026-02-24 18:17:12'),
(392, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Tambah anggota TIO AMIRUDIN, S.Kom', '2026-02-24 18:17:27'),
(393, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Tambah anggota ARA AMALIA, SKM', '2026-02-24 18:17:44'),
(394, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Tambah anggota DENY INDRIANTO', '2026-02-24 18:17:55'),
(395, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Tambah anggota ZANUAR FAUZI', '2026-02-24 18:18:06'),
(396, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-24 18:20:59'),
(397, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menempatkan anggota 1 ke jabatan 2', '2026-02-24 18:21:18'),
(398, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menempatkan anggota 2 ke jabatan 3', '2026-02-24 18:21:31'),
(399, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menempatkan anggota 3 ke jabatan 8', '2026-02-24 18:21:38'),
(400, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menempatkan anggota 4 ke jabatan 10', '2026-02-24 18:21:45'),
(401, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menempatkan anggota 5 ke jabatan 10', '2026-02-24 18:22:01'),
(402, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menempatkan anggota 6 ke jabatan 12', '2026-02-24 18:22:14'),
(403, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menempatkan anggota 7 ke jabatan 13', '2026-02-24 18:22:37'),
(404, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menempatkan anggota 8 ke jabatan 14', '2026-02-24 18:22:50'),
(405, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menempatkan anggota 9 ke jabatan 15', '2026-02-24 18:23:04'),
(406, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update jabatan ID 8', '2026-02-24 18:24:00'),
(407, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update jabatan ID 2', '2026-02-24 18:24:10'),
(408, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update jabatan ID 10', '2026-02-24 18:24:30'),
(409, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update jabatan ID 11', '2026-02-24 18:24:37'),
(410, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update jabatan ID 12', '2026-02-24 18:24:43'),
(411, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update jabatan ID 13', '2026-02-24 18:24:48'),
(412, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update jabatan ID 14', '2026-02-24 18:24:53'),
(413, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update jabatan ID 15', '2026-02-24 18:24:59'),
(414, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-24 18:26:18'),
(415, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-26 06:37:44'),
(416, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-26 06:46:32'),
(417, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-26 06:51:05'),
(418, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-26 07:06:39'),
(419, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-26 07:11:43'),
(420, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-26 07:13:13'),
(421, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Tambah jabatan Administrasi Pelatihan', '2026-02-26 07:13:38'),
(422, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Tambah jabatan Administrasi Pelatihan Logistik', '2026-02-26 07:14:04'),
(423, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-26 07:43:46'),
(424, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-26 15:24:24'),
(425, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-26 15:37:39'),
(426, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-26 16:23:26'),
(427, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-26 16:26:36'),
(428, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-26 16:28:58'),
(429, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-26 16:34:08'),
(430, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-26 16:44:20'),
(431, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-26 16:46:32'),
(432, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-26 17:05:20'),
(433, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menempatkan anggota 3 ke jabatan 1', '2026-02-26 17:05:27'),
(434, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menempatkan anggota 3 ke jabatan 15', '2026-02-26 17:05:49'),
(435, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-26 17:14:38');
INSERT INTO `log_admin` (`id_log`, `id_user`, `email`, `nama_lengkap`, `ip_address`, `user_agent`, `aktivitas`, `keterangan`, `created_at`) VALUES
(436, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '', 'Hapus penempatan jabatan ID 15', '2026-02-26 17:15:28'),
(437, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menempatkan anggota 9 ke jabatan 15', '2026-02-26 17:15:53'),
(438, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '', 'Hapus penempatan jabatan ID 1', '2026-02-26 17:16:09'),
(439, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menempatkan anggota 1 ke jabatan 1', '2026-02-26 17:16:24'),
(440, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '', 'Hapus penempatan jabatan ID 15', '2026-02-26 17:16:29'),
(441, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-26 17:20:57'),
(442, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menempatkan anggota 9 ke jabatan 15', '2026-02-26 17:21:31'),
(443, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '', 'Hapus penempatan jabatan ID 15', '2026-02-26 17:21:36'),
(444, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menempatkan anggota 9 ke jabatan 15', '2026-02-26 17:21:43'),
(445, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '', 'Hapus penempatan jabatan ID 1', '2026-02-26 17:21:48'),
(446, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menempatkan anggota 1 ke jabatan 1', '2026-02-26 17:21:57'),
(447, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-26 17:25:58'),
(448, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '', 'Hapus jabatan ID 15', '2026-02-26 17:26:06'),
(449, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Tambah jabatan Administrasi Umum', '2026-02-26 17:26:22'),
(450, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '', 'Hapus jabatan ID 18', '2026-02-26 17:26:43'),
(451, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Tambah jabatan Administrasi Umum', '2026-02-26 17:27:12'),
(452, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menempatkan anggota 9 ke jabatan 19', '2026-02-26 17:27:30'),
(453, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '', 'Hapus jabatan ID 19', '2026-02-26 17:27:36'),
(454, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Tambah jabatan Administrasi Umum', '2026-02-26 17:27:53'),
(455, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-26 17:28:12'),
(456, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menempatkan anggota 9 ke jabatan 20', '2026-02-26 17:28:23'),
(457, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-26 17:36:42'),
(458, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menempatkan anggota 9 ke jabatan 20', '2026-02-26 17:37:13'),
(459, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menempatkan anggota 9 ke jabatan 20', '2026-02-26 17:37:47'),
(460, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '', 'Hapus jabatan ID 20', '2026-02-26 17:37:57'),
(461, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Tambah jabatan Administrasi Umum', '2026-02-26 17:38:25'),
(462, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menempatkan anggota 9 ke jabatan 21', '2026-02-26 17:38:36'),
(463, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-26 17:42:33'),
(464, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-26 17:49:57'),
(465, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-26 17:55:41'),
(466, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-26 18:03:16'),
(467, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-26 18:05:22'),
(468, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-26 18:07:21'),
(469, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-26 18:08:10'),
(470, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-26 18:11:53'),
(471, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-26 18:14:58'),
(472, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-26 18:17:16'),
(473, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Tambah anggota ABDUL ROSID', '2026-02-26 18:17:46'),
(474, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Tambah jabatan Administrasi Pelatihan Logistik', '2026-02-26 18:18:09'),
(475, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Tambah jabatan Administrasi Pelatihan Logistik', '2026-02-26 18:19:03'),
(476, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-26 18:22:33'),
(477, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '', 'Hapus jabatan ID 22', '2026-02-26 18:22:50'),
(478, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', '', 'Hapus jabatan ID 23', '2026-02-26 18:22:54'),
(479, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menempatkan anggota 10 ke jabatan 8', '2026-02-26 18:23:06'),
(480, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-26 18:24:08'),
(481, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-27 07:34:02'),
(482, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGOUT', 'Admin [ID:17] aaa melakukan logout', '2026-02-27 07:34:51'),
(483, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN_GAGAL', 'Password salah', '2026-02-27 07:34:58'),
(484, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-27 07:35:14'),
(485, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menambah admin baru (fulan@gmail.com)', '2026-02-27 07:37:21'),
(486, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGOUT', 'Admin [ID:15] Azmita Saifani A melakukan logout', '2026-02-27 07:37:28'),
(487, 19, 'fulan@gmail.com', 'Fulan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-27 07:37:38'),
(488, 19, 'fulan@gmail.com', 'Fulan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update pelatihan ID 23', '2026-02-27 07:44:18'),
(489, 19, 'fulan@gmail.com', 'Fulan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update pelatihan ID 18', '2026-02-27 07:44:28'),
(490, 19, 'fulan@gmail.com', 'Fulan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update pelatihan ID 18', '2026-02-27 07:44:44'),
(491, 19, 'fulan@gmail.com', 'Fulan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update pelatihan ID 18', '2026-02-27 07:45:03'),
(492, 19, 'fulan@gmail.com', 'Fulan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Hapus pelatihan ID 18', '2026-02-27 07:45:13'),
(493, 19, 'fulan@gmail.com', 'Fulan', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Hapus pelatihan ID 19', '2026-02-27 07:45:21'),
(494, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-27 07:48:14'),
(495, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-27 07:52:43'),
(496, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-27 07:55:44'),
(497, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-27 07:56:42'),
(498, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-27 07:59:11'),
(499, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update pelatihan ID 22', '2026-02-27 07:59:40'),
(500, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update pelatihan ID 17', '2026-02-27 08:00:14'),
(501, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-27 08:19:45'),
(502, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-02-27 08:20:16'),
(503, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-01 14:41:59'),
(504, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-01 14:50:30'),
(505, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-01 15:05:41'),
(506, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGOUT', 'Admin [ID:17] aaa melakukan logout', '2026-03-01 15:06:03'),
(507, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-01 15:06:10'),
(508, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 02:14:44'),
(509, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGOUT', 'Admin [ID:17] aaa melakukan logout', '2026-03-02 02:20:35'),
(510, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 03:04:10'),
(511, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 03:08:18'),
(512, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 03:13:02'),
(513, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 03:26:20'),
(514, NULL, '-', 'SYSTEM', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Validasi pembayaran VALID untuk ID pendaftaran 68 (galihhh)', '2026-03-02 03:26:39'),
(515, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 03:32:49'),
(516, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 03:50:14'),
(517, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 03:55:27'),
(518, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'CREATE FASILITATOR [ID:80] BETA SUGIARSO, M.Kep.Ns', '2026-03-02 03:55:39'),
(519, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 03:58:02'),
(520, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'DELETE FASILITATOR [ID:80] undefined', '2026-03-02 03:58:09'),
(521, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 03:59:02'),
(522, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 04:00:26'),
(523, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 04:02:38'),
(524, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 04:05:13'),
(525, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 04:07:18'),
(526, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 04:09:58'),
(527, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 04:23:45'),
(528, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 04:28:59'),
(529, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 04:31:55'),
(530, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 04:34:21'),
(531, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 04:45:08'),
(532, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 04:46:56'),
(533, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 04:52:30'),
(534, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 04:59:00'),
(535, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 05:16:37'),
(536, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 05:17:26'),
(537, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 05:19:31'),
(538, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menambahkan pelatihan [ID:31]', '2026-03-02 05:20:29'),
(539, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 05:23:12'),
(540, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menambahkan pelatihan [ID:32]', '2026-03-02 05:23:55'),
(541, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 05:28:02'),
(542, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menambahkan pelatihan [ID:33]', '2026-03-02 05:28:39'),
(543, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 05:32:25'),
(544, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menambahkan pelatihan [ID:34]', '2026-03-02 05:32:58'),
(545, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 05:38:46'),
(546, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 05:41:33'),
(547, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Hapus pelatihan ID 34', '2026-03-02 05:41:53'),
(548, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menambahkan pelatihan [ID:35]', '2026-03-02 05:42:35'),
(549, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 05:44:09'),
(550, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menambahkan pelatihan [ID:36]', '2026-03-02 05:45:00'),
(551, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 05:55:35'),
(552, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update pelatihan ID 31', '2026-03-02 05:55:55'),
(553, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menambahkan pelatihan [ID:37]', '2026-03-02 05:56:43'),
(554, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 05:58:04'),
(555, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 05:59:31'),
(556, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menambahkan pelatihan [ID:38]', '2026-03-02 06:00:11'),
(557, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 06:01:23'),
(558, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menambahkan pelatihan [ID:39]', '2026-03-02 06:02:10'),
(559, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 06:02:58'),
(560, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Hapus pelatihan ID 38', '2026-03-02 06:03:14'),
(561, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Hapus pelatihan ID 37', '2026-03-02 06:03:16'),
(562, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Hapus pelatihan ID 39', '2026-03-02 06:03:19'),
(563, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menambahkan pelatihan [ID:40]', '2026-03-02 06:03:56'),
(564, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Hapus pelatihan ID 31', '2026-03-02 06:04:15'),
(565, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Hapus pelatihan ID 32', '2026-03-02 06:04:19'),
(566, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Hapus pelatihan ID 33', '2026-03-02 06:04:22'),
(567, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Hapus pelatihan ID 35', '2026-03-02 06:04:28'),
(568, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Hapus pelatihan ID 40', '2026-03-02 06:04:33'),
(569, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 06:07:40'),
(570, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update pelatihan ID 23', '2026-03-02 06:07:53'),
(571, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update pelatihan ID 17', '2026-03-02 06:08:06'),
(572, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update pelatihan ID 23', '2026-03-02 06:08:24'),
(573, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menambahkan pelatihan [ID:41]', '2026-03-02 06:09:29'),
(574, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 06:17:31'),
(575, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Hapus pelatihan ID 41', '2026-03-02 06:17:43'),
(576, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menambahkan pelatihan [ID:42]', '2026-03-02 06:18:30'),
(577, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 06:20:21'),
(578, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menambahkan pelatihan [ID:43]', '2026-03-02 06:20:57'),
(579, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update pelatihan ID 42', '2026-03-02 06:25:31'),
(580, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update pelatihan ID 42', '2026-03-02 06:25:40'),
(581, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Hapus pelatihan ID 42', '2026-03-02 06:25:54'),
(582, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Hapus pelatihan ID 43', '2026-03-02 06:25:58'),
(583, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 06:45:30'),
(584, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menambahkan pelatihan [ID:44]', '2026-03-02 06:46:10'),
(585, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 06:49:20'),
(586, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Hapus pelatihan ID 44', '2026-03-02 06:49:34'),
(587, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 06:51:16'),
(588, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Hapus pelatihan ID 36', '2026-03-02 06:51:29'),
(589, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menambahkan pelatihan [ID:45]', '2026-03-02 06:52:12'),
(590, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 06:56:16'),
(591, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Hapus pelatihan ID 45', '2026-03-02 06:56:25'),
(592, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menambahkan pelatihan [ID:46]', '2026-03-02 06:56:47'),
(593, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Hapus pelatihan ID 46', '2026-03-02 06:56:57'),
(594, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menambahkan pelatihan [ID:47]', '2026-03-02 06:57:58'),
(595, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update pelatihan ID 47', '2026-03-02 06:58:16'),
(596, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-02 07:18:07'),
(597, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-10 18:50:25'),
(598, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Hapus pelatihan ID 47', '2026-03-10 18:50:37'),
(599, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-10 18:54:55'),
(600, NULL, '-', 'SYSTEM', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Validasi pembayaran VALID untuk ID pendaftaran 63 (Azmita)', '2026-03-10 18:55:23'),
(601, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-10 19:21:09'),
(602, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-10 19:27:41'),
(603, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-10 19:49:45'),
(604, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-10 20:10:36'),
(605, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-10 20:23:16'),
(606, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-11 03:16:50'),
(607, 0, 'null', 'null', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update jabatan ID 3', '2026-03-11 03:22:10'),
(608, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 69 (AZMITAAA)', '2026-03-11 03:36:07'),
(609, NULL, '-', 'SYSTEM', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Validasi pembayaran VALID untuk ID pendaftaran 69 (AZMITAAA)', '2026-03-11 03:38:07'),
(610, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGOUT', 'Admin [ID:17] aaa melakukan logout', '2026-03-11 03:48:01'),
(611, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-11 03:48:15'),
(612, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGOUT', 'Admin [ID:15] Azmita Saifani A melakukan logout', '2026-03-11 03:48:42'),
(613, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-11 03:49:01'),
(614, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menambahkan pelatihan [ID:48]', '2026-03-11 03:53:19'),
(615, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-12 16:07:56'),
(616, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-12 16:39:52'),
(617, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-12 16:43:17'),
(618, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-12 16:44:06'),
(619, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-12 16:48:10'),
(620, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-12 16:52:05'),
(621, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-12 17:01:08'),
(622, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-12 17:05:23'),
(623, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-12 17:12:57'),
(624, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-12 17:15:34'),
(625, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update kalender pelatihan tahun 2026', '2026-03-12 17:15:53'),
(626, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update kalender pelatihan tahun 2026', '2026-03-12 17:16:01'),
(627, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menambahkan kalender pelatihan tahun 2027', '2026-03-12 17:16:12'),
(628, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-12 17:18:58'),
(629, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-12 17:20:51'),
(630, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-12 17:22:25'),
(631, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-12 17:24:16'),
(632, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menambahkan kalender pelatihan tahun 2323', '2026-03-12 17:24:49'),
(633, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update kalender pelatihan tahun 2027', '2026-03-12 17:25:46'),
(634, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menambahkan kalender pelatihan tahun 2028', '2026-03-12 17:26:37'),
(635, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-12 17:33:50'),
(636, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-12 17:40:05'),
(637, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-12 17:42:41'),
(638, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-12 17:44:26'),
(639, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-12 17:45:19'),
(640, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-12 17:47:23'),
(641, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update kalender pelatihan ID 10', '2026-03-12 17:47:34'),
(642, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menambahkan kalender pelatihan tahun 2019', '2026-03-12 17:48:20'),
(643, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGOUT', 'Admin [ID:17] aaa melakukan logout', '2026-03-12 17:50:17'),
(644, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-12 17:50:26'),
(645, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-12 17:54:41'),
(646, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-12 18:07:14'),
(647, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-12 18:13:37'),
(648, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 70 (AZMIT)', '2026-03-12 18:13:54'),
(649, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-12 18:18:09'),
(650, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-12 18:42:21'),
(651, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-12 18:43:57'),
(652, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-12 18:49:19'),
(653, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-12 19:03:03'),
(654, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-12 19:11:40'),
(655, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-13 03:39:17'),
(656, 0, 'null', 'null', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Tambah jabatan Administrasi Pelatihan', '2026-03-13 04:15:42'),
(657, 0, 'null', 'null', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Tambah anggota Hesti Yunita, S.Pd', '2026-03-13 04:34:57');
INSERT INTO `log_admin` (`id_log`, `id_user`, `email`, `nama_lengkap`, `ip_address`, `user_agent`, `aktivitas`, `keterangan`, `created_at`) VALUES
(658, 0, 'null', 'null', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menempatkan anggota 11 ke jabatan 10', '2026-03-13 04:35:20'),
(659, 0, 'null', 'null', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menempatkan anggota 4 ke jabatan 24', '2026-03-13 04:35:46'),
(660, 0, 'null', 'null', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Tambah jabatan Administrasi Pelatihan', '2026-03-13 04:36:40'),
(661, 0, 'null', 'null', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menempatkan anggota 5 ke jabatan 25', '2026-03-13 04:36:54'),
(662, 0, 'null', 'null', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update jabatan ID 12', '2026-03-13 04:37:44'),
(663, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGOUT', 'Admin [ID:17] aaa melakukan logout', '2026-03-13 04:43:30'),
(664, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-13 04:43:43'),
(665, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGOUT', 'Admin [ID:15] Azmita Saifani A melakukan logout', '2026-03-13 04:48:59'),
(666, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-13 04:49:07'),
(667, NULL, '-', 'SYSTEM', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Validasi pembayaran VALID untuk ID pendaftaran 70 (AZMIT)', '2026-03-13 04:50:13'),
(668, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-13 05:02:10'),
(669, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 71 (azmi)', '2026-03-13 05:02:45'),
(670, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-13 05:13:34'),
(671, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 71 (azmi)', '2026-03-13 05:15:07'),
(672, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Validasi pembayaran VALID untuk ID pendaftaran 71 (azmi)', '2026-03-13 05:16:11'),
(673, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-13 05:19:09'),
(674, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-13 05:22:28'),
(675, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-13 05:47:41'),
(676, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-13 05:56:53'),
(677, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-13 06:01:03'),
(678, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGOUT', 'Admin [ID:17] aaa melakukan logout', '2026-03-13 06:01:19'),
(679, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-13 06:01:30'),
(680, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-13 06:09:47'),
(681, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-13 07:15:48'),
(682, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-13 07:19:23'),
(683, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 71 (azmi)', '2026-03-13 07:20:19'),
(684, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 70 (AZMIT)', '2026-03-13 07:21:21'),
(685, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-13 07:26:42'),
(686, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 70 (AZMIT)', '2026-03-13 07:27:26'),
(687, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 70 (AZMIT)', '2026-03-13 07:32:41'),
(688, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-13 07:33:38'),
(689, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 70 (AZMIT)', '2026-03-13 07:33:56'),
(690, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-13 07:35:35'),
(691, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 70 (AZMIT)', '2026-03-13 07:35:51'),
(692, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 71 (azmi)', '2026-03-13 07:37:27'),
(693, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-13 07:56:38'),
(694, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-13 08:03:22'),
(695, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-13 08:34:07'),
(696, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update pelatihan ID 48', '2026-03-13 08:34:18'),
(697, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-13 17:02:23'),
(698, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-13 17:58:35'),
(699, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-13 18:01:39'),
(700, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-13 18:03:30'),
(701, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-13 18:07:58'),
(702, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Menambahkan pelatihan [ID:49]', '2026-03-13 18:08:38'),
(703, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/145.0.0.0 Safari/537.36', 'AKSI', 'Update pelatihan ID 49', '2026-03-13 18:08:55'),
(704, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-20 16:05:22'),
(705, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN_GAGAL', 'Password salah', '2026-03-20 16:20:07'),
(706, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-20 16:20:17'),
(707, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 125 (Azmita Saifani)', '2026-03-20 16:20:41'),
(708, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-20 16:40:47'),
(709, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 124 (Azmita Saifani)', '2026-03-20 16:40:59'),
(710, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-20 16:44:50'),
(711, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 123 (Azmita Saifani)', '2026-03-20 16:45:11'),
(712, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-20 16:59:12'),
(713, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 122 (Azmita Saifani)', '2026-03-20 16:59:27'),
(714, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-20 17:03:45'),
(715, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 126 (Azmita Saifani)', '2026-03-20 17:04:04'),
(716, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-20 17:07:56'),
(717, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 121 (Azmita Saifani)', '2026-03-20 17:08:13'),
(718, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-20 17:12:49'),
(719, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 120 (Azmita Saifani)', '2026-03-20 17:13:02'),
(720, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 109 (Azmita Saifani)', '2026-03-20 17:14:35'),
(721, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-20 17:22:00'),
(722, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas INVALID untuk ID 119 (Azmita Saifani)', '2026-03-20 17:22:13'),
(723, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-20 17:52:32'),
(724, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'AKSI', 'Validasi pembayaran VALID untuk ID pendaftaran 120 (Azmita Saifani)', '2026-03-20 17:53:34'),
(725, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-20 18:01:42'),
(726, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 118 (Azmita Saifani)', '2026-03-20 18:02:32'),
(727, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-20 18:08:59'),
(728, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'AKSI', 'Validasi pembayaran VALID untuk ID 118 (Azmita Saifani)', '2026-03-20 18:09:08'),
(729, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-20 18:10:23'),
(730, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'AKSI', 'Validasi pembayaran VALID untuk ID 120 (Azmita Saifani)', '2026-03-20 18:10:33'),
(731, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-20 18:15:00'),
(732, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 117 (Azmita Saifani)', '2026-03-20 18:15:13'),
(733, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'AKSI', 'Validasi pembayaran INVALID untuk ID 117 (Azmita Saifani)', '2026-03-20 18:15:56'),
(734, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-20 18:25:11'),
(735, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-20 18:27:38'),
(736, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-20 18:30:46'),
(737, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-20 18:37:42'),
(738, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 115 (Azmita Saifani)', '2026-03-20 18:37:53'),
(739, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'AKSI', 'Validasi pembayaran INVALID untuk ID 115 (Azmita Saifani)', '2026-03-20 18:40:14'),
(740, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-20 18:48:41'),
(741, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 114 (Azmita Saifani)', '2026-03-20 18:48:59'),
(742, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'AKSI', 'Validasi pembayaran INVALID untuk ID 114 (Azmita Saifani)', '2026-03-20 18:50:26'),
(743, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-25 03:19:00'),
(744, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-25 03:31:40'),
(745, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 108 (Azmita Saifani)', '2026-03-25 03:34:43'),
(746, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'AKSI', 'Validasi pembayaran INVALID untuk ID 108 (Azmita Saifani)', '2026-03-25 03:36:00'),
(747, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-25 03:42:46'),
(748, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 107 (Azmita Saifani)', '2026-03-25 03:42:58'),
(749, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 103 (Azmita Saifani)', '2026-03-25 03:43:29'),
(750, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'AKSI', 'Validasi pembayaran INVALID untuk ID 103 (Azmita Saifani)', '2026-03-25 03:44:14'),
(751, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-25 04:56:08'),
(752, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 102 (Azmita Saifani)', '2026-03-25 04:56:41'),
(753, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-25 04:59:29'),
(754, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas VALID untuk ID 92 (Azmita Saifani)', '2026-03-25 05:00:18'),
(755, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'AKSI', 'Validasi pembayaran INVALID untuk ID 92 (Azmita Saifani)', '2026-03-25 05:01:01'),
(756, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-25 05:22:45'),
(757, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'AKSI', 'Validasi pembayaran VALID untuk ID 102 (Azmita Saifani)', '2026-03-25 05:25:18'),
(758, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'AKSI', 'Update pelatihan ID 24', '2026-03-25 05:26:27'),
(759, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'AKSI', 'Validasi pembayaran VALID untuk ID 103 (Azmita Saifani)', '2026-03-25 05:26:35'),
(760, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-25 05:44:39'),
(761, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas INVALID untuk ID 106 (Azmita Saifani)', '2026-03-25 05:44:58'),
(762, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas INVALID untuk ID 85 (Azmita Saifani)', '2026-03-25 05:49:54'),
(763, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-25 06:16:11'),
(764, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas INVALID untuk ID 127 (Azmita Saifani)', '2026-03-25 06:16:53'),
(765, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-25 06:33:12'),
(766, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'AKSI', 'Verifikasi berkas INVALID untuk ID 127 (Azmita Saifani)', '2026-03-25 06:33:48'),
(767, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-25 06:45:05'),
(768, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-25 16:03:13'),
(769, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-25 16:20:05'),
(770, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-25 16:21:59'),
(771, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-25 16:25:56'),
(772, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-25 16:27:12'),
(773, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-25 16:29:22'),
(774, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-25 16:49:21'),
(775, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGOUT', 'Admin [ID:17] aaa melakukan logout', '2026-03-25 16:59:11'),
(776, 15, 'admin@gmail.com', 'Azmita Saifani A', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-25 16:59:21'),
(777, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-25 17:26:35'),
(778, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-26 11:22:44'),
(779, 17, 'admin1@gmail.com', 'aaa', '127.0.0.1', 'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/146.0.0.0 Safari/537.36', 'LOGIN', 'Admin login berhasil', '2026-03-26 11:24:56');

-- --------------------------------------------------------

--
-- Table structure for table `log_wa`
--

CREATE TABLE `log_wa` (
  `id_wa_log` int(11) NOT NULL,
  `id_pendaftaran` int(11) DEFAULT NULL,
  `no_wa` varchar(20) DEFAULT NULL,
  `nama_penerima` varchar(150) DEFAULT NULL,
  `jenis_wa` enum('BERKAS_PENDING','BERKAS_VALID','BERKAS_INVALID','PEMBAYARAN_PENDING','PEMBAYARAN_VALID','PEMBAYARAN_INVALID') DEFAULT NULL,
  `subject` varchar(255) DEFAULT NULL,
  `pesan` text DEFAULT NULL,
  `status` enum('TERKIRIM','GAGAL') DEFAULT 'TERKIRIM',
  `error_message` text DEFAULT NULL,
  `sent_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `log_wa`
--

INSERT INTO `log_wa` (`id_wa_log`, `id_pendaftaran`, `no_wa`, `nama_penerima`, `jenis_wa`, `subject`, `pesan`, `status`, `error_message`, `sent_at`) VALUES
(1, 120, '6287830736317', 'Azmita Saifani', 'BERKAS_PENDING', NULL, '. Halo Azmita Saifani, pendaftaran pelatihan DIKLAT RSUD Prof. Dr. Margono Soekarjo BERHASIL. Pelatihan yang Anda ikuti adalah Pelatihan Pencegahan dan Pengendalian Infeksi (PPI) bagi Tenaga Kesehatan di Fasilitas Kesehatan Tingkat Pertama (FKTP) yang akan dilaksanakan pada 30 Maret 2026 s.d. 2 April 2026.  Status pendaftaran pelatihan Anda saat ini dalam proses verifikasi berkas, untuk informasi selanjutnya harap cek berkala melalui WhatsApp maupun Email secara berkala. Terima kasih', 'TERKIRIM', NULL, '2026-03-17 22:50:03'),
(2, 120, '6287830736317', 'Azmita Saifani', 'BERKAS_PENDING', NULL, 'Halo Azmita Saifani, pendaftaran pelatihan DIKLAT RSUD Prof. Dr. Margono Soekarjo BERHASIL. Pelatihan yang Anda ikuti adalah Pelatihan Pencegahan dan Pengendalian Infeksi (PPI) bagi Tenaga Kesehatan di Fasilitas Kesehatan Tingkat Pertama (FKTP) yang akan dilaksanakan pada 30 Maret 2026 s.d. 2 April 2026. Status pendaftaran pelatihan Anda saat ini dalam proses verifikasi berkas. Terima kasih', 'TERKIRIM', NULL, '2026-03-17 22:50:03'),
(3, 121, '6287830736317', 'Azmita Saifani', 'BERKAS_PENDING', NULL, '. Halo Azmita Saifani, pendaftaran pelatihan DIKLAT RSUD Prof. Dr. Margono Soekarjo BERHASIL. Pelatihan yang Anda ikuti adalah Pelatihan Pencegahan dan Pengendalian Infeksi (PPI) bagi Tenaga Kesehatan di Fasilitas Kesehatan Tingkat Pertama (FKTP) yang akan dilaksanakan pada 30 Maret 2026 s.d. 2 April 2026.  Status pendaftaran pelatihan Anda saat ini dalam proses verifikasi berkas, untuk informasi selanjutnya harap cek berkala melalui WhatsApp maupun Email secara berkala. Terima kasih', 'TERKIRIM', NULL, '2026-03-17 23:01:22'),
(4, 122, '6287830736317', 'Azmita Saifani', 'BERKAS_PENDING', NULL, '. Halo Azmita Saifani, pendaftaran pelatihan DIKLAT RSUD Prof. Dr. Margono Soekarjo BERHASIL. Pelatihan yang Anda ikuti adalah Pelatihan Pencegahan dan Pengendalian Infeksi (PPI) bagi Tenaga Kesehatan di Fasilitas Kesehatan Tingkat Pertama (FKTP) yang akan dilaksanakan pada 30 Maret 2026 s.d. 2 April 2026.  Status pendaftaran pelatihan Anda saat ini dalam proses verifikasi berkas, untuk informasi selanjutnya harap cek berkala melalui WhatsApp maupun Email secara berkala. Terima kasih', 'TERKIRIM', NULL, '2026-03-17 23:04:54'),
(5, 125, '6287830736317', 'Azmita Saifani', 'BERKAS_PENDING', NULL, '. Halo Azmita Saifani, pendaftaran pelatihan DIKLAT RSUD Prof. Dr. Margono Soekarjo BERHASIL. Pelatihan yang Anda ikuti adalah Pelatihan Dialisis AK 2 Tahun 2025 yang akan dilaksanakan pada 30 Maret 2026 s.d. 3 April 2026.  Status pendaftaran pelatihan Anda saat ini dalam proses verifikasi berkas, untuk informasi selanjutnya harap cek berkala melalui WhatsApp maupun Email secara berkala. Terima kasih', 'TERKIRIM', NULL, '2026-03-17 23:26:10'),
(6, 125, '6287830736317', 'Azmita Saifani', '', NULL, '. Halo Azmita Saifani, berkas pendaftaran Anda telah DINYATAKAN VALID. Status saat ini: Menunggu Pembayaran. Pelatihan: Pelatihan Dialisis AK 2 Tahun 2025 (30 Maret 2026 s.d. 3 April 2026). Biaya: Rp 6.000.000. Silakan lakukan pembayaran dan upload bukti melalui link berikut: http://localhost:8080/pelatihanmargono/frontend/uploadpembayaran.html?token=MTI1LmJmNjE5MTFhMjI5ODNjNWIxOTViNTNiNmFjNzAxOTcxMTkzMjM1NjM3Y2MwYTc2YWE5NWViYTkzMjlkNzBkY2U= Terima kasih.', 'TERKIRIM', NULL, '2026-03-20 23:20:41'),
(7, 124, '6287830736317', 'Azmita Saifani', 'PEMBAYARAN_PENDING', NULL, '. Halo Azmita Saifani, berkas pendaftaran Anda telah DINYATAKAN VALID. Status saat ini: Menunggu Pembayaran. Pelatihan: Pelatihan Pencegahan dan Pengendalian Infeksi (PPI) bagi Tenaga Kesehatan di Fasilitas Kesehatan Tingkat Pertama (FKTP) (30 Maret 2026 s.d. 2 April 2026). Biaya: Rp 2.500.000. Silakan lakukan pembayaran dan upload bukti melalui link berikut: http://localhost:8080/pelatihanmargono/frontend/uploadpembayaran.html?token=MTI0Ljg1MTM2MjcxMTIzNzNkZDBiOTUwMmE2YzQ5YTAxYzhjZjFlMzMzMDBjNmZjZmE4MWU3ZTgyOTA3MGM5NzU4N2Y= Terima kasih.', 'TERKIRIM', NULL, '2026-03-20 23:40:59'),
(8, 123, '6287830736317', 'Azmita Saifani', 'PEMBAYARAN_PENDING', NULL, 'Halo Azmita Saifani, pendaftaran Anda sudah valid.', 'TERKIRIM', NULL, '2026-03-20 23:45:11'),
(9, 122, '6287830736317', 'Azmita Saifani', 'PEMBAYARAN_PENDING', NULL, '. Halo Azmita Saifani, berkas pendaftaran Anda telah DINYATAKAN VALID. Status saat ini: Menunggu Pembayaran. Pelatihan: Pelatihan Pencegahan dan Pengendalian Infeksi (PPI) bagi Tenaga Kesehatan di Fasilitas Kesehatan Tingkat Pertama (FKTP) (30 Maret 2026 s.d. 2 April 2026). Biaya: Rp 2.500.000. Silakan upload bukti pembayaran di: http://localhost:8080/pelatihanmargono/frontend/uploadpembayaran.html?token=MTIyLjJmMTQ3ZjljZWY4YzAyMjVhOWI4ZmZiY2RhYWE1YWQ3MjEyY2NiMWNhYjQ0YjdkNjU2ZDJhNjBlZjY0MjlkZWM= Terima kasih.', 'TERKIRIM', NULL, '2026-03-20 23:59:27'),
(10, 126, '6287830736317', 'Azmita Saifani', 'BERKAS_PENDING', NULL, '. Halo Azmita Saifani, pendaftaran pelatihan DIKLAT RSUD Prof. Dr. Margono Soekarjo BERHASIL. Pelatihan yang Anda ikuti adalah Pelatihan Dialisis AK 2 Tahun 2025 yang akan dilaksanakan pada 30 Maret 2026 s.d. 3 April 2026.  Status pendaftaran pelatihan Anda saat ini dalam proses verifikasi berkas, untuk informasi selanjutnya harap cek berkala melalui WhatsApp maupun Email secara berkala. Terima kasih', 'TERKIRIM', NULL, '2026-03-21 00:00:33'),
(11, 126, '6287830736317', 'Azmita Saifani', 'PEMBAYARAN_PENDING', NULL, '. Halo Azmita Saifani, berkas pendaftaran Anda telah DINYATAKAN VALID. Status saat ini: Menunggu Pembayaran. Pelatihan: Pelatihan Dialisis AK 2 Tahun 2025 (30 Maret 2026 s.d. 3 April 2026). Biaya: Rp 6.000.000. Silakan upload bukti pembayaran di: http://localhost:8080/pelatihanmargono/frontend/uploadpembayaran.html?token=MTI2LjEzYzE5ZDJhNDRiNjViZjhkMzgzNTczMzBlYjRmNDZhMjRiYzJlOWYyOGYyYTMwMDdjYzQzOTQ0YTY1MGU0NWI= Terima kasih.', 'TERKIRIM', NULL, '2026-03-21 00:04:04'),
(12, 121, '6287830736317', 'Azmita Saifani', 'PEMBAYARAN_PENDING', NULL, '. Halo Azmita Saifani, berkas pendaftaran Anda telah DINYATAKAN VALID. Status saat ini adalah Menunggu Pembayaran. Pelatihan yang Anda ikuti adalah Pelatihan Pencegahan dan Pengendalian Infeksi (PPI) bagi Tenaga Kesehatan di Fasilitas Kesehatan Tingkat Pertama (FKTP) yang akan dilaksanakan pada tanggal (30 Maret 2026 s.d. 2 April 2026). Biaya pendaftaran pelatihan Anda sebesar Rp 2.500.000. Silakan upload bukti pembayaran dengan mengakses link berikut; http://localhost:8080/pelatihanmargono/frontend/uploadpembayaran.html?token=MTIxLjA2OWM1NTJlY2E2MDM4OTgzMzdkMDM5YTYzODFkOWMyNjJkYmU0ZTQ1NGZjZjEzOWUzMWFhOGZkMTMxMmI1ZmQ= Terima kasih.', 'TERKIRIM', NULL, '2026-03-21 00:08:13'),
(13, 120, '6287830736317', 'Azmita Saifani', 'PEMBAYARAN_PENDING', NULL, '. Halo Azmita Saifani, berkas pendaftaran Anda telah DINYATAKAN VALID. Status saat ini adalah Menunggu Pembayaran. Pelatihan yang Anda ikuti adalah Pelatihan Pencegahan dan Pengendalian Infeksi (PPI) bagi Tenaga Kesehatan di Fasilitas Kesehatan Tingkat Pertama (FKTP) yang akan dilaksanakan pada tanggal 30 Maret 2026 s.d. 2 April 2026. Biaya pendaftaran pelatihan Anda sebesar Rp 2.500.000. Informasi pembayaran: Bank BNI, No Rekening 3380009008, Atas Nama RSUD PROF DR MARGONO SOEKARJO. Silakan upload bukti pembayaran dengan mengakses link berikut; http://localhost:8080/pelatihanmargono/frontend/uploadpembayaran.html?token=MTIwLjQzZDcwYTM2MzVlMzk1MGNlMWY5MmNlZDA4NDk1NmIzM2ZjNzUxNDViOTdlOThlMjE4ZTYwZTM0NDZlYTMyMjg= Terima kasih.', 'TERKIRIM', NULL, '2026-03-21 00:13:02'),
(14, 109, '6287830736317', 'Azmita Saifani', 'BERKAS_VALID', NULL, '. Halo Azmita Saifani, berkas pendaftaran Anda telah DINYATAKAN VALID. Anda resmi diterima pada pelatihan Pelatihan Keperawatan Intensif (ICU) AK 2 Tahun 2025 yang akan dilaksanakan pada 22 Maret 2026 s.d. 24 Maret 2026. Status saat ini: Diterima. Terima kasih.', 'TERKIRIM', NULL, '2026-03-21 00:14:35'),
(15, 119, '6287830736317', 'Azmita Saifani', 'BERKAS_INVALID', NULL, '. Halo Azmita Saifani, kami informasikan bahwa berkas pendaftaran Anda dinyatakan BELUM VALID. Pelatihan: Pelatihan Pencegahan dan Pengendalian Infeksi (PPI) bagi Tenaga Kesehatan di Fasilitas Kesehatan Tingkat Pertama (FKTP) dengan waktu pelaksanaan 30 Maret 2026 s.d. 2 April 2026. Silakan melakukan perbaikan berkas sesuai ketentuan yang berlaku dengan melakukan pendaftaran ulang pelatihan di Web Diklat Margono Informasi lebih lanjut akan disampaikan melalui email dan WhatsApp. Terima kasih', 'TERKIRIM', NULL, '2026-03-21 00:22:13'),
(16, 120, '6287830736317', 'Azmita Saifani', 'PEMBAYARAN_PENDING', NULL, '. Halo Azmita Saifani, bukti pembayaran Anda telah berhasil kami terima. Status saat ini adalah Menunggu Verifikasi Pembayaran. Pelatihan: Pelatihan Pencegahan dan Pengendalian Infeksi (PPI) bagi Tenaga Kesehatan di Fasilitas Kesehatan Tingkat Pertama (FKTP) (30 Maret 2026 s.d. 2 April 2026) di Aula Diklat RSUD Margono. Hasil verifikasi akan kami informasikan melalui WhatsApp atau Email. Terima kasih.', 'GAGAL', NULL, '2026-03-21 00:52:59'),
(17, 118, '6287830736317', 'Azmita Saifani', 'PEMBAYARAN_PENDING', NULL, '. Halo Azmita Saifani, berkas pendaftaran Anda telah DINYATAKAN VALID. Status pendaftaran anda saat ini adalah Menunggu Pembayaran. Pelatihan yang Anda ikuti adalah Pelatihan Dialisis AK 2 Tahun 2025 yang akan dilaksanakan pada tanggal 30 Maret 2026 s.d. 3 April 2026. Biaya pendaftaran pelatihan Anda sebesar Rp 6.000.000. Informasi pembayaran: Bank BNI, No Rekening 3380009008, Atas Nama RSUD PROF DR MARGONO SOEKARJO. Silakan upload bukti pembayaran dengan mengakses link berikut; http://localhost:8080/pelatihanmargono/frontend/uploadpembayaran.html?token=MTE4LmJkMTNlN2JkYWQ3OTEwODc3MmNkYjRmNGFiYTE1MDAyZDU5ZjhmYmExOTZiMzA5ZmU3ODIyMWUzMTk3YTFjYWE= Terima kasih', 'TERKIRIM', NULL, '2026-03-21 01:02:32'),
(18, 118, '6287830736317', 'Azmita Saifani', 'PEMBAYARAN_PENDING', NULL, '. Halo Azmita Saifani, bukti pembayaran Anda telah berhasil kami terima. Status saat ini adalah Menunggu Verifikasi Pembayaran. Pelatihan: Pelatihan Dialisis AK 2 Tahun 2025 (30 Maret 2026 s.d. 3 April 2026) di Aula 2. Hasil verifikasi akan kami informasikan melalui WhatsApp atau Email. Terima kasih.', 'TERKIRIM', NULL, '2026-03-21 01:03:19'),
(19, 118, '6287830736317', 'Azmita Saifani', 'PEMBAYARAN_VALID', NULL, '. Halo Azmita Saifani, pembayaran Anda telah kami terima dan dinyatakan VALID. Status pendaftaran Anda: DITERIMA. Pelatihan: Pelatihan Dialisis AK 2 Tahun 2025 yang akan dilaksanakan pada 30 Maret 2026 s.d. 3 April 2026 di Aula 2. Silakan bergabung ke grup peserta: https://chat.whatsapp.com/EWxrvgCjvjA3Ly5b4s810O. Terima kasih', 'TERKIRIM', NULL, '2026-03-21 01:09:08'),
(20, 120, '6287830736317', 'Azmita Saifani', 'PEMBAYARAN_VALID', NULL, '. Halo Azmita Saifani, pembayaran Anda telah kami terima dan dinyatakan VALID. Status pendaftaran Anda: DITERIMA. Pelatihan: Pelatihan Pencegahan dan Pengendalian Infeksi (PPI) bagi Tenaga Kesehatan di Fasilitas Kesehatan Tingkat Pertama (FKTP) yang akan dilaksanakan pada 30 Maret 2026 s.d. 2 April 2026 di Aula Diklat RSUD Margono. Informasi pelatihan selanjutnya akan kami sampaikan melalui grup tersebut. Terima kasih', 'TERKIRIM', NULL, '2026-03-21 01:10:33'),
(21, 117, '6287830736317', 'Azmita Saifani', 'PEMBAYARAN_PENDING', NULL, '. Halo Azmita Saifani, berkas pendaftaran Anda telah DINYATAKAN VALID. Status pendaftaran anda saat ini adalah Menunggu Pembayaran. Pelatihan yang Anda ikuti adalah Pelatihan Pencegahan dan Pengendalian Infeksi (PPI) bagi Tenaga Kesehatan di Fasilitas Kesehatan Tingkat Pertama (FKTP) yang akan dilaksanakan pada tanggal 30 Maret 2026 s.d. 2 April 2026. Biaya pendaftaran pelatihan Anda sebesar Rp 2.500.000. Informasi pembayaran: Bank BNI, No Rekening 3380009008, Atas Nama RSUD PROF DR MARGONO SOEKARJO. Silakan upload bukti pembayaran dengan mengakses link berikut; http://localhost:8080/pelatihanmargono/frontend/uploadpembayaran.html?token=MTE3LmJiYTk1ZTg2OTk0NWZkMTJhNzdkYzQ1MDYzYjY3ZDA4OGQxMjY5YWNhY2JlNTcyODdkZWRkZDA1YjM1ZmM2MDA= Terima kasih', 'TERKIRIM', NULL, '2026-03-21 01:15:13'),
(22, 117, '6287830736317', 'Azmita Saifani', 'PEMBAYARAN_PENDING', NULL, '. Halo Azmita Saifani, bukti pembayaran Anda telah berhasil kami terima. Status pendaftaran saat ini adalah Menunggu Verifikasi Pembayaran. Pelatihan: Pelatihan Pencegahan dan Pengendalian Infeksi (PPI) bagi Tenaga Kesehatan di Fasilitas Kesehatan Tingkat Pertama (FKTP) yang akan dilaksanakan pada 30 Maret 2026 s.d. 2 April 2026 di Aula Diklat RSUD Margono. Hasil verifikasi akan kami informasikan melalui WhatsApp atau Email. Terima kasih', 'TERKIRIM', NULL, '2026-03-21 01:15:43'),
(23, 117, '6287830736317', 'Azmita Saifani', 'PEMBAYARAN_INVALID', NULL, '. Halo Azmita Saifani, pembayaran Anda belum dapat kami validasi. Status saat ini: Perlu Perbaikan. Pelatihan: Pelatihan Pencegahan dan Pengendalian Infeksi (PPI) bagi Tenaga Kesehatan di Fasilitas Kesehatan Tingkat Pertama (FKTP) (30 Maret 2026 s.d. 2 April 2026) di Aula Diklat RSUD Margono. Silakan upload ulang bukti pembayaran yang valid melalui sistem. Terima kasih.', 'TERKIRIM', NULL, '2026-03-21 01:15:56'),
(24, 115, '6287830736317', 'Azmita Saifani', 'PEMBAYARAN_PENDING', NULL, '. Halo Azmita Saifani, berkas pendaftaran Anda telah DINYATAKAN VALID. Status pendaftaran anda saat ini adalah Menunggu Pembayaran. Pelatihan yang Anda ikuti adalah Pelatihan Pencegahan dan Pengendalian Infeksi (PPI) bagi Tenaga Kesehatan di Fasilitas Kesehatan Tingkat Pertama (FKTP) yang akan dilaksanakan pada tanggal 30 Maret 2026 s.d. 2 April 2026. Biaya pendaftaran pelatihan Anda sebesar Rp 2.500.000. Informasi pembayaran: Bank BNI, No Rekening 3380009008, Atas Nama RSUD PROF DR MARGONO SOEKARJO. Silakan upload bukti pembayaran dengan mengakses link berikut; http://localhost:8080/pelatihanmargono/frontend/uploadpembayaran.html?token=MTE1LmI3ZWVmYjM2ZjJhM2M2ZGZmNmI4N2Q0ZmU4MWRmMWUxYjJlZjAyM2IwZmFkN2I1YmRiNjE0YjZiZDEzZjQxNTQ= Terima kasih', 'TERKIRIM', NULL, '2026-03-21 01:37:53'),
(25, 115, '6287830736317', 'Azmita Saifani', 'PEMBAYARAN_PENDING', NULL, '. Halo Azmita Saifani, bukti pembayaran Anda telah berhasil kami terima. Status pendaftaran saat ini adalah Menunggu Verifikasi Pembayaran. Pelatihan: Pelatihan Pencegahan dan Pengendalian Infeksi (PPI) bagi Tenaga Kesehatan di Fasilitas Kesehatan Tingkat Pertama (FKTP) yang akan dilaksanakan pada 30 Maret 2026 s.d. 2 April 2026 di Aula Diklat RSUD Margono. Hasil verifikasi akan kami informasikan melalui WhatsApp atau Email. Terima kasih', 'TERKIRIM', NULL, '2026-03-21 01:40:00'),
(26, 115, '6287830736317', 'Azmita Saifani', 'PEMBAYARAN_INVALID', NULL, '. Halo Azmita Saifani, pembayaran Anda belum dapat kami validasi. Status saat ini: Perlu Perbaikan. Pelatihan: Pelatihan Pencegahan dan Pengendalian Infeksi (PPI) bagi Tenaga Kesehatan di Fasilitas Kesehatan Tingkat Pertama (FKTP) (30 Maret 2026 s.d. 2 April 2026) di Aula Diklat RSUD Margono. Silakan upload ulang bukti pembayaran yang valid melalui sistem. Terima kasih.', 'TERKIRIM', NULL, '2026-03-21 01:40:14'),
(27, 114, '628783073617', 'Azmita Saifani', 'PEMBAYARAN_PENDING', NULL, '. Halo Azmita Saifani, berkas pendaftaran Anda telah DINYATAKAN VALID. Status pendaftaran anda saat ini adalah Menunggu Pembayaran. Pelatihan yang Anda ikuti adalah Pelatihan Pencegahan dan Pengendalian Infeksi (PPI) bagi Tenaga Kesehatan di Fasilitas Kesehatan Tingkat Pertama (FKTP) yang akan dilaksanakan pada tanggal 30 Maret 2026 s.d. 2 April 2026. Biaya pendaftaran pelatihan Anda sebesar Rp 2.500.000. Informasi pembayaran: Bank BNI, No Rekening 3380009008, Atas Nama RSUD PROF DR MARGONO SOEKARJO. Silakan upload bukti pembayaran dengan mengakses link berikut; http://localhost:8080/pelatihanmargono/frontend/uploadpembayaran.html?token=MTE0LjU2NDNhNmNhNjJlMjhiOWRhMDJiODdiMzRmZmQwODZlMjFlYzU5OGE4YmFlOWZjYmRlYWQ2ODljYTQ3ZjRhZDY= Terima kasih', 'TERKIRIM', NULL, '2026-03-21 01:48:59'),
(28, 114, '628783073617', 'Azmita Saifani', 'PEMBAYARAN_PENDING', NULL, '. Halo Azmita Saifani, bukti pembayaran Anda telah berhasil kami terima. Status pendaftaran saat ini adalah Menunggu Verifikasi Pembayaran. Pelatihan: Pelatihan Pencegahan dan Pengendalian Infeksi (PPI) bagi Tenaga Kesehatan di Fasilitas Kesehatan Tingkat Pertama (FKTP) yang akan dilaksanakan pada 30 Maret 2026 s.d. 2 April 2026 di Aula Diklat RSUD Margono. Hasil verifikasi akan kami informasikan melalui WhatsApp atau Email. Terima kasih', 'TERKIRIM', NULL, '2026-03-21 01:50:00'),
(29, 114, '628783073617', 'Azmita Saifani', 'PEMBAYARAN_INVALID', NULL, '. Halo Azmita Saifani, pembayaran Anda belum dapat kami validasi. Status saat ini: Perlu Perbaikan. Pelatihan: Pelatihan Pencegahan dan Pengendalian Infeksi (PPI) bagi Tenaga Kesehatan di Fasilitas Kesehatan Tingkat Pertama (FKTP) (30 Maret 2026 s.d. 2 April 2026) di Aula Diklat RSUD Margono. Silakan upload ulang bukti pembayaran yang valid melalui sistem. Terima kasih.', 'TERKIRIM', NULL, '2026-03-21 01:50:26'),
(30, 108, '6287830736317', 'Azmita Saifani', 'PEMBAYARAN_PENDING', NULL, '. Halo Azmita Saifani, berkas pendaftaran Anda telah DINYATAKAN VALID. Status pendaftaran anda saat ini adalah Menunggu Pembayaran. Pelatihan yang Anda ikuti adalah Pelatihan Pencegahan dan Pengendalian Infeksi (PPI) bagi Tenaga Kesehatan di Fasilitas Kesehatan Tingkat Pertama (FKTP) yang akan dilaksanakan pada tanggal 30 Maret 2026 s.d. 2 April 2026. Biaya pendaftaran pelatihan Anda sebesar Rp 2.500.000. Informasi pembayaran: Bank BNI, No Rekening 3380009008, Atas Nama RSUD PROF DR MARGONO SOEKARJO. Silakan upload bukti pembayaran dengan mengakses link berikut; http://localhost:8080/pelatihanmargono/frontend/uploadpembayaran.html?token=MTA4LmRkZWYwYTlkY2JiNDkzOTUxMDJkMzZkZDY0NzVjMDFkNWRjOGVjYzVjMzMwODE4NmFjMTljNzQ2YjA1ZjRmMDU= Terima kasih', 'TERKIRIM', NULL, '2026-03-25 10:34:43'),
(31, 108, '6287830736317', 'Azmita Saifani', 'PEMBAYARAN_PENDING', NULL, '. Halo Azmita Saifani, bukti pembayaran Anda telah berhasil kami terima. Status pendaftaran saat ini adalah Menunggu Verifikasi Pembayaran. Pelatihan: Pelatihan Pencegahan dan Pengendalian Infeksi (PPI) bagi Tenaga Kesehatan di Fasilitas Kesehatan Tingkat Pertama (FKTP) yang akan dilaksanakan pada 30 Maret 2026 s.d. 2 April 2026 di Aula Diklat RSUD Margono. Hasil verifikasi akan kami informasikan melalui WhatsApp atau Email. Terima kasih', 'TERKIRIM', NULL, '2026-03-25 10:35:46'),
(32, 108, '6287830736317', 'Azmita Saifani', 'PEMBAYARAN_INVALID', NULL, '. Halo Azmita Saifani, pembayaran Anda belum dapat kami validasi. Status saat ini: Perlu Perbaikan. Pelatihan: Pelatihan Pencegahan dan Pengendalian Infeksi (PPI) bagi Tenaga Kesehatan di Fasilitas Kesehatan Tingkat Pertama (FKTP) (30 Maret 2026 s.d. 2 April 2026) di Aula Diklat RSUD Margono. Silakan upload ulang bukti pembayaran yang valid melalui sistem. Terima kasih.', 'TERKIRIM', NULL, '2026-03-25 10:36:00'),
(33, 107, '6287830736317', 'Azmita Saifani', 'BERKAS_VALID', NULL, '. Halo Azmita Saifani, berkas pendaftaran Anda telah DINYATAKAN VALID. Anda resmi diterima pada pelatihan Pelatihan Keperawatan Intensif (ICU) AK 2 Tahun 2025 yang akan dilaksanakan pada 22 Maret 2026 s.d. 24 Maret 2026. Status pendaftaran anda saat ini: Diterima. Terima kasih', 'TERKIRIM', NULL, '2026-03-25 10:42:58'),
(34, 103, '6287830736317', 'Azmita Saifani', 'PEMBAYARAN_PENDING', NULL, '. Halo Azmita Saifani, berkas pendaftaran Anda telah DINYATAKAN VALID. Status pendaftaran anda saat ini adalah Menunggu Pembayaran. Pelatihan yang Anda ikuti adalah percobaan yang akan dilaksanakan pada tanggal 29 Maret 2026 s.d. 2 April 2026. Biaya pendaftaran pelatihan Anda sebesar Rp 1.000.000. Informasi pembayaran: Bank BNI, No Rekening 3380009008, Atas Nama RSUD PROF DR MARGONO SOEKARJO. Silakan upload bukti pembayaran dengan mengakses link berikut; http://localhost:8080/pelatihanmargono/frontend/uploadpembayaran.html?token=MTAzLjMxZDRlMDE4MWI5ZjcxMzUxMzY1Y2IxMDgyN2RmMDM5OGRlYmJmMDIyY2IwOWYwNDlkNTRlNTlkYWY3ZjlkZjY= Terima kasih', 'TERKIRIM', NULL, '2026-03-25 10:43:29'),
(35, 103, '6287830736317', 'Azmita Saifani', 'PEMBAYARAN_PENDING', NULL, '. Halo Azmita Saifani, bukti pembayaran Anda telah berhasil kami terima. Status pendaftaran saat ini adalah Menunggu Verifikasi Pembayaran. Pelatihan: percobaan yang akan dilaksanakan pada 29 Maret 2026 s.d. 2 April 2026 di Aula Diklat RSUD Margono. Hasil verifikasi akan kami informasikan melalui WhatsApp atau Email. Terima kasih', 'TERKIRIM', NULL, '2026-03-25 10:44:01'),
(36, 103, '6287830736317', 'Azmita Saifani', 'PEMBAYARAN_INVALID', NULL, '. Halo Azmita Saifani, pembayaran Anda belum dapat kami validasi. Status saat ini: Verifikasi Pembayaran Invalid. Pelatihan: percobaan (29 Maret 2026 s.d. 2 April 2026) di Aula Diklat RSUD Margono. Silakan upload ulang bukti pembayaran yang valid melalui sistem. Terima kasih.', 'TERKIRIM', NULL, '2026-03-25 10:44:14'),
(37, 102, '6287830736317', 'Azmita Saifani', 'PEMBAYARAN_PENDING', NULL, '. Halo Azmita Saifani, berkas pendaftaran Anda telah DINYATAKAN VALID. Status pendaftaran anda saat ini adalah Menunggu Pembayaran. Pelatihan yang Anda ikuti adalah Pelatihan Pencegahan dan Pengendalian Infeksi (PPI) bagi Tenaga Kesehatan di Fasilitas Kesehatan Tingkat Pertama (FKTP) yang akan dilaksanakan pada tanggal 30 Maret 2026 s.d. 2 April 2026. Biaya pendaftaran pelatihan Anda sebesar Rp 2.500.000. Informasi pembayaran: Bank BNI, No Rekening 3380009008, Atas Nama RSUD PROF DR MARGONO SOEKARJO. Silakan upload bukti pembayaran dengan mengakses link berikut; http://localhost:8080/pelatihanmargono/frontend/uploadpembayaran.html?token=MTAyLjEwNDYwNzI5YzZlZjg5ZTk4ZmU1NGU2NjVkYTM0ZDkyMWEyZWM5YTViZTM1NzQ0Mzg5NmJkNWNjNTRjY2JkMjg= Terima kasih', 'TERKIRIM', NULL, '2026-03-25 11:56:41'),
(38, 102, '6287830736317', 'Azmita Saifani', 'PEMBAYARAN_PENDING', NULL, '. Halo Azmita Saifani, bukti pembayaran Anda telah berhasil kami terima. Status pendaftaran saat ini adalah Menunggu Verifikasi Pembayaran. Pelatihan: Pelatihan Pencegahan dan Pengendalian Infeksi (PPI) bagi Tenaga Kesehatan di Fasilitas Kesehatan Tingkat Pertama (FKTP) yang akan dilaksanakan pada 30 Maret 2026 s.d. 2 April 2026 di Aula Diklat RSUD Margono. Hasil verifikasi akan kami informasikan melalui WhatsApp atau Email. Terima kasih', 'TERKIRIM', NULL, '2026-03-25 11:57:08'),
(39, 92, '6287830736317', 'Azmita Saifani', 'PEMBAYARAN_PENDING', NULL, '. Halo Azmita Saifani, berkas pendaftaran Anda telah DINYATAKAN VALID. Status pendaftaran anda saat ini adalah Menunggu Pembayaran. Pelatihan yang Anda ikuti adalah Pelatihan Dialisis AK 2 Tahun 2025 yang akan dilaksanakan pada tanggal 30 Maret 2026 s.d. 3 April 2026. Biaya pendaftaran pelatihan Anda sebesar Rp 6.000.000. Informasi pembayaran: Bank BNI, No Rekening 3380009008, Atas Nama RSUD PROF DR MARGONO SOEKARJO. Silakan upload bukti pembayaran dengan mengakses link berikut; http://localhost:8080/pelatihanmargono/frontend/uploadpembayaran.html?token=OTIuZGI2ZGNkYzE2YTczNDYyNTQ0YjNlOGY4ZGQyN2RlMGEzMDc1NmIyYmFiNTdjZTIyMDI5ZDYxNmE1MDg4MTQzNw== Terima kasih', 'TERKIRIM', NULL, '2026-03-25 12:00:18'),
(40, 92, '6287830736317', 'Azmita Saifani', 'PEMBAYARAN_PENDING', NULL, '. Halo Azmita Saifani, bukti pembayaran Anda telah berhasil kami terima. Status pendaftaran saat ini adalah Menunggu Verifikasi Pembayaran. Pelatihan: Pelatihan Dialisis AK 2 Tahun 2025 yang akan dilaksanakan pada 30 Maret 2026 s.d. 3 April 2026 di Aula 2. Hasil verifikasi akan kami informasikan melalui WhatsApp atau Email. Terima kasih', 'TERKIRIM', NULL, '2026-03-25 12:00:43'),
(41, 92, '6287830736317', 'Azmita Saifani', 'PEMBAYARAN_INVALID', NULL, '. Halo Azmita Saifani, pembayaran Anda belum dapat kami validasi dikarenakan adanya kesalahan pada bukti pembayaran pelatihan Anda. Status saat ini: Verifikasi Pembayaran Invalid. Pelatihan: Pelatihan Dialisis AK 2 Tahun 2025 (30 Maret 2026 s.d. 3 April 2026) di Aula 2. Silakan upload ulang bukti pembayaran yang valid melalui melalui link berikut: http://localhost:8080/pelatihanmargono/frontend/uploadpembayaran.html?token=OTIuZGI2ZGNkYzE2YTczNDYyNTQ0YjNlOGY4ZGQyN2RlMGEzMDc1NmIyYmFiNTdjZTIyMDI5ZDYxNmE1MDg4MTQzNw==Terima kasih', 'TERKIRIM', NULL, '2026-03-25 12:01:01'),
(42, 92, '6287830736317', 'Azmita Saifani', 'PEMBAYARAN_PENDING', NULL, '. Halo Azmita Saifani, bukti pembayaran Anda telah berhasil kami terima. Status pendaftaran saat ini adalah Menunggu Verifikasi Pembayaran. Pelatihan: Pelatihan Dialisis AK 2 Tahun 2025 yang akan dilaksanakan pada 30 Maret 2026 s.d. 3 April 2026 di Aula 2. Hasil verifikasi akan kami informasikan melalui WhatsApp atau Email. Terima kasih', 'TERKIRIM', NULL, '2026-03-25 12:02:33'),
(43, 92, '6287830736317', 'Azmita Saifani', 'PEMBAYARAN_PENDING', NULL, '. Halo Azmita Saifani, bukti pembayaran Anda telah berhasil kami terima. Status pendaftaran saat ini adalah Menunggu Verifikasi Pembayaran. Pelatihan: Pelatihan Dialisis AK 2 Tahun 2025 yang akan dilaksanakan pada 30 Maret 2026 s.d. 3 April 2026 di Aula 2. Hasil verifikasi akan kami informasikan melalui WhatsApp atau Email. Terima kasih', 'TERKIRIM', NULL, '2026-03-25 12:23:39'),
(44, 102, '6287830736317', 'Azmita Saifani', 'PEMBAYARAN_PENDING', NULL, '. Halo Azmita Saifani, bukti pembayaran Anda telah berhasil kami terima. Status pendaftaran saat ini adalah Menunggu Verifikasi Pembayaran. Pelatihan: Pelatihan Pencegahan dan Pengendalian Infeksi (PPI) bagi Tenaga Kesehatan di Fasilitas Kesehatan Tingkat Pertama (FKTP) yang akan dilaksanakan pada 30 Maret 2026 s.d. 2 April 2026 di Aula Diklat RSUD Margono. Hasil verifikasi akan kami informasikan melalui WhatsApp atau Email. Terima kasih', 'TERKIRIM', NULL, '2026-03-25 12:24:59'),
(45, 102, '6287830736317', 'Azmita Saifani', 'PEMBAYARAN_VALID', NULL, '. Halo Azmita Saifani, pembayaran Anda telah kami terima dan dinyatakan VALID. Status pendaftaran Anda: DITERIMA. Pelatihan: Pelatihan Pencegahan dan Pengendalian Infeksi (PPI) bagi Tenaga Kesehatan di Fasilitas Kesehatan Tingkat Pertama (FKTP) yang akan dilaksanakan pada 30 Maret 2026 s.d. 2 April 2026 di Aula Diklat RSUD Margono. Informasi pelatihan selanjutnya akan kami sampaikan melalui grup pelatihan. Terima kasih', 'TERKIRIM', NULL, '2026-03-25 12:25:18'),
(46, 103, '6287830736317', 'Azmita Saifani', 'PEMBAYARAN_VALID', NULL, '. Halo Azmita Saifani, pembayaran Anda telah kami terima dan dinyatakan VALID. Status pendaftaran Anda: DITERIMA. Pelatihan: percobaan yang akan dilaksanakan pada 29 Maret 2026 s.d. 2 April 2026 di Aula Diklat RSUD Margono. Silakan bergabung ke grup peserta untuk memudahkan koordinasi dan penyampaian informasi pelatihan,: https://chat.whatsapp.com/EWxrvgCjvjA3Ly5b4s810O. Terima kasih', 'TERKIRIM', NULL, '2026-03-25 12:26:35'),
(47, 106, '6287830736317', 'Azmita Saifani', 'BERKAS_INVALID', NULL, '. Halo Azmita Saifani, kami informasikan bahwa berkas pendaftaran Anda dinyatakan BELUM VALID. Pelatihan: Pelatihan Keperawatan Intensif (ICU) AK 2 Tahun 2025 dengan waktu pelaksanaan 22 Maret 2026 s.d. 24 Maret 2026. Silakan melakukan perbaikan berkas sesuai ketentuan yang berlaku dengan melakukan pendaftaran ulang pelatihan di Web Diklat Margono.Informasi lebih lanjut akan disampaikan melalui email dan WhatsApp. Terima kasih', 'TERKIRIM', NULL, '2026-03-25 12:44:58'),
(48, 85, '6287830736317', 'Azmita Saifani', 'BERKAS_INVALID', NULL, '. Halo Azmita Saifani, kami informasikan bahwa berkas pendaftaran Anda dinyatakan BELUM VALID. Pelatihan: Pelatihan Dialisis AK 2 Tahun 2025 dengan waktu pelaksanaan 30 Maret 2026 s.d. 3 April 2026. Silakan melakukan perbaikan berkas sesuai ketentuan yang berlaku dengan melakukan pendaftaran ulang pelatihan di Web Diklat Margono.Informasi lebih lanjut akan disampaikan melalui email dan WhatsApp. Terima kasih', 'TERKIRIM', NULL, '2026-03-25 12:49:54'),
(49, 127, '6287830736317', 'Azmita Saifani', 'BERKAS_PENDING', NULL, '. Halo Azmita Saifani, pendaftaran pelatihan DIKLAT RSUD Prof. Dr. Margono Soekarjo BERHASIL. Pelatihan yang Anda ikuti adalah Pelatihan Dialisis AK 2 Tahun 2025 yang akan dilaksanakan pada 30 Maret 2026 s.d. 3 April 2026.  Status pendaftaran pelatihan Anda saat ini dalam proses verifikasi berkas, untuk informasi selanjutnya harap cek berkala melalui WhatsApp maupun Email secara berkala. Terima kasih', 'TERKIRIM', NULL, '2026-03-25 13:16:36'),
(50, 127, '6287830736317', 'Azmita Saifani', 'BERKAS_INVALID', NULL, '. Halo Azmita Saifani, kami informasikan bahwa berkas pendaftaran Anda dinyatakan BELUM VALID. Pelatihan: Pelatihan Dialisis AK 2 Tahun 2025 dengan waktu pelaksanaan 30 Maret 2026 s.d. 3 April 2026. Silakan melakukan perbaikan berkas sesuai ketentuan yang berlaku dengan melakukan pendaftaran ulang pelatihan di Web Diklat Margono. Informasi lebih lanjut akan disampaikan melalui email dan WhatsApp. Terima kasih', 'TERKIRIM', NULL, '2026-03-25 13:16:53'),
(51, 127, '6287830736317', 'Azmita Saifani', 'BERKAS_PENDING', NULL, '. Halo Azmita Saifani, pendaftaran pelatihan DIKLAT RSUD Prof. Dr. Margono Soekarjo BERHASIL. Pelatihan yang Anda ikuti adalah Pelatihan Dialisis AK 2 Tahun 2025 yang akan dilaksanakan pada 30 Maret 2026 s.d. 3 April 2026.  Status pendaftaran pelatihan Anda saat ini dalam proses verifikasi berkas, untuk informasi selanjutnya harap cek berkala melalui WhatsApp maupun Email secara berkala. Terima kasih', 'TERKIRIM', NULL, '2026-03-25 13:30:20'),
(52, 127, '6287830736317', 'Azmita Saifani', 'BERKAS_INVALID', NULL, '. Halo Azmita Saifani, kami informasikan bahwa berkas pendaftaran Anda dinyatakan BELUM VALID. Pelatihan: Pelatihan Dialisis AK 2 Tahun 2025 dengan waktu pelaksanaan 30 Maret 2026 s.d. 3 April 2026. Silakan melakukan perbaikan berkas sesuai ketentuan yang berlaku dengan melakukan pendaftaran ulang pelatihan di Web Diklat Margono. Informasi lebih lanjut akan disampaikan melalui email dan WhatsApp. Terima kasih', 'TERKIRIM', NULL, '2026-03-25 13:33:48'),
(53, 127, '6287830736317', 'Azmita Saifani', 'BERKAS_PENDING', 'Pendaftaran Berhasil – Menunggu Verifikasi Berkas', '. Halo Azmita Saifani, pendaftaran pelatihan DIKLAT RSUD Prof. Dr. Margono Soekarjo BERHASIL. Pelatihan yang Anda ikuti adalah Pelatihan Dialisis AK 2 Tahun 2025 yang akan dilaksanakan pada 30 Maret 2026 s.d. 3 April 2026.  Status pendaftaran pelatihan Anda saat ini dalam proses verifikasi berkas, untuk informasi selanjutnya harap cek berkala melalui WhatsApp maupun Email secara berkala. Terima kasih', 'TERKIRIM', NULL, '2026-03-25 13:34:57');

-- --------------------------------------------------------

--
-- Table structure for table `pelatihan_tb`
--

CREATE TABLE `pelatihan_tb` (
  `id_pelatihan` int(11) NOT NULL,
  `nama_pelatihan` varchar(150) NOT NULL,
  `jumlah_jpl` int(11) NOT NULL,
  `lokasi` varchar(150) DEFAULT NULL,
  `alamat_lengkap` varchar(255) DEFAULT NULL,
  `tanggal_mulai` date DEFAULT NULL,
  `tanggal_selesai` date DEFAULT NULL,
  `kuota` int(11) DEFAULT NULL,
  `warna` varchar(20) NOT NULL DEFAULT '''#3498db''',
  `harga` decimal(12,2) NOT NULL DEFAULT 0.00,
  `kategori` enum('Nakes','Non Nakes') DEFAULT 'Nakes',
  `kriteria_peserta` varchar(500) NOT NULL,
  `tipe_pelatihan` varchar(100) DEFAULT NULL,
  `durasi` varchar(50) DEFAULT NULL,
  `flyer_url` varchar(255) DEFAULT NULL,
  `status` enum('draft','publish','selesai','batal') DEFAULT 'draft',
  `created_by` int(11) DEFAULT NULL,
  `created_at` datetime DEFAULT current_timestamp(),
  `updated_at` datetime DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `link_grup` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pelatihan_tb`
--

INSERT INTO `pelatihan_tb` (`id_pelatihan`, `nama_pelatihan`, `jumlah_jpl`, `lokasi`, `alamat_lengkap`, `tanggal_mulai`, `tanggal_selesai`, `kuota`, `warna`, `harga`, `kategori`, `kriteria_peserta`, `tipe_pelatihan`, `durasi`, `flyer_url`, `status`, `created_by`, `created_at`, `updated_at`, `link_grup`) VALUES
(17, 'Pelatihan Basic Trauma Cardiac Life Support (BTCLS)', 53, 'Aula Lantai 5', 'RSUD Prof. Dr. Margono Soekarjo', '2026-01-21', '2026-01-27', 25, '#fff700', 1500000.00, 'Nakes', '', 'Offline', '6 Hari', '1766465301764-690087559.png', 'selesai', 1, '2025-12-23 11:48:21', '2026-03-02 13:08:06', ''),
(20, 'Pelatihan Pencegahan dan Pengendalian Infeksi (PPI) bagi Tenaga Kesehatan di Fasilitas Kesehatan Tingkat Pertama (FKTP)', 53, 'Aula Lantai 5', 'RSUD Prof. Dr. Margono Soekarjo', '2026-02-06', '2026-02-12', 30, '#ff94c8', 1500000.00, 'Nakes', 'Dokter/Dokter Gigi atau Perawat/ Bidan atau tenaga kesehatan lainnya pendidikan minimal D3 dengan pengalaman kerja di fasilitas pelayanan kesehatan minimal 2 tahun, diutamakan Kepala FKTP/Penanggung Jawab Mutu/ Penanggung Jawab UKP/ Penanggung Jawab UKM (khusus Puskesmas).', 'Offline', '6 Hari', '1766467863948-331817274.jpg', 'selesai', 1, '2025-12-23 12:31:03', '2026-02-27 14:55:47', 'https://chat.whatsapp.com/EWxrvgCjvjA3Ly5b4s810O'),
(21, 'Pelatihan Pencegahan dan Pengendalian Infeksi (PPI) bagi Tenaga Kesehatan di Fasilitas Kesehatan Tingkat Pertama (FKTP)', 53, 'Aula Diklat RSUD Margono', 'RSUD Prof. Dr. Margono Soekarjo', '2026-03-30', '2026-04-02', 15, '#aad6f3', 2500000.00, 'Nakes', 'Perawat', 'Offline', '', '1769693903652-159450124.png', 'publish', 1, '2026-01-29 20:38:23', '2026-01-29 23:56:16', NULL),
(22, 'Pelatihan BTCLS Angkatan 10 Tahun 2025', 53, 'Aula Diklat RSUD Margono', 'RSUD Prof. Dr. Margono Soekarjo', '2026-02-23', '2026-02-27', 12, '#b2cee1', 2500000.00, 'Nakes', 'Perawat', 'Offline', '', '1769694054228-848301349.jpg', 'batal', 1, '2026-01-29 20:40:54', '2026-02-27 14:59:40', NULL),
(23, 'Pelatihan Keperawatan Intensif (ICU) AK 2 Tahun 2025', 53, 'Aula Diklat RSUD Margono', 'RSUD Prof. Dr. Margono Soekarjo', '2026-03-22', '2026-03-24', 15, '#c28400', 0.00, 'Nakes', 'Perawat', 'Offline', '', '1769694126963-879810154.jpg', 'selesai', 1, '2026-01-29 20:42:06', '2026-03-25 10:18:18', ''),
(24, 'Pelatihan Dialisis AK 2 Tahun 2025', 53, 'Aula Diklat RSUD Margono', 'RSUD Prof. Dr. Margono Soekarjo', '2026-02-23', '2026-02-27', 12, '#3498db', 2500000.00, 'Nakes', 'Mahasiswa', 'Offline', '', '1769694224831-22583156.jpg', 'selesai', 1, '2026-01-29 20:43:44', '2026-03-25 12:26:27', 'https://chat.whatsapp.com/EWxrvgCjvjA3Ly5b4s810O'),
(48, 'percobaan', 10, 'Aula Diklat RSUD Margono', 'RSUD Prof. Dr. Margono Soekarjo', '2026-03-29', '2026-04-02', 30, '#fbff00', 1000000.00, 'Nakes', 'Perawat', 'Online', '', '1773201199880-298585054.jpg', 'publish', 17, '2026-03-11 10:53:19', '2026-03-13 15:34:18', 'https://chat.whatsapp.com/EWxrvgCjvjA3Ly5b4s810O'),
(49, 'Pelatihan Dialisis AK 2 Tahun 2025', 51, 'Aula 2', 'RSUD Prof. Dr. Margono Soekarjo', '2026-03-30', '2026-04-03', 35, '#3498db', 6000000.00, 'Nakes', 'Perawat', '', '', '1773425318759-67739036.jpg', 'publish', 17, '2026-03-14 01:08:38', '2026-03-14 01:08:55', 'https://chat.whatsapp.com/EWxrvgCjvjA3Ly5b4s810O');

-- --------------------------------------------------------

--
-- Table structure for table `pembayaran_tb`
--

CREATE TABLE `pembayaran_tb` (
  `id_pembayaran` int(11) NOT NULL,
  `id_pendaftaran` int(11) NOT NULL,
  `bukti_transfer` varchar(255) DEFAULT NULL,
  `harga` int(11) NOT NULL DEFAULT 0,
  `status` enum('PENDING','VALID','INVALID') DEFAULT 'PENDING',
  `uploaded_at` datetime DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pembayaran_tb`
--

INSERT INTO `pembayaran_tb` (`id_pembayaran`, `id_pendaftaran`, `bukti_transfer`, `harga`, `status`, `uploaded_at`) VALUES
(2, 31, '1766510190799-176142018.png', 0, 'VALID', '2025-12-24 00:16:30'),
(3, 45, '1768041025826-637602097.jpg', 0, 'VALID', '2026-01-10 17:30:25'),
(4, 45, '1768041136166-763965651.jpg', 0, 'VALID', '2026-01-10 17:32:16'),
(5, 45, '1768041188428-540143957.jpg', 0, 'VALID', '2026-01-10 17:33:08'),
(6, 49, '1768151453486-829793659.jpg', 0, 'VALID', '2026-01-12 00:10:53'),
(7, 50, '1768151509581-985923396.jpg', 0, 'VALID', '2026-01-12 00:11:49'),
(9, 47, '1768388276219-269161453.jpg', 0, 'VALID', '2026-01-14 17:57:56'),
(12, 48, '1768388642240-640903002.jpg', 0, 'VALID', '2026-01-14 18:04:02'),
(13, 44, '1768388942523-198932569.jpg', 0, 'VALID', '2026-01-14 18:09:02'),
(14, 51, '1768393469527-510931048.jpg', 0, 'VALID', '2026-01-14 19:24:29'),
(15, 56, '1768394004262-239213420.jpg', 0, 'VALID', '2026-01-14 19:33:24'),
(16, 52, '1768394400264-60633011.jpg', 0, 'VALID', '2026-01-14 19:40:00'),
(23, 57, '1768981270790-363458302.png', 0, 'VALID', '2026-01-21 14:41:10'),
(27, 59, '1768982609056-837760754.png', 0, 'VALID', '2026-01-21 15:03:29'),
(31, 62, '1768998745748-561727423.png', 0, 'VALID', '2026-01-21 19:32:25'),
(32, 55, '1768999308613-980333009.png', 0, 'VALID', '2026-01-21 19:41:48'),
(34, 63, '1771834687741-847448638.jpg', 0, 'VALID', '2026-02-23 15:18:07'),
(35, 63, '1771834748736-116079230.jpg', 0, 'VALID', '2026-02-23 15:19:08'),
(36, 68, '1772421948814-850962540.jpeg', 0, 'VALID', '2026-03-02 10:25:48'),
(37, 69, '1773200222777-238465591.jpeg', 0, 'VALID', '2026-03-11 10:37:02'),
(38, 70, '1773377393079-270221177.jpeg', 0, 'VALID', '2026-03-13 11:49:53'),
(39, 71, '1773378329804-640832389.jpeg', 0, 'VALID', '2026-03-13 12:05:29'),
(40, 71, '1773378946910-744415396.jpeg', 0, 'VALID', '2026-03-13 12:15:46'),
(42, 120, '1774029179556-658765098.jpg', 0, 'VALID', '2026-03-21 00:52:59'),
(43, 118, '1774029796289-125775948.png', 0, 'VALID', '2026-03-21 01:03:16'),
(48, 103, '1774410237215-239813015.jpeg', 0, 'VALID', '2026-03-25 10:43:57'),
(49, 102, '1774416295450-677157114.jpeg', 0, 'VALID', '2026-03-25 12:24:55'),
(50, 92, '1774416215920-871143332.jpeg', 0, 'PENDING', '2026-03-25 12:23:35');

-- --------------------------------------------------------

--
-- Table structure for table `pendaftaran_tb`
--

CREATE TABLE `pendaftaran_tb` (
  `id_pendaftaran` int(11) NOT NULL,
  `id_pelatihan` int(11) NOT NULL,
  `harga_pelatihan` int(11) NOT NULL,
  `nik` varchar(16) NOT NULL,
  `nip` varchar(20) NOT NULL,
  `gelar_depan` varchar(50) DEFAULT NULL,
  `nama_peserta` varchar(100) NOT NULL,
  `gelar_belakang` varchar(50) DEFAULT NULL,
  `asal_instansi` varchar(100) DEFAULT NULL,
  `tempat_lahir` varchar(50) DEFAULT NULL,
  `tanggal_lahir` date DEFAULT NULL,
  `pendidikan` enum('SMA','D1','D2','D3','D4/S1','S2','S3') NOT NULL,
  `jenis_kelamin` enum('Pria','Wanita') NOT NULL,
  `agama` enum('Islam','Kristen Protestan','Kristen Katolik','Hindu','Buddha','Konghucu') DEFAULT NULL,
  `status_pegawai` enum('ASN Kemenkes','ASN Non Kemenkes','Non ASN') DEFAULT NULL,
  `pangkat_golongan` enum('PPPK','PENGATUR-II/c','PENGATUR TINGKAT I-II/d','PENATA MUDA-III/a','PENATA MUDA TINGKAT I-III/b','PENATA-III/c','PENATA TINGKAT I-III/d','PEMBINA-IV/a','PEMBINA TINGKAT I-IV/b','PEMBINA UTAMA MUDA-IV/c','PEMBINA UTAMA MADYA-IV/d','PEMBINA UTAMA-IV/e') DEFAULT NULL,
  `kabupaten_asal` varchar(50) DEFAULT NULL,
  `alamat_kantor` varchar(100) DEFAULT NULL,
  `alamat_rumah` varchar(100) DEFAULT NULL,
  `no_wa` varchar(20) NOT NULL,
  `email` varchar(100) NOT NULL,
  `tanggal_daftar` datetime DEFAULT current_timestamp(),
  `str` varchar(255) DEFAULT NULL,
  `provinsi_asal` varchar(255) DEFAULT NULL,
  `jenis_nakes` varchar(255) DEFAULT NULL,
  `jabatan` enum('Dokter Ahli Madya','Dokter Ahli Muda','Dokter Ahli Pertama','Dokter','Perawat Ahli Madya','Perawat Ahli Muda','Perawat Ahli Pertama','Perawat Penyelia','Perawat Mahir','Perawat Terampil','Perawat','Bidan Ahli Madya','Bidan Ahli Muda','Bidan Ahli Pertama','Bidan Penyelia','Bidan Mahir','Bidan Terampil','Bidan','Nutrisionis Ahli Madya','Nutrisionis Ahli Muda','Nutrisionis Ahli Pertama','Nutrisionis Terampil Penyelia','Nutrisionis Terampil Pelaksana Lanjutan','Nutrisionis Terampil Penyetia','Nutrisionis','Apoteker Ahli Utama','Apoteker Ahli Madya','Apoteker Ahli Muda','Apoteker Ahli Pertama','Apoteker','Lain-lain') DEFAULT NULL,
  `kabupaten_kantor` varchar(255) DEFAULT NULL,
  `provinsi_kantor` varchar(255) DEFAULT NULL,
  `status` varchar(100) NOT NULL DEFAULT 'Menunggu Verifikasi Berkas',
  `surat_tugas` varchar(255) DEFAULT NULL,
  `foto_4x6` varchar(50) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `pendaftaran_tb`
--

INSERT INTO `pendaftaran_tb` (`id_pendaftaran`, `id_pelatihan`, `harga_pelatihan`, `nik`, `nip`, `gelar_depan`, `nama_peserta`, `gelar_belakang`, `asal_instansi`, `tempat_lahir`, `tanggal_lahir`, `pendidikan`, `jenis_kelamin`, `agama`, `status_pegawai`, `pangkat_golongan`, `kabupaten_asal`, `alamat_kantor`, `alamat_rumah`, `no_wa`, `email`, `tanggal_daftar`, `str`, `provinsi_asal`, `jenis_nakes`, `jabatan`, `kabupaten_kantor`, `provinsi_kantor`, `status`, `surat_tugas`, `foto_4x6`, `created_at`, `updated_at`) VALUES
(31, 17, 1500000, '3302275212020001', '2203040407', '', 'ARIKH RATNA P', '', '', 'Banyumas', '1972-09-23', 'S2', 'Pria', 'Islam', NULL, NULL, '', '', '', '082221177745', 'arikhratnapurwadi@gmail.com', '2025-12-24 00:05:11', '', '', 'Lain-lain', NULL, '', '', 'Diterima', NULL, '1766509511226-330892039.jpg', '2025-12-24 00:05:11', '2025-12-24 00:05:11'),
(44, 20, 1500000, '330227521202999', '2203040423', '', 'Saifani A', '', '', 'Banyumas', '1980-07-17', 'D4/S1', 'Wanita', 'Islam', NULL, NULL, '', '', '', '087830736311', 'saifaniazmita@gmail.com', '2026-01-10 16:59:37', '', '', 'Lain-lain', NULL, '', '', 'Diterima', NULL, '1768039177813-742563846.jpg', '2026-01-10 16:59:37', '2026-01-10 16:59:37'),
(45, 20, 1500000, '3302275212020007', '2203040413', '', 'Saifani A', '', '', '', '2001-03-01', 'D4/S1', 'Wanita', 'Islam', NULL, NULL, '', '', '', '0878307363139', 'saifaniazmita@gmail.com', '2026-01-10 17:01:08', '', '', 'Lain-lain', NULL, '', '', 'Diterima', NULL, '1768039268308-45426586.jpg', '2026-01-10 17:01:08', '2026-01-10 17:01:08'),
(47, 20, 1500000, '3302275212020012', '2203040414', '', 'Maemunah Sarif', '', 'UMP', 'Banyumas', '1970-07-08', 'D4/S1', 'Pria', 'Konghucu', NULL, NULL, '', '', '', '08783073691772', 'saifaniazmita@gmail.com', '2026-01-11 21:36:46', '', '', 'Apoteker', NULL, '', '', 'Diterima', '1768142206367-51066987.jpg', '1768142206368-942941926.jpg', '2026-01-11 21:36:46', '2026-01-11 21:36:46'),
(48, 20, 1500000, '330227521202998', '220304042241', '', 'Sultanul Arimaza', '', '', '', '1987-03-11', 'S2', 'Pria', 'Kristen Protestan', NULL, NULL, '', '', '', '0878307363113', 'saifaniazmita@gmail.com', '2026-01-11 21:43:33', '', '', 'Nutrisionis', NULL, '', '', 'Diterima', '1768142613381-954582923.png', '1768142613385-92354834.jpg', '2026-01-11 21:43:33', '2026-01-11 21:43:33'),
(49, 20, 1500000, '3302275212020076', '2203040476', '', 'Saifaniiii', '', '', 'Banyumas', '1990-07-11', 'D3', 'Wanita', 'Konghucu', NULL, NULL, '', '', '', '087830736917743', 'saifaniazmita@gmail.com', '2026-01-11 22:01:32', '', '', 'Lain-lain', NULL, '', '', 'Diterima', NULL, '1768143692552-227735330.jpg', '2026-01-11 22:01:32', '2026-01-11 22:01:32'),
(50, 20, 1500000, '3302275212020069', '2203040469', '', 'Maemunah Sarif', '', '', '', '1998-11-05', 'D4/S1', 'Pria', 'Islam', NULL, NULL, '', '', '', '087830736917766', 'saifaniazmita@gmail.com', '2026-01-12 00:09:08', '', '', 'Apoteker', NULL, '', '', 'Diterima', '1768151348210-648289044.jpg', '1768151348224-793495289.jpg', '2026-01-12 00:09:08', '2026-01-12 00:09:08'),
(51, 20, 1500000, '3302275212020089', '22030404079', '', 'Saifani Aweawe', '', 'UMP', 'Banyumas', '1980-07-09', 'D4/S1', 'Wanita', 'Islam', NULL, NULL, '', '', '', '087830736917767', 'saifaniazmita@gmail.com', '2026-01-14 18:16:53', '', '', 'Lain-lain', NULL, '', '', 'Diterima', '1768389413227-696975565.jpg', '1768389413233-404216159.jpg', '2026-01-14 18:16:53', '2026-01-14 18:16:53'),
(52, 20, 1500000, '3302275212020021', '2203040412', '', 'Maemunah Sarif', '', '', 'Banyumas', '1983-06-30', 'S2', 'Pria', 'Kristen Protestan', NULL, NULL, '', '', '', '087830736917761', 'saifaniazmita@gmail.com', '2026-01-14 18:27:34', '', '', 'Nutrisionis', NULL, '', '', 'Diterima', '1768390054061-313965683.jpg', '1768390054069-843375522.jpg', '2026-01-14 18:27:34', '2026-01-14 18:27:34'),
(55, 20, 1500000, '3302275212020739', '22030404541', '', 'Azmita', '', 'UMP', 'Banyumas', '1989-03-02', 'D3', 'Wanita', 'Kristen Protestan', NULL, NULL, '', '', '', '0822211772121', 'saifaniazmita@gmail.com', '2026-01-14 18:46:40', '', '', 'Perawat', NULL, '', '', 'Diterima', '1768391200193-572847446.jpg', '1768391200203-155528172.jpg', '2026-01-14 18:46:40', '2026-01-14 18:46:40'),
(56, 20, 1500000, '3302272121212122', '2203732819', '', 'Azmitassdadada', '', '', '', '1991-03-04', 'D3', 'Pria', 'Kristen Katolik', NULL, NULL, '', '', '', '087832112121', 'saifaniazmita@gmail.com', '2026-01-14 18:59:23', '', '', 'Bidan', NULL, '', '', 'Diterima', '1768391963928-363761656.jpg', '1768391963936-872958304.jpg', '2026-01-14 18:59:23', '2026-01-14 18:59:23'),
(57, 20, 1500000, '3302275212021212', '22030465431', '', 'Azmitas', '', '', '', '1985-07-18', 'D4/S1', 'Wanita', 'Islam', NULL, NULL, '', '', '', '087830736921212', 'saifaniazmita@gmail.com', '2026-01-21 14:37:29', '', '', 'Bidan', NULL, '', '', 'Diterima', '1768981049151-297743392.png', '1768981049169-161246566.png', '2026-01-21 14:37:29', '2026-01-21 14:37:29'),
(58, 20, 1500000, '33022752120201', '22030434343', '', 'Azmita', '', '', 'Banyumas', '1987-07-09', 'D4/S1', 'Wanita', 'Kristen Katolik', NULL, NULL, '', '', '', '0878307787878', 'saifaniazmita@gmail.com', '2026-01-21 14:54:08', '', '', 'Bidan', NULL, '', '', 'Diterima', '1768982048297-508669736.png', '1768982048315-83071528.png', '2026-01-21 14:54:08', '2026-01-21 14:54:08'),
(59, 20, 1500000, '3302275212020000', '220307790800', '', 'Azmita', '', 'UMP', '', '1986-07-09', 'D4/S1', 'Wanita', 'Kristen Protestan', NULL, NULL, '', '', '', '0822215323597', 'saifaniazmita@gmail.com', '2026-01-21 15:02:46', '', '', 'Perawat', NULL, '', '', 'Diterima', '1768982566912-264827574.png', '1768982566922-22415984.png', '2026-01-21 15:02:46', '2026-01-21 15:02:46'),
(61, 20, 1500000, '330227521287658', '2203063456', '', 'Azmita', '', 'UMP', 'Banyumas', '1994-07-21', 'D4/S1', 'Wanita', 'Kristen Protestan', NULL, NULL, '', '', '', '087838089654', 'saifaniazmita@gmail.com', '2026-01-21 15:10:28', '', '', 'Perawat', NULL, '', '', 'Diterima', '1768983028351-788124835.png', '1768983028364-388457350.png', '2026-01-21 15:10:28', '2026-01-21 15:10:28'),
(62, 20, 1500000, '330227521279878', '220356758769', '', 'Saifani ', '', '', 'Banyumas', '1992-11-19', 'SMA', 'Pria', 'Islam', NULL, NULL, '', '', '', '087830736787909', 'saifaniazmita@gmail.com', '2026-01-21 19:30:33', '', '', 'Nutrisionis', NULL, '', '', 'Diterima', '1768998633141-269353167.png', '1768998633152-925303290.png', '2026-01-21 19:30:33', '2026-01-21 19:30:33'),
(63, 20, 1500000, '3302275212321312', '220304040731321313', '', 'Azmita', '', 'UMP', '', '1984-07-11', 'SMA', 'Wanita', 'Kristen Katolik', NULL, NULL, '', '', '', '087830732113131', 'saifaniazmita@gmail.com', '2026-01-23 22:25:57', '', '', 'Perawat', NULL, '', '', 'Diterima', '1769181957184-600745160.jpg', '1769181957189-157914413.jpg', '2026-01-23 22:25:57', '2026-01-23 22:25:57'),
(64, 22, 2500000, '1122334455667788', '112233445566', '', 'azmitmit', '', '', 'Banyumas', '1997-07-04', 'D4/S1', 'Wanita', 'Islam', 'ASN Kemenkes', 'PENATA MUDA-III/a', '', '', '', '087832222222', 'saifaniazmita@gmail.com', '2026-02-15 18:06:04', '', '', 'Bidan', 'Bidan Ahli Madya', '', '', 'Diterima', '1771153564448-529544305.jpg', '1771153564469-498946695.jpg', '2026-02-15 18:06:04', '2026-02-15 18:06:04'),
(68, 23, 0, '3302275545423225', '220304040764252345', '', 'galihhh', 's.kom', 'Margono', 'Banyumas', '2026-03-01', 'D4/S1', 'Pria', 'Islam', 'Non ASN', NULL, 'Purworejo', 'banyumas', 'purworejo', '087830736954353', 'galihdwia007@gmail.com', '2026-03-02 10:03:46', '', 'Jateng', 'Lain-lain', 'Lain-lain', 'Banyumas', 'hfghf', 'Diterima', '1772420626246-467662011.jpeg', '1772420626253-338558646.jpeg', '2026-03-02 10:03:46', '2026-03-02 10:03:46'),
(69, 21, 2500000, '3302275216548530', '220346585316421354', '', 'AZMITAAA', 's.kom', 'UMP', 'Banyumas', '2006-01-31', 'SMA', 'Wanita', 'Islam', 'Non ASN', NULL, 'Purworejo', '', 'purworejo', '087830732134568', 'saifaniazmita@gmail.com', '2026-03-11 10:35:16', '', 'Jateng', 'Lain-lain', 'Lain-lain', '', '', 'Diterima', '1773200116722-315447194.jpeg', '1773200116727-189696369.jpeg', '2026-03-11 10:35:16', '2026-03-11 10:35:16'),
(70, 48, 1000000, '3302275212043125', '220304325678909876', '', 'AZMIT', 's.kom', 'UMP', 'Banyumas', '2005-06-07', 'SMA', 'Pria', 'Islam', 'ASN Kemenkes', 'PEMBINA UTAMA-IV/e', 'Purworejo', 'banyumas', 'purworejo', '082223246575687', 'saifaniazmita@gmail.com', '2026-03-13 01:13:17', '', 'Jateng', 'Lain-lain', 'Lain-lain', 'Banyumas', 'hfghf', 'Menunggu Pembayaran', NULL, '1773339197717-969751507.jpeg', '2026-03-13 01:13:17', '2026-03-13 01:13:17'),
(71, 23, 0, '3124343544533345', '220304040734544313', '', 'azmi', 's.kom', 'UMP', 'Banyumas', '1993-07-07', 'D4/S1', 'Pria', 'Islam', 'ASN Kemenkes', 'PENGATUR TINGKAT I-II/d', 'Purworejo', 'banyumas', 'purworejo', '0878307363139', 'saifaniazmita@gmail.com', '2026-03-13 12:01:55', '', 'Jateng', 'Perawat', 'Perawat Terampil', '', 'hfghf', 'Diterima', NULL, '1773378115893-622793367.jpeg', '2026-03-13 12:01:55', '2026-03-13 12:01:55'),
(72, 48, 1000000, '2203040113333333', '220304011333333333', '', 'Azmita Saifani', 's.kom', 'UMP', 'Banyumas', '1974-03-07', 'D4/S1', 'Wanita', 'Islam', 'Non ASN', NULL, 'Purworejo', 'banyumas', 'purworejo', '087830736317', 'saifaniazmita@gmail.com', '2026-03-13 14:58:10', '', 'Jateng', 'Lain-lain', 'Lain-lain', 'Banyumas', '', 'Menunggu Verifikasi Berkas', NULL, '1773388690322-231495394.jpg', '2026-03-13 14:58:10', '2026-03-13 14:58:10'),
(73, 48, 1000000, '3302275213657689', '220304040734567899', '', 'Azmita Saifani', 's.kom', 'UMP', 'Banyumas', '2003-12-12', 'SMA', 'Wanita', 'Islam', 'Non ASN', NULL, 'Purworejo', 'banyumas', 'purworejo', '087830736317', 'saifaniazmita@gmail.com', '2026-03-13 15:04:36', '', 'Jateng', 'Lain-lain', 'Lain-lain', '', '', 'Menunggu Verifikasi Berkas', NULL, '1773389076410-118294747.jpg', '2026-03-13 15:04:36', '2026-03-13 15:04:36'),
(74, 48, 1000000, '3302275210987654', '220304040709876543', '', 'Azmita Saifani', '', 'UMP', 'Banyumas', '2003-12-20', 'D4/S1', 'Wanita', 'Kristen Katolik', 'ASN Kemenkes', 'PENGATUR-II/c', 'Purworejo', 'banyumas', 'purworejo', '087830736317', 'saifaniazmita@gmail.com', '2026-03-13 15:08:44', '', 'Jateng', 'Lain-lain', 'Lain-lain', '', '', 'Menunggu Verifikasi Berkas', NULL, '1773389324134-269623415.jpg', '2026-03-13 15:08:44', '2026-03-13 15:08:44'),
(75, 48, 1000000, '3302278987654345', '220304040709877890', '', 'Azmita Saifani', 's.kom', 'UMP', 'Banyumas', '2001-07-11', 'D3', 'Wanita', 'Kristen Katolik', 'Non ASN', NULL, 'Purworejo', 'banyumas', 'purworejo', '087830736317', 'saifaniazmita@gmail.com', '2026-03-13 15:13:06', '', 'Jateng', 'Lain-lain', 'Lain-lain', '', '', 'Menunggu Verifikasi Berkas', NULL, '1773389586436-245481997.jpg', '2026-03-13 15:13:06', '2026-03-13 15:13:06'),
(76, 48, 1000000, '3302275212025344', '220304040776353656', '', 'Azmita Saifani', '', '', 'Banyumas', '2000-07-06', 'D4/S1', 'Wanita', 'Islam', 'Non ASN', NULL, '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-13 15:16:14', '', '', 'Lain-lain', 'Lain-lain', '', '', 'Menunggu Verifikasi Berkas', NULL, '1773389774475-139998381.jpg', '2026-03-13 15:16:14', '2026-03-13 15:16:14'),
(77, 48, 1000000, '5472564153657687', '220304040767359870', '', 'Azmita Saifani', '', 'UMP', 'Banyumas', '2001-11-14', 'D4/S1', 'Wanita', 'Kristen Protestan', 'Non ASN', NULL, '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-13 15:18:54', '', '', 'Lain-lain', 'Lain-lain', '', '', 'Menunggu Verifikasi Berkas', NULL, '1773389934914-127320637.jpg', '2026-03-13 15:18:54', '2026-03-13 15:18:54'),
(78, 48, 1000000, '5267895428795670', '220304040759678242', '', 'Wahyu', '', '', 'Banyumas', '2008-03-06', 'D4/S1', 'Pria', 'Islam', 'Non ASN', NULL, '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-13 15:20:59', '', '', 'Lain-lain', 'Lain-lain', '', '', 'Menunggu Verifikasi Berkas', NULL, '1773390059679-887690840.jpg', '2026-03-13 15:20:59', '2026-03-13 15:20:59'),
(79, 48, 1000000, '7685756534352354', '220304040796878574', '', 'Azmita Saifani', '', '', 'Banyumas', '2000-07-13', 'D4/S1', 'Pria', 'Islam', 'Non ASN', NULL, '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-13 15:25:07', '', '', 'Lain-lain', 'Lain-lain', '', '', 'Menunggu Verifikasi Berkas', NULL, '1773390307136-979014584.jpg', '2026-03-13 15:25:07', '2026-03-13 15:25:07'),
(80, 48, 1000000, '7822759852987235', '220304040929478927', '', 'Azmita Saifani', '', '', '', '1999-06-25', 'D4/S1', 'Wanita', 'Islam', 'Non ASN', NULL, '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-13 15:29:42', '', '', 'Lain-lain', 'Lain-lain', '', '', 'Menunggu Verifikasi Berkas', NULL, '1773390582774-229147538.jpg', '2026-03-13 15:29:42', '2026-03-13 15:29:42'),
(81, 21, 2500000, '3302275342453000', '224325489908740407', '', 'Azmita Saifani', '', '', '', '2009-11-18', 'D4/S1', 'Wanita', 'Islam', 'Non ASN', NULL, '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-13 15:32:27', '', '', 'Lain-lain', 'Lain-lain', '', '', 'Menunggu Verifikasi Berkas', NULL, '1773390747724-155839912.jpg', '2026-03-13 15:32:27', '2026-03-13 15:32:27'),
(82, 48, 1000000, '6753523643643324', '220304040725648457', '', 'Azmita Saifani', '', '', '', '2007-07-13', 'D4/S1', 'Wanita', 'Islam', 'Non ASN', NULL, '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-13 15:35:17', '', '', 'Lain-lain', 'Lain-lain', '', '', 'Menunggu Verifikasi Berkas', NULL, '1773390917281-374647165.jpg', '2026-03-13 15:35:17', '2026-03-13 15:35:17'),
(83, 48, 1000000, '3302275654353650', '564345653474647446', '', 'Azmita Saifani', '', '', 'Banyumas', '1997-07-09', 'D4/S1', 'Wanita', 'Islam', 'Non ASN', NULL, '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-13 15:36:30', '', '', 'Lain-lain', 'Lain-lain', '', '', 'Menunggu Verifikasi Berkas', NULL, '1773390990695-172956970.jpg', '2026-03-13 15:36:30', '2026-03-13 15:36:30'),
(84, 48, 1000000, '4532654765876986', '220304040742543785', '', 'Azmita Saifani', '', '', '', '2008-03-19', 'D3', 'Pria', 'Konghucu', 'Non ASN', NULL, '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-14 00:04:35', '', '', 'Dokter', 'Dokter Ahli Madya', '', '', 'Menunggu Verifikasi Berkas', NULL, '1773421475318-228341420.jpg', '2026-03-14 00:04:35', '2026-03-14 00:04:35'),
(86, 49, 6000000, '6436487980976985', '657658769858754763', '', 'Azmita Saifani', '', '', '', '2004-02-10', 'D4/S1', 'Pria', 'Islam', 'ASN Kemenkes', 'PEMBINA UTAMA-IV/e', '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-14 01:15:58', '', '', 'Dokter', 'Dokter Ahli Madya', '', '', 'Menunggu Verifikasi Berkas', NULL, '1773425758233-602935356.png', '2026-03-14 01:15:58', '2026-03-14 01:15:58'),
(87, 49, 6000000, '3215676879098765', '321567687909876543', '', 'Azmita Saifani', '', '', 'Banyumas', '2001-07-10', 'D4/S1', 'Wanita', 'Islam', 'ASN Kemenkes', 'PPPK', '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-14 01:18:45', '', '', 'Dokter', 'Dokter Ahli Madya', '', '', 'Menunggu Verifikasi Berkas', NULL, '1773425925860-66346077.jpg', '2026-03-14 01:18:45', '2026-03-14 01:18:45'),
(88, 49, 6000000, '6873652455465758', '687365245546575834', '', 'Azmita Saifani', '', '', 'Banyumas', '2001-07-14', 'SMA', 'Wanita', 'Islam', 'ASN Kemenkes', 'PEMBINA UTAMA MADYA-IV/d', '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-14 01:23:00', '', '', 'Dokter', 'Dokter Ahli Madya', '', '', 'Menunggu Verifikasi Berkas', NULL, '1773426180687-451942871.jpg', '2026-03-14 01:23:00', '2026-03-14 01:23:00'),
(89, 49, 6000000, '2203040407768920', '220304040776892075', '', 'Azmita Saifani', '', '', '', '1991-03-14', 'D4/S1', 'Wanita', 'Islam', 'ASN Kemenkes', 'PEMBINA UTAMA-IV/e', '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-14 01:25:25', '', '', 'Dokter', 'Dokter Ahli Madya', '', '', 'Menunggu Verifikasi Berkas', NULL, '1773426325397-42611382.jpg', '2026-03-14 01:25:25', '2026-03-14 01:25:25'),
(90, 49, 6000000, '6782904892748763', '678290489274876309', '', 'Azmita Saifani', '', '', '', '2000-03-14', 'D3', 'Wanita', 'Islam', 'ASN Kemenkes', 'PEMBINA UTAMA-IV/e', '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-14 01:27:51', '', '', 'Bidan', 'Bidan Penyelia', '', '', 'Menunggu Verifikasi Berkas', NULL, '1773426471071-494708207.jpg', '2026-03-14 01:27:51', '2026-03-14 01:27:51'),
(91, 49, 6000000, '2203040407765328', '220304040776532895', '', 'Azmita Saifani', '', '', 'Banyumas', '2006-07-06', 'D4/S1', 'Wanita', 'Islam', 'ASN Non Kemenkes', 'PEMBINA UTAMA-IV/e', '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-14 01:32:39', '', '', 'Apoteker', 'Apoteker Ahli Utama', '', '', 'Menunggu Verifikasi Berkas', NULL, '1773426759385-695428923.png', '2026-03-14 01:32:39', '2026-03-14 01:32:39'),
(92, 49, 6000000, '8428578197589798', '842857819758979878', '', 'Azmita Saifani', '', 'UMP', '', '1998-07-14', 'D4/S1', 'Wanita', 'Islam', 'ASN Non Kemenkes', 'PEMBINA UTAMA-IV/e', '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-14 01:35:43', '', '', 'Dokter', 'Dokter Ahli Madya', '', '', 'Verifikasi Pembayaran Invalid', NULL, '1773426943864-713692991.png', '2026-03-14 01:35:43', '2026-03-14 01:35:43'),
(93, 23, 0, '2203040407598543', '220304040759854345', '', 'Azmita Saifani', '', 'UMP', 'Banyumas', '2009-03-04', 'D4/S1', 'Wanita', 'Islam', 'Non ASN', NULL, '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-17 15:46:16', '', '', 'Perawat', 'Perawat Ahli Madya', '', '', 'Menunggu Verifikasi Berkas', NULL, '1773737176364-897587106.jpg', '2026-03-17 15:46:16', '2026-03-17 15:46:16'),
(94, 23, 0, '2203040407629078', '220304040762907835', '', 'Azmita Saifani', '', '', 'Banyumas', '1991-02-27', 'D4/S1', 'Wanita', 'Islam', 'ASN Kemenkes', 'PEMBINA UTAMA-IV/e', '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-17 15:50:04', '', '', 'Dokter', 'Dokter Ahli Madya', '', '', 'Menunggu Verifikasi Berkas', NULL, '1773737404119-911853895.png', '2026-03-17 15:50:04', '2026-03-17 15:50:04'),
(95, 23, 0, '2203040409457890', '220304040945789015', '', 'mira', '', '', 'Banyumas', '2005-03-17', 'D4/S1', 'Wanita', 'Islam', 'ASN Kemenkes', 'PENATA TINGKAT I-III/d', '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-17 15:51:48', '', '', 'Dokter', 'Dokter Ahli Madya', '', '', 'Menunggu Verifikasi Berkas', NULL, '1773737508735-398622329.jpg', '2026-03-17 15:51:48', '2026-03-17 15:51:48'),
(96, 23, 0, '2203040401154897', '220304040115489703', '', 'Azmita Saifani', '', '', 'Banyumas', '1999-07-14', 'SMA', 'Pria', 'Islam', 'ASN Non Kemenkes', 'PEMBINA UTAMA MUDA-IV/c', '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-17 15:55:43', '', '', 'Perawat', 'Perawat Ahli Pertama', '', '', 'Menunggu Verifikasi Berkas', NULL, '1773737743312-463733609.jpg', '2026-03-17 15:55:43', '2026-03-17 15:55:43'),
(97, 23, 0, '2203040423832915', '220304042383291560', '', 'Azmita Saifani', '', '', 'Banyumas', '1994-07-07', 'SMA', 'Wanita', 'Islam', 'ASN Non Kemenkes', 'PENATA TINGKAT I-III/d', '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-17 16:02:25', '', '', 'Dokter', 'Dokter Ahli Madya', '', '', 'Menunggu Verifikasi Berkas', NULL, '1773738145302-752952075.png', '2026-03-17 16:02:25', '2026-03-17 16:02:25'),
(98, 23, 0, '2203040459048624', '220304045904862480', '', 'Azmita Saifani', '', '', 'Banyumas', '1998-07-09', 'SMA', 'Pria', 'Kristen Katolik', 'ASN Non Kemenkes', 'PEMBINA UTAMA-IV/e', '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-17 16:06:21', '', '', 'Perawat', 'Perawat Terampil', '', '', 'Menunggu Verifikasi Berkas', NULL, '1773738381957-905649054.jpg', '2026-03-17 16:06:21', '2026-03-17 16:06:21'),
(99, 23, 0, '2203040403000512', '220304040300051258', '', 'Azmita Saifani', '', '', 'Banyumas', '1995-07-06', 'D1', 'Pria', 'Kristen Protestan', 'ASN Non Kemenkes', 'PENGATUR TINGKAT I-II/d', '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-17 16:12:01', '', '', 'Perawat', 'Perawat', '', '', 'Menunggu Verifikasi Berkas', NULL, '1773738721926-103580582.jpg', '2026-03-17 16:12:01', '2026-03-17 16:12:01'),
(100, 23, 0, '2203040401988521', '220304040198852168', '', 'Azmita Saifani', '', '', '', '2008-07-10', 'SMA', 'Wanita', 'Kristen Protestan', 'ASN Non Kemenkes', 'PENATA-III/c', '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-17 16:15:19', '', '', 'Perawat', 'Perawat Ahli Pertama', '', '', 'Menunggu Verifikasi Berkas', NULL, '1773738919481-704779529.png', '2026-03-17 16:15:19', '2026-03-17 16:15:19'),
(101, 23, 0, '3302275212021410', '330227521202141053', '', 'Azmita Saifani', '', '', '', '1993-07-15', 'D4/S1', 'Wanita', 'Islam', 'ASN Kemenkes', 'PEMBINA UTAMA MADYA-IV/d', '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-17 16:20:05', '', '', 'Dokter', 'Dokter Ahli Madya', '', '', 'Menunggu Verifikasi Berkas', NULL, '1773739205670-486314731.png', '2026-03-17 16:20:05', '2026-03-17 16:20:05'),
(102, 21, 2500000, '2203040401678356', '220304040167835628', '', 'Azmita Saifani', '', '', '', '2010-11-17', 'D3', 'Wanita', 'Kristen Protestan', 'ASN Non Kemenkes', 'PEMBINA TINGKAT I-IV/b', '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-17 16:21:53', '', '', 'Perawat', 'Perawat Ahli Madya', '', '', 'Diterima', NULL, '1773739313875-115931838.png', '2026-03-17 16:21:53', '2026-03-17 16:21:53'),
(103, 48, 1000000, '8391205680375822', '839120568037582210', '', 'Azmita Saifani', '', '', '', '1991-07-25', 'D4/S1', 'Wanita', 'Kristen Protestan', 'ASN Non Kemenkes', 'PENATA-III/c', '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-17 16:27:34', '', '', 'Bidan', 'Bidan Penyelia', '', '', 'Diterima', NULL, '1773739654309-731333750.png', '2026-03-17 16:27:34', '2026-03-17 16:27:34'),
(105, 23, 0, '2203040403085479', '220304040308547921', '', 'Azmita Saifani', '', '', '', '1992-07-09', 'D4/S1', 'Wanita', 'Kristen Protestan', 'ASN Non Kemenkes', 'PENATA MUDA-III/a', '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-17 16:29:01', '', '', 'Perawat', 'Perawat Penyelia', '', '', 'Menunggu Verifikasi Berkas', NULL, '1773739741839-827247153.png', '2026-03-17 16:29:01', '2026-03-17 16:29:01'),
(107, 23, 0, '1234456479944440', '123445647994444034', '', 'Azmita Saifani', '', '', '', '1992-06-17', 'D4/S1', 'Wanita', 'Islam', 'ASN Non Kemenkes', 'PEMBINA UTAMA MADYA-IV/d', '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-17 16:41:09', '', '', 'Bidan', 'Bidan Ahli Pertama', '', '', 'Diterima', NULL, '1773740469131-152460136.jpg', '2026-03-17 16:41:09', '2026-03-17 16:41:09'),
(109, 23, 0, '2203040407456789', '220304040745678911', '', 'Azmita Saifani', '', '', '', '2001-07-12', 'D3', 'Pria', 'Islam', 'ASN Non Kemenkes', 'PEMBINA UTAMA-IV/e', '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-17 20:11:39', '', '', 'Dokter', 'Dokter Ahli Madya', '', '', 'Diterima', NULL, '1773753099011-70851236.jpg', '2026-03-17 20:11:39', '2026-03-17 20:11:39'),
(118, 49, 6000000, '2203040407456731', '220304040745673131', '', 'Azmita Saifani', '', '', '', '1994-07-13', 'SMA', 'Pria', 'Islam', 'ASN Kemenkes', 'PPPK', '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-17 20:49:37', '', '', 'Dokter', 'Dokter Ahli Madya', '', '', 'Diterima', NULL, '1773755377324-805848254.jpg', '2026-03-17 20:49:37', '2026-03-17 20:49:37'),
(119, 21, 2500000, '2203044545454521', '220304454545452132', '', 'Azmita Saifani', '', '', '', '1997-06-17', 'D4/S1', 'Wanita', 'Kristen Protestan', 'ASN Kemenkes', 'PENGATUR-II/c', '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-17 20:51:40', '', '', 'Dokter', 'Dokter Ahli Muda', '', '', 'Verifikasi Pembayaran Invalid', NULL, '1773755500620-810865783.jpg', '2026-03-17 20:51:40', '2026-03-17 20:51:40'),
(120, 21, 2500000, '2203089236581321', '220308923658132132', '', 'Azmita Saifani', '', '', '', '2002-07-17', 'D4/S1', 'Wanita', 'Islam', 'ASN Kemenkes', 'PEMBINA UTAMA-IV/e', '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-17 22:49:56', '', '', 'Dokter', 'Dokter Ahli Madya', '', '', 'Diterima', NULL, '1773762596681-734573108.jpg', '2026-03-17 22:49:56', '2026-03-17 22:49:56'),
(121, 21, 2500000, '2203041111321321', '220304111132132132', '', 'Azmita Saifani', '', '', '', '1992-06-17', 'SMA', 'Wanita', 'Islam', 'ASN Kemenkes', 'PENGATUR TINGKAT I-II/d', '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-17 23:01:17', '', '', 'Dokter', 'Dokter Ahli Madya', '', '', 'Menunggu Pembayaran', NULL, '1773763277141-545163968.png', '2026-03-17 23:01:17', '2026-03-17 23:01:17'),
(122, 21, 2500000, '2200000000321321', '220000000032132132', '', 'Azmita Saifani', '', '', '', '1996-07-11', 'D4/S1', 'Pria', 'Islam', 'ASN Non Kemenkes', 'PENATA-III/c', '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-17 23:04:49', '', '', 'Bidan', 'Bidan Mahir', '', '', 'Menunggu Pembayaran', NULL, '1773763489481-990794260.jpg', '2026-03-17 23:04:49', '2026-03-17 23:04:49'),
(123, 21, 2500000, '2000004073213213', '200000407321321324', '', 'Azmita Saifani', '', '', '', '1999-07-14', 'D4/S1', 'Wanita', 'Kristen Protestan', 'ASN Non Kemenkes', 'PEMBINA UTAMA MADYA-IV/d', '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-17 23:07:57', '', '', 'Bidan', 'Bidan Ahli Pertama', '', '', 'Menunggu Pembayaran', NULL, '1773763677008-358120085.jpg', '2026-03-17 23:07:57', '2026-03-17 23:07:57'),
(124, 21, 2500000, '2203040099921321', '220304009992132132', '', 'Azmita Saifani', '', '', '', '2004-06-17', 'D2', 'Pria', 'Kristen Protestan', 'ASN Kemenkes', 'PEMBINA UTAMA-IV/e', '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-17 23:12:58', '', '', 'Dokter', 'Dokter Ahli Madya', '', '', 'Menunggu Pembayaran', NULL, '1773763978727-47794553.jpg', '2026-03-17 23:12:58', '2026-03-17 23:12:58'),
(125, 49, 6000000, '2203040405555555', '220304040555555532', '', 'Azmita Saifani', '', '', 'Banyumas', '1993-07-15', 'D4/S1', 'Wanita', 'Islam', 'ASN Non Kemenkes', 'PEMBINA UTAMA-IV/e', '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-17 23:26:05', '', '', 'Nutrisionis', 'Nutrisionis Ahli Muda', '', '', 'Menunggu Pembayaran', NULL, '1773764765311-630112125.jpg', '2026-03-17 23:26:05', '2026-03-17 23:26:05'),
(126, 49, 6000000, '2203333333321321', '220333333332132132', '', 'Azmita Saifani', '', '', '', '1996-07-10', 'D3', 'Wanita', 'Islam', 'ASN Non Kemenkes', 'PPPK', '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-21 00:00:29', '', '', 'Dokter', 'Dokter Ahli Madya', '', '', 'Menunggu Pembayaran', '1774026029905-819108505.jpg', '1774026029908-208102918.jpg', '2026-03-21 00:00:29', '2026-03-21 00:00:29'),
(127, 49, 6000000, '8666666661546573', '220304666666622567', '', 'Azmita Saifani', '', '', '', '1993-07-15', 'D4/S1', 'Wanita', 'Islam', 'ASN Kemenkes', 'PEMBINA UTAMA MUDA-IV/c', '', '', '', '087830736317', 'saifaniazmita@gmail.com', '2026-03-25 13:16:32', '', '', 'Dokter', 'Dokter Ahli Madya', '', '', 'Menunggu Verifikasi Berkas', NULL, '1774420493618-363258347.jpeg', '2026-03-25 13:16:32', '2026-03-25 13:16:32');

-- --------------------------------------------------------

--
-- Table structure for table `penyelenggara_tb`
--

CREATE TABLE `penyelenggara_tb` (
  `id_penyelenggara` int(10) UNSIGNED NOT NULL,
  `nama` varchar(150) NOT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `keterangan` text DEFAULT NULL,
  `author` varchar(100) NOT NULL DEFAULT 'admin',
  `status` enum('0','1') NOT NULL DEFAULT '1',
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `penyelenggara_tb`
--

INSERT INTO `penyelenggara_tb` (`id_penyelenggara`, `nama`, `foto`, `keterangan`, `author`, `status`, `created_at`, `updated_at`) VALUES
(1, 'BETA SUGIARSO, M.Kep.Ns', '1768882164585-446634218.jpg', 'Pengendali Pelatihan', 'admin', '1', '2026-01-20 11:09:24', '2026-01-20 11:09:24'),
(4, 'ENDAH EKAWATI, M.Kep,Ns.,Kep.Mat', '1769697055680-891739229.jpg', 'Pengendali Pelatihan', 'admin', '1', '2026-01-29 21:30:55', '2026-01-29 21:30:55'),
(5, 'NUR INDARWATI SEPTIRIANA, S. Kep, Ners', '1769697085026-843971262.jpg', 'Pengendali Pelatihan', 'admin', '1', '2026-01-29 21:31:25', '2026-01-29 21:31:25'),
(6, 'TRIYANTO, S.Kep.Ns', '1769697110397-828979004.jpg', 'Pengendali Pelatihan', 'admin', '1', '2026-01-29 21:31:50', '2026-01-29 21:31:50'),
(7, 'SULISTIANINGSIH', '1769859827361-818901307.jpeg', 'Pengendali Pelatihan', 'admin', '1', '2026-01-31 18:43:47', '2026-01-31 18:44:56');

-- --------------------------------------------------------

--
-- Table structure for table `sertifikat_akreditasi`
--

CREATE TABLE `sertifikat_akreditasi` (
  `id` int(11) NOT NULL,
  `histori_akreditasi_id` int(11) NOT NULL,
  `file_name` varchar(255) DEFAULT NULL,
  `file_path` varchar(255) DEFAULT NULL,
  `keterangan` varchar(255) DEFAULT NULL,
  `uploaded_at` timestamp NOT NULL DEFAULT current_timestamp(),
  `jenis_sertifikat` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `sertifikat_akreditasi`
--

INSERT INTO `sertifikat_akreditasi` (`id`, `histori_akreditasi_id`, `file_name`, `file_path`, `keterangan`, `uploaded_at`, `jenis_sertifikat`) VALUES
(1, 1, 'sertifikat_akreditasi_A_2023_rsms.jpg', 'uploads/sertifikat\\akreditasi.png', 'Sertifikat Akreditasi A Institusi Penyelenggara Pelatihan Bidang Kesehatan, berlaku 2023–2028', '2026-01-20 04:20:43', 'akreditasi'),
(2, 1, 'sertifikat_rs_pendidikan_rsms.jpg', 'uploads/sertifikat\\rumah sakit pendidikan.png', 'Sertifikat Rumah Sakit Pendidikan Utama RSUD Prof. Dr. Margono Soekarjo', '2026-01-20 04:20:57', 'rs_pendidikan');

-- --------------------------------------------------------

--
-- Table structure for table `struktur_organisasi_tb`
--

CREATE TABLE `struktur_organisasi_tb` (
  `id` int(11) NOT NULL,
  `judul` varchar(255) NOT NULL,
  `file_url` text NOT NULL,
  `aktif` tinyint(1) DEFAULT 1,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `struktur_organisasi_tb`
--

INSERT INTO `struktur_organisasi_tb` (`id`, `judul`, `file_url`, `aktif`, `created_at`) VALUES
(1, 'Struktur Organisasi Diklat RSUD Margono Soekarjo', 'http://asik.rsmargono.go.id:7222/pelatihan_diklat/assets/download/STRUKTUR%20ORGANISASI%20DIKLIT.pdf', 1, '2026-01-20 06:30:26');

-- --------------------------------------------------------

--
-- Table structure for table `tim_kerja`
--

CREATE TABLE `tim_kerja` (
  `id` int(11) NOT NULL,
  `institusi_id` int(11) NOT NULL,
  `jabatan` varchar(150) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `tim_kerja`
--

INSERT INTO `tim_kerja` (`id`, `institusi_id`, `jabatan`) VALUES
(1, 1, 'Pimpinan Diklat'),
(2, 1, 'Tim Penyusun Mutu Pelatihan & Penjaminan Mutu Pelatihan'),
(3, 1, 'TPM Tim Audit Mutu Internal'),
(4, 1, 'Fasilitator Pelatihan (Narasumber & Instruktur)'),
(8, 1, 'Panitia Penyelenggara Pelatihan');

-- --------------------------------------------------------

--
-- Table structure for table `user_tb`
--

CREATE TABLE `user_tb` (
  `id_user` int(11) NOT NULL,
  `email` varchar(30) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `nama_lengkap` varchar(70) DEFAULT NULL,
  `level_user` tinyint(4) DEFAULT 2 COMMENT '1=SuperAdmin, 2=Admin',
  `status_user` int(11) DEFAULT NULL,
  `last_login` datetime DEFAULT NULL,
  `aktivasi` char(1) DEFAULT NULL COMMENT 'Y=Aktif N=Nonaktif'
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci ROW_FORMAT=DYNAMIC;

--
-- Dumping data for table `user_tb`
--

INSERT INTO `user_tb` (`id_user`, `email`, `password`, `nama_lengkap`, `level_user`, `status_user`, `last_login`, `aktivasi`) VALUES
(15, 'admin@gmail.com', '$2b$10$L0TdUoR2E48DrxaZCvzHGO107xLnpw0hukuMQfpK5ArwDNz8wwEUa', 'Azmita Saifani A', 1, 1, '2026-03-25 23:59:21', 'Y'),
(17, 'admin1@gmail.com', '$2b$10$q.n48fC64Qt33c7/i8ZFWubD0wnHgUSZknshqtzkmDhQ8Fs5w3I4a', 'aaa', 2, 1, '2026-03-26 18:24:56', 'Y'),
(18, 'aaa@gmail.com', '$2b$10$wFPpS5iOCzYq9UhLXtUEcOO4JVyRVElgQwBGeB9BYaB02xqwXREr.', 'Azmita', 2, 0, '2026-02-14 17:08:12', 'Y'),
(19, 'fulan@gmail.com', '$2b$10$7q/8uhTOkNpsl80PowPZ7uYrKDW2kPVDG8cw5frPF1nAyl6/K3lR.', 'Fulan', 1, 1, '2026-02-27 14:37:38', 'Y');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `anggota_jabatan`
--
ALTER TABLE `anggota_jabatan`
  ADD PRIMARY KEY (`id`),
  ADD KEY `id_anggota` (`id_anggota`),
  ADD KEY `id_jabatan` (`id_jabatan`);

--
-- Indexes for table `anggota_organisasi`
--
ALTER TABLE `anggota_organisasi`
  ADD PRIMARY KEY (`id_anggota`);

--
-- Indexes for table `dokumentasi_tb`
--
ALTER TABLE `dokumentasi_tb`
  ADD PRIMARY KEY (`id`) USING BTREE;

--
-- Indexes for table `email_log_tb`
--
ALTER TABLE `email_log_tb`
  ADD PRIMARY KEY (`id_email_log`);

--
-- Indexes for table `fasilitator_tb`
--
ALTER TABLE `fasilitator_tb`
  ADD PRIMARY KEY (`id_fasilitator`) USING BTREE;

--
-- Indexes for table `histori_akreditasi`
--
ALTER TABLE `histori_akreditasi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `institusi_id` (`institusi_id`);

--
-- Indexes for table `institusi_kerjasama_tb`
--
ALTER TABLE `institusi_kerjasama_tb`
  ADD PRIMARY KEY (`id_institusi`) USING BTREE;

--
-- Indexes for table `institusi_pelatihan`
--
ALTER TABLE `institusi_pelatihan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `jabatan`
--
ALTER TABLE `jabatan`
  ADD PRIMARY KEY (`id_jabatan`),
  ADD KEY `parent_id` (`parent_id`);

--
-- Indexes for table `kalender_pelatihan`
--
ALTER TABLE `kalender_pelatihan`
  ADD PRIMARY KEY (`id_kalender`),
  ADD UNIQUE KEY `tahun` (`tahun`),
  ADD KEY `tahun_2` (`tahun`),
  ADD KEY `status` (`status`),
  ADD KEY `fk_kalender_admin` (`uploaded_by`);

--
-- Indexes for table `kritik_saran_tb`
--
ALTER TABLE `kritik_saran_tb`
  ADD PRIMARY KEY (`id_kritik`);

--
-- Indexes for table `log_admin`
--
ALTER TABLE `log_admin`
  ADD PRIMARY KEY (`id_log`),
  ADD KEY `id_user` (`id_user`),
  ADD KEY `created_at` (`created_at`);

--
-- Indexes for table `log_wa`
--
ALTER TABLE `log_wa`
  ADD PRIMARY KEY (`id_wa_log`);

--
-- Indexes for table `pelatihan_tb`
--
ALTER TABLE `pelatihan_tb`
  ADD PRIMARY KEY (`id_pelatihan`),
  ADD KEY `idx_tanggal_mulai` (`tanggal_mulai`),
  ADD KEY `idx_kategori` (`kategori`);

--
-- Indexes for table `pembayaran_tb`
--
ALTER TABLE `pembayaran_tb`
  ADD PRIMARY KEY (`id_pembayaran`),
  ADD KEY `fk_pembayaran_pendaftaran` (`id_pendaftaran`);

--
-- Indexes for table `pendaftaran_tb`
--
ALTER TABLE `pendaftaran_tb`
  ADD PRIMARY KEY (`id_pendaftaran`),
  ADD UNIQUE KEY `unique_peserta_pelatihan` (`id_pelatihan`,`nik`,`nip`,`nama_peserta`),
  ADD KEY `id_pelatihan` (`id_pelatihan`);

--
-- Indexes for table `penyelenggara_tb`
--
ALTER TABLE `penyelenggara_tb`
  ADD PRIMARY KEY (`id_penyelenggara`);

--
-- Indexes for table `sertifikat_akreditasi`
--
ALTER TABLE `sertifikat_akreditasi`
  ADD PRIMARY KEY (`id`),
  ADD KEY `histori_akreditasi_id` (`histori_akreditasi_id`);

--
-- Indexes for table `struktur_organisasi_tb`
--
ALTER TABLE `struktur_organisasi_tb`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `tim_kerja`
--
ALTER TABLE `tim_kerja`
  ADD PRIMARY KEY (`id`),
  ADD KEY `institusi_id` (`institusi_id`);

--
-- Indexes for table `user_tb`
--
ALTER TABLE `user_tb`
  ADD PRIMARY KEY (`id_user`) USING BTREE,
  ADD KEY `fk_statususer` (`status_user`) USING BTREE;

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `anggota_jabatan`
--
ALTER TABLE `anggota_jabatan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=27;

--
-- AUTO_INCREMENT for table `anggota_organisasi`
--
ALTER TABLE `anggota_organisasi`
  MODIFY `id_anggota` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT for table `dokumentasi_tb`
--
ALTER TABLE `dokumentasi_tb`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=74;

--
-- AUTO_INCREMENT for table `email_log_tb`
--
ALTER TABLE `email_log_tb`
  MODIFY `id_email_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=201;

--
-- AUTO_INCREMENT for table `fasilitator_tb`
--
ALTER TABLE `fasilitator_tb`
  MODIFY `id_fasilitator` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=81;

--
-- AUTO_INCREMENT for table `histori_akreditasi`
--
ALTER TABLE `histori_akreditasi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `institusi_kerjasama_tb`
--
ALTER TABLE `institusi_kerjasama_tb`
  MODIFY `id_institusi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `institusi_pelatihan`
--
ALTER TABLE `institusi_pelatihan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `jabatan`
--
ALTER TABLE `jabatan`
  MODIFY `id_jabatan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=26;

--
-- AUTO_INCREMENT for table `kalender_pelatihan`
--
ALTER TABLE `kalender_pelatihan`
  MODIFY `id_kalender` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `kritik_saran_tb`
--
ALTER TABLE `kritik_saran_tb`
  MODIFY `id_kritik` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=86;

--
-- AUTO_INCREMENT for table `log_admin`
--
ALTER TABLE `log_admin`
  MODIFY `id_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=780;

--
-- AUTO_INCREMENT for table `log_wa`
--
ALTER TABLE `log_wa`
  MODIFY `id_wa_log` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=54;

--
-- AUTO_INCREMENT for table `pelatihan_tb`
--
ALTER TABLE `pelatihan_tb`
  MODIFY `id_pelatihan` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=50;

--
-- AUTO_INCREMENT for table `pembayaran_tb`
--
ALTER TABLE `pembayaran_tb`
  MODIFY `id_pembayaran` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=52;

--
-- AUTO_INCREMENT for table `pendaftaran_tb`
--
ALTER TABLE `pendaftaran_tb`
  MODIFY `id_pendaftaran` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=135;

--
-- AUTO_INCREMENT for table `penyelenggara_tb`
--
ALTER TABLE `penyelenggara_tb`
  MODIFY `id_penyelenggara` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT for table `sertifikat_akreditasi`
--
ALTER TABLE `sertifikat_akreditasi`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `struktur_organisasi_tb`
--
ALTER TABLE `struktur_organisasi_tb`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `tim_kerja`
--
ALTER TABLE `tim_kerja`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT for table `user_tb`
--
ALTER TABLE `user_tb`
  MODIFY `id_user` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `anggota_jabatan`
--
ALTER TABLE `anggota_jabatan`
  ADD CONSTRAINT `anggota_jabatan_ibfk_1` FOREIGN KEY (`id_anggota`) REFERENCES `anggota_organisasi` (`id_anggota`) ON DELETE CASCADE,
  ADD CONSTRAINT `anggota_jabatan_ibfk_2` FOREIGN KEY (`id_jabatan`) REFERENCES `jabatan` (`id_jabatan`) ON DELETE CASCADE;

--
-- Constraints for table `histori_akreditasi`
--
ALTER TABLE `histori_akreditasi`
  ADD CONSTRAINT `histori_akreditasi_ibfk_1` FOREIGN KEY (`institusi_id`) REFERENCES `institusi_pelatihan` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `jabatan`
--
ALTER TABLE `jabatan`
  ADD CONSTRAINT `jabatan_ibfk_1` FOREIGN KEY (`parent_id`) REFERENCES `jabatan` (`id_jabatan`) ON DELETE SET NULL;

--
-- Constraints for table `kalender_pelatihan`
--
ALTER TABLE `kalender_pelatihan`
  ADD CONSTRAINT `fk_kalender_admin` FOREIGN KEY (`uploaded_by`) REFERENCES `user_tb` (`id_user`);

--
-- Constraints for table `pembayaran_tb`
--
ALTER TABLE `pembayaran_tb`
  ADD CONSTRAINT `fk_pembayaran_pendaftaran` FOREIGN KEY (`id_pendaftaran`) REFERENCES `pendaftaran_tb` (`id_pendaftaran`) ON DELETE CASCADE;

--
-- Constraints for table `pendaftaran_tb`
--
ALTER TABLE `pendaftaran_tb`
  ADD CONSTRAINT `pendaftaran_tb_ibfk_2` FOREIGN KEY (`id_pelatihan`) REFERENCES `pelatihan_tb` (`id_pelatihan`) ON DELETE CASCADE ON UPDATE CASCADE;

--
-- Constraints for table `sertifikat_akreditasi`
--
ALTER TABLE `sertifikat_akreditasi`
  ADD CONSTRAINT `sertifikat_akreditasi_ibfk_1` FOREIGN KEY (`histori_akreditasi_id`) REFERENCES `histori_akreditasi` (`id`) ON DELETE CASCADE;

--
-- Constraints for table `tim_kerja`
--
ALTER TABLE `tim_kerja`
  ADD CONSTRAINT `tim_kerja_ibfk_1` FOREIGN KEY (`institusi_id`) REFERENCES `institusi_pelatihan` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
