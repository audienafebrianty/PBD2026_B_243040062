USE TokoRetailDB;
GO

/* Cek data SEBELUM di-update */
PRINT 'Data Citra SEBELUM Update:';
SELECT * FROM Pelanggan WHERE PelangganID = 2;

BEGIN TRANSACTION; -- Mulai zona aman

UPDATE Pelanggan
SET NoTelepon = '085566778899'
WHERE PelangganID = 2; -- Klausa WHERE sangat penting!

/* Cek data SETELAH di-update (masih di dalam transaksi) */
PRINT 'Data Citra SETELAH Update (Belum di-COMMIT):';
SELECT * FROM Pelanggan WHERE PelangganID = 2;

-- Jika sudah yakin, jadikan permanen
COMMIT TRANSACTION;
-- Jika ragu, ganti COMMIT dengan ROLLBACK

PRINT 'Data Citra setelah di-COMMIT:';
SELECT * FROM Pelanggan WHERE PelangganID = 2;