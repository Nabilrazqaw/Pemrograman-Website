CREATE TABLE anggota(
    id_anggota INT(3) NOT NULL PRIMARY KEY,
    nm_anggota VARCHAR(30) NOT NULL,
    alamat TEXT NOT NULL,
    ttl_anggota DATE NOT NULL,
    status_anggota VARCHAR(1) NOT NULL
);

CREATE TABLE buku(
    kd_buku INT(5) NOT NULL PRIMARY KEY,
    judul_buku VARCHAR(32) NOT NULL,
    pengarang VARCHAR(32) NOT NULL,
    jenis_buku VARCHAR(32) NOT NULL,
    penerbit VARCHAR(32)
);

CREATE TABLE meminjam(
    id_pinjam INT(3) NOT NULL PRIMARY KEY,
    tgl_pinjam DATE NOT NULL,
    jumlah_pinjam INT(2) NOT NULL,
    tgl_kembali DATE,
    id_anggota INT(3) NOT NULL,
    kd_buku INT(5) NOT NULL,
    kembali INT(1) DEFAULT 0,
    CONSTRAINT fk_anggota FOREIGN KEY (id_anggota) REFERENCES anggota(id_anggota) ON DELETE CASCADE ON UPDATE CASCADE,
    CONSTRAINT fk_buku FOREIGN KEY (kd_buku) REFERENCES buku(kd_buku) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB;

INSERT INTO anggota (id_anggota, nm_anggota, alamat, ttl_anggota, status_anggota) VALUES
(1, 'Bagas Ardi', 'Jl. Merdeka No. 10, Jakarta', '2000-05-15', 'A'),
(2, 'Najwa Luthfi', 'Jl. Sudirman No. 25, Bandung', '1999-08-20', 'A'),
(3, 'Muhammad Imansyah', 'Jl. Gatot Subroto No. 5, Surabaya', '2001-03-12', 'A'),
(4, 'Elsa Syaila', 'Jl. Diponegoro No. 15, Yogyakarta', '1998-11-30', 'A'),
(5, 'Sila Serilda', 'Jl. Ahmad Yani No. 8, Semarang', '2002-07-22', 'A'),
(6, 'Shofia Nabila', 'Jl. Veteran No. 12, Malang', '2000-01-18', 'A'),
(7, 'Fatma Fayza', 'Jl. Pemuda No. 20, Solo', '1999-09-05', 'A'),
(8, 'Syifa Sakinah', 'Jl. Pahlawan No. 7, Medan', '2001-12-25', 'N'),
(9, 'nayla', 'Jl. Pahlawan No. 7, Medan', '2001-12-25', 'N'),
(10, 'Syifa Sakinah', 'Jl. Pahlawan No. 7, Medan', '2001-12-25', 'N');

INSERT INTO buku (kd_buku, judul_buku, pengarang, jenis_buku, penerbit) VALUES
(1, 'Laskar Pelangi', 'Andrea Hirata', 'Novel', 'Bentang Pustaka'),
(2, 'Bumi Manusia', 'Pramoedya Ananta Toer', 'Novel', 'Hasta Mitra'),
(3, 'Algoritma Pemrograman', 'Rinaldi Munir', 'Teknologi', 'Informatika'),
(4, 'Pemrograman Web', 'Abdul Kadir', 'Teknologi', 'Andi Publisher'),
(5, 'Database MySQL', 'Jubilee Enterprise', 'Teknologi', 'Elex Media'),
(6, 'Filosofi Teras', 'Henry Manampiring', 'Filsafat', 'Kompas'),
(7, 'Sejarah Indonesia', 'Anhar Gonggong', 'Sejarah', 'Erlangga'),
(8, 'Fisika Dasar', 'Giancoli', 'Sains', 'Erlangga'),
(9, 'Matematika Lanjut', 'Purcell', 'Sains', 'Erlangga'),
(10, 'Bahasa Indonesia', 'Dendy Sugono', 'Bahasa', 'Pusat Bahasa');

INSERT INTO meminjam (id_pinjam, tgl_pinjam, jumlah_pinjam, tgl_kembali, id_anggota, kd_buku, kembali) VALUES
(1, '2025-09-01', 1, '2025-09-08', 1, 1, 1),
(2, '2025-09-05', 2, '2025-09-12', 2, 3, 1),
(3, '2025-09-10', 1, '2025-09-17', 1, 5, 1),
(4, '2025-09-15', 1, '2025-09-22', 3, 2, 1);

-- Data peminjaman yang belum dikembalikan (dalam deadline)
INSERT INTO meminjam (id_pinjam, tgl_pinjam, jumlah_pinjam, tgl_kembali, id_anggota, kd_buku, kembali) VALUES
(5, '2025-10-01', 1, '2025-10-15', 2, 4, 0),
(6, '2025-10-03', 2, '2025-10-17', 4, 6, 0);

-- Data peminjaman yang telat dikembalikan (lewat deadline)
INSERT INTO meminjam (id_pinjam, tgl_pinjam, jumlah_pinjam, tgl_kembali, id_anggota, kd_buku, kembali) VALUES
(7, '2025-09-20', 1, '2025-09-27', 5, 7, 0),
(8, '2025-09-22', 1, '2025-09-29', 1, 8, 0);

-- Data peminjaman hari ini
INSERT INTO meminjam (id_pinjam, tgl_pinjam, jumlah_pinjam, tgl_kembali, id_anggota, kd_buku, kembali) VALUES
(9, CURDATE(), 1, DATE_ADD(CURDATE(), INTERVAL 7 DAY), 3, 9, 0),
(10, CURDATE(), 2, DATE_ADD(CURDATE(), INTERVAL 7 DAY), 1, 10, 0);

SELECT DISTINCT a.* 
FROM anggota a
INNER JOIN meminjam m ON a.id_anggota = m.id_anggota;

SELECT a.* 
FROM anggota a
LEFT JOIN meminjam m ON a.id_anggota = m.id_anggota
WHERE m.id_pinjam IS NULL;

SELECT a.*, m.* 
FROM anggota a
INNER JOIN meminjam m ON a.id_anggota = m.id_anggota
WHERE m.tgl_pinjam = CURDATE();

SELECT a.id_anggota, a.nm_anggota, COUNT(m.id_pinjam) AS total_pinjam
FROM anggota a
INNER JOIN meminjam m ON a.id_anggota = m.id_anggota
GROUP BY a.id_anggota, a.nm_anggota
HAVING COUNT(m.id_pinjam) > 3;

SELECT b.*, m.tgl_pinjam, m.tgl_kembali, a.nm_anggota
FROM buku b
INNER JOIN meminjam m ON b.kd_buku = m.kd_buku
INNER JOIN anggota a ON m.id_anggota = a.id_anggota
WHERE m.kembali = 0 
AND m.tgl_kembali < CURDATE();

UPDATE anggota 
SET status_anggota = 'N'
WHERE id_anggota NOT IN (
    SELECT DISTINCT id_anggota 
    FROM meminjam
);