USE TokoRetailDB;
GO

/* 1. Buat tabel arsip (DDL) */
IF OBJECT_ID('ProdukArsip', 'U') IS NOT NULL
    DROP TABLE ProdukArsip;
GO

CREATE TABLE ProdukArsip (
    ProdukID INT PRIMARY KEY, -- Tanpa IDENTITY
    SKU VARCHAR(20)  NOT NULL,
    NamaProduk VARCHAR(150) NOT NULL,
    Harga DECIMAL(10,2) NOT NULL,
    TanggalArsip DATE DEFAULT GETDATE()
);
GO

BEGIN TRANSACTION;

/* 2. Habiskan stok Kaos (SKU PAK-001) */
UPDATE Produk SET Stok = 0 WHERE SKU = 'PAK-001';

/* 3. Salin data dari Produk ke ProdukArsip (INSERT ... SELECT) */
INSERT INTO ProdukArsip (ProdukID, SKU, NamaProduk, Harga)
SELECT ProdukID, SKU, NamaProduk, Harga
FROM Produk
WHERE Stok = 0;

/* 4. Hapus data yang sudah diarsip dari tabel Produk */
DELETE FROM Produk
WHERE Stok = 0;

/* Verifikasi */
PRINT 'Cek Produk Aktif (Kaos harus hilang):';
SELECT * FROM Produk;

PRINT 'Cek Produk Arsip (Kaos harus ada):';
SELECT * FROM ProdukArsip;

-- Jika yakin, commit
COMMIT TRANSACTION;