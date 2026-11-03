USE TokoRetailDB;
GO

/* 1. Buat 1 pesanan untuk Budi */
INSERT INTO PesananHeader (PelangganID, StatusPesanan)
VALUES (1, 'Baru');

PRINT 'Data Pesanan Budi:';
SELECT * FROM PesananHeader WHERE PelangganID = 1;
GO

/* 2. Coba hapus Pelanggan Budi (PelangganID 1) */
PRINT 'Mencoba menghapus Budi...';
BEGIN TRANSACTION;

BEGIN TRY
DELETE FROM Pelanggan
WHERE PelangganID = 1;
-- Perintah ini akan GAGAL!

PRINT 'Tidak disangka berhasil...';
END TRY
BEGIN CATCH
PRINT 'GAGAL (sesuai harapan): ' + ERROR_MESSAGE();
END CATCH

ROLLBACK TRANSACTION; -- Batalkan (walaupun sudah gagal)