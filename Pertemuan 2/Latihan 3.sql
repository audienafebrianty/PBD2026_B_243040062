USE TokoRetailDB;
GO

/* 1. Pelanggaran UNIQUE Constraint */
-- Error: Mencoba mendaftarkan email yang SAMA dengan Budi Santoso
PRINT 'Uji Coba Error 1 (UNIQUE)';
BEGIN TRY
INSERT INTO Pelanggan (NamaDepan, Email)
VALUES ('Budi', 'budi.santoso@email.com');
END TRY
BEGIN CATCH
PRINT 'GAGAL (sesuai harapan): ' + ERROR_MESSAGE();
END CATCH
GO

/* 2. Pelanggaran FOREIGN KEY Constraint */
-- Error: Mencoba memasukkan produk dengan KategoriID 99 (tidak ada di tabel KategoriProduk)
PRINT 'Uji Coba Error 2 (FOREIGN KEY)';
BEGIN TRY
INSERT INTO Produk (SKU, NamaProduk, Harga, Stok, KategoriID)
VALUES ('XXX-001', 'Produk Aneh', 1000, 10, 99);
END TRY
BEGIN CATCH
PRINT 'GAGAL (sesuai harapan): ' + ERROR_MESSAGE();
END CATCH
GO

/* 3. Pelanggaran CHECK Constraint */
-- Error: Mencoba memasukkan harga negatif
PRINT 'Uji Coba Error 3 (CHECK)';
BEGIN TRY
INSERT INTO Produk (SKU, NamaProduk, Harga, Stok, KategoriID)
VALUES ('NGT-001', 'Produk Minus', -50000, 10, 1);
END TRY
BEGIN CATCH
PRINT 'GAGAL (sesuai harapan): ' + ERROR_MESSAGE();
END CATCH
GO