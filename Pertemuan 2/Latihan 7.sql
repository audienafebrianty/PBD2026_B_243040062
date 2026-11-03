USE TokoRetailDB;
GO

/* Cek data stok. Harusnya 50 dan 200 */
PRINT 'Data Stok SEBELUM Bencana:';
SELECT SKU, NamaProduk, Stok FROM Produk;

BEGIN TRANSACTION; -- WAJIB! Ini adalah jaring pengaman kita.

-- BENCANA TERJADI: Lupa klausa WHERE!
UPDATE Produk 
SET Stok = 0;

/* Cek data setelah bencana. SEMUA STOK JADI 0! */
PRINT 'Data Stok SETELAH Bencana (PANIK!):';
SELECT SKU, NamaProduk, Stok FROM Produk;

-- JANGAN COMMIT! BATALKAN!
PRINT 'Melakukan ROLLBACK...';
ROLLBACK TRANSACTION;

/* Cek data setelah diselamatkan */
PRINT 'Data Stok SETELAH di-ROLLBACK (AMAN):';
SELECT SKU, NamaProduk, Stok FROM Produk;