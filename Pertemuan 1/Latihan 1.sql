CREATE DATABASE Pertemuan12026
CREATE TABLE Produk (
    ProdukID INT,
    SKU VARCHAR(15),
    NamaProduk VARCHAR(100),
    Harga DECIMAL(10, 2),
    Stok INT
);

-- Cek struktur tabel
EXEC sp_help 'Produk';