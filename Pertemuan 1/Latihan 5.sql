-- Pelanggan
IF OBJECT_ID('dbo.Pelanggan', 'U') IS NULL
BEGIN
    CREATE TABLE Pelanggan (
        PelangganID INT IDENTITY(1,1) PRIMARY KEY,
        NamaDepan VARCHAR(50) NOT NULL,
        NamaBelakang VARCHAR(50) NULL,
        Email VARCHAR(100) NOT NULL UNIQUE,
        TanggalDaftar DATE DEFAULT GETDATE()
    );
    PRINT 'Pelanggan dibuat.';
END
GO

-- Produk
IF OBJECT_ID('dbo.Produk', 'U') IS NULL
BEGIN
    CREATE TABLE Produk (
        ProdukID INT NOT NULL PRIMARY KEY,
        SKU VARCHAR(15),
        NamaProduk VARCHAR(100),
        Harga DECIMAL(10, 2) NOT NULL,
        Stok INT
    );
    PRINT 'Produk dibuat.';
END
GO

-- PesananHeader
IF OBJECT_ID('dbo.PesananHeader', 'U') IS NULL
BEGIN
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
    PRINT 'PesananHeader dibuat.';
END
GO

IF OBJECT_ID('dbo.PesananDetail', 'U') IS NOT NULL
    DROP TABLE dbo.PesananDetail;
GO

-- 1. Buat tabel detail
CREATE TABLE PesananDetail (
    PesananDetailID INT IDENTITY(1,1) PRIMARY KEY,
    PesananID INT NOT NULL,
    ProdukID INT NOT NULL,
    Jumlah INT NOT NULL,

    CONSTRAINT FK_Detail_Header
    FOREIGN KEY (PesananID) REFERENCES PesananHeader(PesananID),

    CONSTRAINT FK_Detail_Produk
    FOREIGN KEY (ProdukID) REFERENCES Produk(ProdukID)
);
GO

PRINT 'PesananDetail dibuat.';

-- Menghapus FK dari PesananDetail
IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_Detail_Header')
BEGIN
    ALTER TABLE dbo.PesananDetail DROP CONSTRAINT FK_Detail_Header;
    PRINT 'FK_Detail_Header dihapus.';
END
GO

IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_Detail_Produk')
BEGIN
    ALTER TABLE dbo.PesananDetail DROP CONSTRAINT FK_Detail_Produk;
    PRINT 'FK_Detail_Produk dihapus.';
END
GO

-- Menghapus FK dari PesananHeader
IF EXISTS (SELECT 1 FROM sys.foreign_keys WHERE name = 'FK_Pesanan_Pelanggan')
BEGIN
    ALTER TABLE dbo.PesananHeader DROP CONSTRAINT FK_Pesanan_Pelanggan;
    PRINT 'FK_Pesanan_Pelanggan dihapus.';
END

IF OBJECT_ID('dbo.PesananDetail', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.PesananDetail;
    PRINT 'PesananDetail dihapus.';
END
GO

IF OBJECT_ID('dbo.PesananHeader', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.PesananHeader;
    PRINT 'PesananHeader dihapus.';
END
GO

IF OBJECT_ID('dbo.Pelanggan', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.Pelanggan;
    PRINT 'Pelanggan dihapus.';
END
GO

IF OBJECT_ID('dbo.Produk', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.Produk;
    PRINT 'Produk dihapus.';
END
GO

IF OBJECT_ID('dbo.KategoriProduk', 'U') IS NOT NULL
BEGIN
    DROP TABLE dbo.KategoriProduk;
    PRINT 'KategoriProduk dihapus.';
END
GO

SELECT name AS TabelTersisa
FROM sys.tables
WHERE name IN ('Produk', 'Pelanggan', 'PesananHeader', 'PesananDetail', 'KategoriProduk');

PRINT 'Semua tabel pesanan dan pelanggan berhasil dihapus.';