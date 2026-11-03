USE TokoRetailDB;
GO

/* 1. Memasukkan data Pelanggan */
-- Sintaks eksplisit (Best Practice)
INSERT INTO Pelanggan (NamaDepan, NamaBelakang, Email, NoTelepon)
VALUES
('Budi', 'Santoso', 'budi.santoso@email.com', '081234567890'),
('Citra', 'Lestari', 'citra.lestari@email.com', NULL); -- NoTelepon boleh NULL

/* 2. Memasukkan data Kategori (Multi-row) */
INSERT INTO KategoriProduk (NamaKategori)
VALUES
('Elektronik'),
('Pakaian'),
('Buku');

/* 3. Verifikasi Data */
PRINT 'Data Pelanggan:';
SELECT * FROM Pelanggan;

PRINT 'Data Kategori:';
SELECT * FROM KategoriProduk;