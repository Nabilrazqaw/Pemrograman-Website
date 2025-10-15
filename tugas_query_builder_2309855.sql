CREATE TABLE Nelayan (
    id_nelayan INT PRIMARY KEY,
    nama_nelayan VARCHAR(100) NOT NULL,
    alamat VARCHAR(255)
);

CREATE TABLE Kapal (
    id_kapal INT PRIMARY KEY,
    nama_kapal VARCHAR(100) NOT NULL,
    kapasitas_kapal INT,
    id_nelayan INT,
    FOREIGN KEY (id_nelayan) REFERENCES Nelayan(id_nelayan)
);

CREATE TABLE Jenis_Ikan (
    id_jenis_ikan INT PRIMARY KEY,
    nama_ikan VARCHAR(100) NOT NULL,
    kategori_ikan VARCHAR(50)
);

CREATE TABLE Daerah_Tangkap (
    id_daerah INT PRIMARY KEY,
    nama_daerah VARCHAR(100) NOT NULL,
    koordinat VARCHAR(50)
);

CREATE TABLE Hasil_Tangkapan (
    id_tangkapan INT PRIMARY KEY,
    id_nelayan INT,
    id_jenis_ikan INT,
    id_daerah INT,
    berat_tangkapan INT,
    FOREIGN KEY (id_nelayan) REFERENCES Nelayan(id_nelayan),
    FOREIGN KEY (id_jenis_ikan) REFERENCES Jenis_Ikan(id_jenis_ikan),
    FOREIGN KEY (id_daerah) REFERENCES Daerah_Tangkap(id_daerah)
);

CREATE TABLE Pelabuhan (
    id_pelabuhan INT PRIMARY KEY,
    nama_pelabuhan VARCHAR(100) NOT NULL,
    lokasi VARCHAR(100)
);

CREATE TABLE Pendaratan_Ikan (
    id_pendaratan INT PRIMARY KEY,
    id_pelabuhan INT,
    id_tangkapan INT,
    tanggal_pendaratan DATE,
    FOREIGN KEY (id_pelabuhan) REFERENCES Pelabuhan(id_pelabuhan),
    FOREIGN KEY (id_tangkapan) REFERENCES Hasil_Tangkapan(id_tangkapan)
);

CREATE TABLE Penjual_Ikan (
    id_penjual INT PRIMARY KEY,
    nama_penjual VARCHAR(100) NOT NULL,
    id_pelabuhan INT,
    FOREIGN KEY (id_pelabuhan) REFERENCES Pelabuhan(id_pelabuhan)
);

CREATE TABLE Harga_Ikan (
    id_harga INT PRIMARY KEY,
    id_jenis_ikan INT,
    id_pelabuhan INT,
    harga_per_kg INT,
    FOREIGN KEY (id_jenis_ikan) REFERENCES Jenis_Ikan(id_jenis_ikan),
    FOREIGN KEY (id_pelabuhan) REFERENCES Pelabuhan(id_pelabuhan)
);

CREATE TABLE Pembeli_Ikan (
    id_pembeli INT PRIMARY KEY,
    nama_pembeli VARCHAR(100) NOT NULL,
    id_penjual INT,
    jumlah_pembelian INT,
    tanggal_pembelian DATE,
    FOREIGN KEY (id_penjual) REFERENCES Penjual_Ikan(id_penjual)
);

INSERT INTO Nelayan (id_nelayan, nama_nelayan, alamat) VALUES
(1, 'Budi', 'Jalan Laut 10'),
(2, 'Slamet', 'Jalan Samudra 20'),
(3, 'Joko', 'Jalan Bahari 5'),
(4, 'Hasan', 'Jalan Pelabuhan 15'),
(5, 'Hendra', 'Jalan Karang 30'),
(6, 'Rahmat', 'Jalan Laut Selatan 12'),
(7, 'Dewi', 'Jalan Samudra Kecil 18'),
(8, 'Fajar', 'Jalan Ikan Patin 9'),
(9, 'Rizal', 'Jalan Pantai Timur 27'),
(10, 'Andi', 'Jalan Karang Laut 5');

INSERT INTO Kapal (id_kapal, nama_kapal, kapasitas_kapal, id_nelayan) VALUES
(101, 'Sumber Laut', 100, 1),
(102, 'Makmur Jaya', 120, 2),
(103, 'Bahari Indah', 150, 3),
(104, 'Laut Sejahtera', 200, 4),
(105, 'Nusantara Indah', 180, 5),
(106, 'Nusantara', 130, 6),
(107, 'Samudra Perkasa', 150, 7),
(108, 'Angin Laut', 110, 8),
(109, 'Bintang Laut', 140, 9),
(110, 'Bahari Sejahtera', 120, 10);

INSERT INTO Jenis_Ikan (id_jenis_ikan, nama_ikan, kategori_ikan) VALUES
(1, 'Tongkol', 'Pelagis Kecil'),
(2, 'Tenggiri', 'Pelagis Besar'),
(3, 'Cakalang', 'Pelagis Kecil'),
(4, 'Layur', 'Demersal'),
(5, 'Kakap Merah', 'Karang'),
(6, 'Tuna', 'Pelagis Besar'),
(7, 'Barakuda', 'Pelagis Besar'),
(8, 'Ikan Kembung', 'Pelagis Kecil'),
(9, 'Layang', 'Pelagis Kecil'),
(10, 'Kakap', 'Karang');

INSERT INTO Daerah_Tangkap (id_daerah, nama_daerah, koordinat) VALUES
(301, 'Laut Jawa', '-6.112, 110.419'),
(302, 'Samudra Hindia', '-9.412, 112.873'),
(303, 'Selat Makassar', '-2.205, 117.461'),
(304, 'Laut Banda', '-4.523, 129.289'),
(305, 'Selat Karimata', '-1.832, 108.972'),
(306, 'Laut Sulawesi', '-3.945, 123.721'),
(307, 'Selat Sunda', '-5.882, 105.842'),
(308, 'Laut Jawa', '-6.105, 110.719'),
(309, 'Laut Maluku', '-1.654, 126.451'),
(310, 'Samudra Hindia', '-9.125, 112.453');

INSERT INTO Hasil_Tangkapan (id_tangkapan, id_nelayan, id_jenis_ikan, id_daerah, berat_tangkapan) VALUES
(5001, 1, 1, 301, 500),
(5002, 2, 2, 302, 400),
(5003, 3, 3, 303, 350),
(5004, 4, 4, 304, 450),
(5005, 5, 5, 305, 600),
(5006, 6, 6, 306, 520),
(5007, 7, 7, 307, 480),
(5008, 8, 8, 308, 360),
(5009, 9, 9, 309, 420),
(5010, 10, 10, 310, 530),
(5011, 1, 1, 301, 200),
(5012, 2, 2, 302, 150),
(5013, 3, 3, 303, 300),
(5014, 4, 4, 304, 250),
(5015, 5, 5, 305, 220),
(5016, 6, 6, 306, 180),
(5017, 2, 2, 302, 160),
(5018, 4, 4, 304, 210),
(5019, 6, 6, 306, 190),
(5020, 7, 7, 307, 230),
(5021, 8, 8, 308, 400);

INSERT INTO Pelabuhan (id_pelabuhan, nama_pelabuhan, lokasi) VALUES
(1, 'Pelabuhan Perikanan Samudra Jakarta', 'Jakarta'),
(2, 'Pelabuhan Perikanan Samudra Cilacap', 'Cilacap'),
(3, 'Pelabuhan Perikanan Samudra Bitung', 'Bitung'),
(4, 'Pelabuhan Perikanan Samudra Kendari', 'Kendari'),
(5, 'Pelabuhan Perikanan Samudra Ambon', 'Ambon'),
(6, 'Pelabuhan Perikanan Samudra Tual', 'Tual'),
(7, 'Pelabuhan Perikanan Samudra Palabuhanratu', 'Palabuhanratu'),
(8, 'Pelabuhan Perikanan Samudra Muara Angke', 'Jakarta Utara'),
(9, 'Pelabuhan Perikanan Samudra Ternate', 'Ternate'),
(10, 'Pelabuhan Perikanan Samudra Bali', 'Bali');

INSERT INTO Pendaratan_Ikan (id_pendaratan, id_pelabuhan, id_tangkapan, tanggal_pendaratan) VALUES
(9001, 1, 5001, '2024-09-12'),
(9002, 2, 5002, '2024-09-13'),
(9003, 3, 5003, '2024-09-14'),
(9004, 4, 5004, '2024-09-15'),
(9005, 5, 5005, '2024-09-16'),
(9006, 6, 5006, '2024-09-16'),
(9007, 7, 5007, '2024-09-17'),
(9008, 8, 5008, '2024-09-17'),
(9009, 9, 5009, '2024-09-18'),
(9010, 10, 5010, '2024-09-18'),
(9011, 1, 5011, '2024-09-19'),
(9012, 2, 5012, '2024-09-19'),
(9013, 3, 5013, '2024-09-20'),
(9014, 4, 5014, '2024-09-20'),
(9015, 5, 5015, '2024-09-21'),
(9016, 6, 5016, '2024-09-25'),
(9017, 2, 5017, '2024-09-26'),
(9018, 4, 5018, '2024-09-27'),
(9019, 6, 5019, '2024-09-28'),
(9020, 7, 5020, '2024-09-29'),
(9021, 10, 5021, '2024-09-30');

INSERT INTO Penjual_Ikan (id_penjual, nama_penjual, id_pelabuhan) VALUES
(101, 'Pak Budi', 1),
(102, 'Pak Slamet', 2),
(103, 'Pak Joko', 3),
(104, 'Bu Siti', 4),
(105, 'Pak Yoyo', 5),
(106, 'Pak Herman', 6),
(107, 'Bu Nina', 7),
(108, 'Pak Edi', 8),
(109, 'Bu Wati', 9),
(110, 'Pak Suryo', 10);

INSERT INTO Harga_Ikan (id_harga, id_jenis_ikan, id_pelabuhan, harga_per_kg) VALUES
(1, 1, 1, 50000),
(2, 2, 2, 75000),
(3, 3, 3, 60000),
(4, 4, 4, 40000),
(5, 5, 5, 85000),
(6, 6, 6, 85000),
(7, 7, 7, 76000),
(8, 8, 8, 35000),
(9, 9, 9, 32000),
(10, 10, 10, 70000);

INSERT INTO Pembeli_Ikan (id_pembeli, nama_pembeli, id_penjual, jumlah_pembelian, tanggal_pembelian) VALUES
(1001, 'Pak Ahmad', 101, 50, '2024-09-12'),
(1002, 'Bu Rini', 102, 100, '2024-09-13'),
(1003, 'Pak Sugeng', 103, 75, '2024-09-14'),
(1004, 'Bu Dian', 104, 60, '2024-09-15'),
(1005, 'Pak Iwan', 106, 90, '2024-09-16'),
(1006, 'Bu Ani', 107, 40, '2024-09-16'),
(1007, 'Pak Hari', 108, 120, '2024-09-17'),
(1008, 'Bu Nita', 109, 85, '2024-09-17'),
(1009, 'Pak Danu', 110, 70, '2024-09-18'),
(1010, 'Bu Sari', 101, 95, '2024-09-18'),
(1011, 'Pak Ahmad', 101, 50, '2024-09-19'),
(1012, 'Pak Budi', 102, 75, '2024-09-19'),
(1013, 'Bu Citra', 103, 60, '2024-09-20'),
(1014, 'Bu Dewi', 104, 80, '2024-09-20'),
(1015, 'Pak Eko', 106, 70, '2024-09-21'),
(1016, 'Pak Fahmi', 101, 55, '2024-09-25'),
(1017, 'Bu Gita', 103, 62, '2024-09-26'),
(1018, 'Pak Hendra', 104, 78, '2024-09-27'),
(1019, 'Bu Indah', 102, 8, '2024-09-28'),
(1020, 'Pak Joko', 106, 710, '2024-09-29');

UPDATE Hasil_Tangkapan
SET berat_tangkapan = 550
WHERE id_tangkapan = 5001;

UPDATE Harga_Ikan
SET harga_per_kg = 80000
WHERE id_jenis_ikan = 2 AND id_pelabuhan = 2;

UPDATE Penjual_Ikan
SET nama_penjual = 'Pak Joni'
WHERE nama_penjual = 'Pak Joko';

UPDATE Pelabuhan
SET lokasi = 'Ambon Baru'
WHERE lokasi = 'Ambon';

UPDATE Pendaratan_Ikan
SET tanggal_pendaratan = '2024-09-15'
WHERE id_pendaratan = 9003;

DELETE FROM Pendaratan_Ikan
WHERE tanggal_pendaratan < '2024-09-30';

DELETE FROM Hasil_Tangkapan
WHERE id_tangkapan = 5021;

DELETE FROM Penjual_Ikan
WHERE id_penjual NOT IN (
    SELECT DISTINCT id_penjual 
    FROM Pembeli_Ikan
);

SELECT nama_kapal, kapasitas_kapal
FROM Kapal
WHERE kapasitas_kapal > 150;

SELECT *
FROM Jenis_Ikan
WHERE kategori_ikan = 'Pelagis Kecil';

SELECT 
    n.id_nelayan, 
    n.nama_nelayan, 
    SUM(ht.berat_tangkapan) AS total_tangkapan
FROM Nelayan n
LEFT JOIN Hasil_Tangkapan ht ON n.id_nelayan = ht.id_nelayan
GROUP BY n.id_nelayan, n.nama_nelayan;

SELECT nama_pembeli, jumlah_pembelian
FROM Pembeli_Ikan
WHERE jumlah_pembelian > 100;

SELECT ji.nama_ikan, hi.harga_per_kg
FROM Harga_Ikan hi
JOIN Jenis_Ikan ji ON hi.id_jenis_ikan = ji.id_jenis_ikan
WHERE hi.harga_per_kg > 60000;

SELECT *
FROM Pembeli_Ikan
WHERE tanggal_pembelian = '2024-09-20';

SELECT 
    ht.id_tangkapan, 
    ji.nama_ikan, 
    ht.berat_tangkapan
FROM Hasil_Tangkapan ht
JOIN Jenis_Ikan ji ON ht.id_jenis_ikan = ji.id_jenis_ikan;

SELECT 
    dt.nama_daerah, 
    SUM(ht.berat_tangkapan) AS total_berat_tangkapan
FROM Daerah_Tangkap dt
JOIN Hasil_Tangkapan ht ON dt.id_daerah = ht.id_daerah
GROUP BY dt.nama_daerah;

SELECT 
    ji.nama_ikan, 
    AVG(hi.harga_per_kg) AS rata_rata_harga
FROM Jenis_Ikan ji
JOIN Harga_Ikan hi ON ji.id_jenis_ikan = hi.id_jenis_ikan
GROUP BY ji.nama_ikan;

SELECT 
    n.id_nelayan, 
    n.nama_nelayan, 
    SUM(ht.berat_tangkapan) AS total_berat_tangkapan
FROM Nelayan n
LEFT JOIN Hasil_Tangkapan ht ON n.id_nelayan = ht.id_nelayan
GROUP BY n.id_nelayan, n.nama_nelayan;

SELECT 
    pj.id_penjual, 
    pj.nama_penjual, 
    COUNT(pb.id_pembeli) AS total_jumlah_pembeli
FROM Penjual_Ikan pj
LEFT JOIN Pembeli_Ikan pb ON pj.id_penjual = pb.id_penjual
GROUP BY pj.id_penjual, pj.nama_penjual;

SELECT 
    ji.nama_ikan, 
    SUM(ht.berat_tangkapan) AS total_berat_tangkapan
FROM Jenis_Ikan ji
JOIN Hasil_Tangkapan ht ON ji.id_jenis_ikan = ht.id_jenis_ikan
GROUP BY ji.nama_ikan
ORDER BY total_berat_tangkapan DESC
LIMIT 1;

SELECT 
    n.id_nelayan,
    n.nama_nelayan,
    ji.id_jenis_ikan,
    ji.nama_ikan,
    (SELECT SUM(ht.berat_tangkapan)
     FROM Hasil_Tangkapan ht
     WHERE ht.id_nelayan = n.id_nelayan 
     AND ht.id_jenis_ikan = ji.id_jenis_ikan) AS total_berat_tangkapan
FROM Nelayan n
CROSS JOIN Jenis_Ikan ji
WHERE EXISTS (
    SELECT 1
    FROM Hasil_Tangkapan ht
    WHERE ht.id_nelayan = n.id_nelayan 
    AND ht.id_jenis_ikan = ji.id_jenis_ikan
)
ORDER BY n.nama_nelayan, ji.nama_ikan;

SELECT 
    p.id_pelabuhan,
    p.nama_pelabuhan,
    (SELECT AVG(hi.harga_per_kg)
     FROM Harga_Ikan hi
     WHERE hi.id_pelabuhan = p.id_pelabuhan) AS rata_rata_harga_per_kg
FROM Pelabuhan p
WHERE EXISTS (
    SELECT 1
    FROM Harga_Ikan hi
    WHERE hi.id_pelabuhan = p.id_pelabuhan
)
ORDER BY p.nama_pelabuhan;

SELECT 
    pb.id_pembeli,
    pb.nama_pembeli,
    (SELECT pb.jumlah_pembelian * hi.harga_per_kg
     FROM Penjual_Ikan pj
     JOIN Harga_Ikan hi ON pj.id_pelabuhan = hi.id_pelabuhan
     WHERE pj.id_penjual = pb.id_penjual
     LIMIT 1) AS total_pembelian
FROM Pembeli_Ikan pb
HAVING total_pembelian > 5000
ORDER BY total_pembelian DESC;