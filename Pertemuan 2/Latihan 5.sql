USE TokoRetailDB;
GO

PRINT 'Data Elektronik SEBELUM Update:';
SELECT * FROM Produk WHERE KategoriID = 1;

BEGIN TRANSACTION;

UPDATE Produk
SET Harga = Harga * 1.10 -- Operasi aritmatika pada nilai kolom
WHERE KategoriID = 1;

PRINT 'Data Elektronik SETELAH Update (Belum di-COMMIT):';
SELECT * FROM Produk WHERE KategoriID = 1;

-- Cek apakah ada kesalahan? Jika tidak, commit.
COMMIT TRANSACTION;