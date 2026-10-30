IF DB_ID('TokoRetailDB') IS NULL
BEGIN
    CREATE DATABASE TokoRetailDB;
    PRINT 'Database TokoRetailDB dibuat.';
END
ELSE
    PRINT 'Database TokoRetailDB sudah ada.';
GO

USE TokoRetailDB;
GO

-- Menghapus FK
IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_Produk_Kategori')
    ALTER TABLE dbo.Produk DROP CONSTRAINT FK_Produk_Kategori;
GO

IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_Detail_Header')
    ALTER TABLE dbo.PesananDetail DROP CONSTRAINT FK_Detail_Header;
GO

IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_Detail_Produk')
    ALTER TABLE dbo.PesananDetail DROP CONSTRAINT FK_Detail_Produk;
GO

IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_Pesanan_Pelanggan')
    ALTER TABLE dbo.PesananHeader DROP CONSTRAINT FK_Pesanan_Pelanggan;
GO

-- Menghapus tabel
IF OBJECT_ID('dbo.PesananDetail', 'U') IS NOT NULL DROP TABLE dbo.PesananDetail;
GO
IF OBJECT_ID('dbo.PesananHeader', 'U') IS NOT NULL DROP TABLE dbo.PesananHeader;
GO
IF OBJECT_ID('dbo.Pelanggan',    'U') IS NOT NULL DROP TABLE dbo.Pelanggan;
GO
IF OBJECT_ID('dbo.Produk',       'U') IS NOT NULL DROP TABLE dbo.Produk;
GO
IF OBJECT_ID('dbo.KategoriProduk','U') IS NOT NULL DROP TABLE dbo.KategoriProduk;
GO

-- Buat ulang tabel latihan 1-3
CREATE TABLE Produk (
    ProdukID INT NOT NULL PRIMARY KEY,
    SKU VARCHAR(15),
    NamaProduk VARCHAR(100),
    Harga DECIMAL(10, 2) NOT NULL,
    Stok INT
);
GO

CREATE TABLE Pelanggan (
    PelangganID INT IDENTITY(1,1) PRIMARY KEY,
    NamaDepan VARCHAR(50) NOT NULL,
    NamaBelakang VARCHAR(50) NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    TanggalDaftar DATE DEFAULT GETDATE(),
    NoTelepon VARCHAR(20) NULL
);
GO

CREATE TABLE PesananHeader (
    PesananID INT IDENTITY(1,1) PRIMARY KEY,
    TanggalPesanan DATETIME2 NOT NULL,
    PelangganID INT NOT NULL,
    StatusPesanan VARCHAR(10) NOT NULL,

    CONSTRAINT FK_Pesanan_Pelanggan
    FOREIGN KEY (PelangganID) REFERENCES Pelanggan(PelangganID),

    CONSTRAINT CHK_StatusPesanan
    CHECK (StatusPesanan IN ('Baru', 'Proses', 'Selesai'))
);
GO

-- Buat KategoriProduk
CREATE TABLE KategoriProduk (
    KategoriID INT PRIMARY KEY,
    NamaKategori VARCHAR(50) NOT NULL
);
GO

-- Tambah kolom KategoriID ke Produk
ALTER TABLE Produk
ADD KategoriID INT NULL;
GO

-- Tambah FK Produk
ALTER TABLE Produk
ADD CONSTRAINT FK_Produk_Kategori
    FOREIGN KEY (KategoriID) REFERENCES KategoriProduk(KategoriID);
GO

EXEC sp_help 'Produk';
EXEC sp_help 'KategoriProduk';