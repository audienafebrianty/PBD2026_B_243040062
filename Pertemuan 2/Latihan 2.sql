USE TokoRetailDB;
GO

/* Masukkan data Produk yang merujuk ke KategoriID */
INSERT INTO Produk (SKU, NamaProduk, Harga, Stok, KategoriID)
VALUES
('ELEC-001', 'Laptop Pro 14 inch', 15000000.00, 50,  1), -- KategoriID 1 = Elektronik
('PAK-001',  'Kaos Polos Putih',        75000.00, 200, 2), -- KategoriID 2 = Pakaian
('BUK-001',  'Dasar-Dasar SQL',        120000.00, 100, 3); -- KategoriID  = Buku

/* Verifikasi Data */
PRINT 'Data Produk:';
SELECT P.*, K.NamaKategori
FROM Produk AS P
JOIN KategoriProduk AS K ON P.KategoriID = K.KategoriID;