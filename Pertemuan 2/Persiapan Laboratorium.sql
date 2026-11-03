/* 1. Buat tabel Kategori */
CREATE TABLE KategoriProduk (
    KategoriID INT IDENTITY(1,1) PRIMARY KEY,
    NamaKategori VARCHAR(100) NOT NULL UNIQUE
);
GO

/* 2. Buat tabel Produk */
CREATE TABLE Produk (
    ProdukID INT IDENTITY(1001, 1) PRIMARY KEY,
    SKU VARCHAR(20) NOT NULL UNIQUE,
    NamaProduk VARCHAR(150) NOT NULL,
    Harga DECIMAL(10, 2) NOT NULL,
    Stok INT NOT NULL,
    KategoriID INT NULL, -- Boleh NULL jika belum dikategorikan
    CONSTRAINT CHK_HargaPositif CHECK (Harga >= 0),
    CONSTRAINT CHK_StokPositif CHECK (Stok >= 0),
    CONSTRAINT FK_Produk_Kategori FOREIGN KEY (KategoriID) REFERENCES KategoriProduk(KategoriID)
);
GO

/* 3. Buat tabel Pelanggan */
CREATE TABLE Pelanggan (
    PelangganID INT IDENTITY(1,1) PRIMARY KEY,
    NamaDepan VARCHAR(50) NOT NULL,
    NamaBelakang VARCHAR(50) NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    NoTelepon VARCHAR(20) NULL,
    TanggalDaftar DATE DEFAULT GETDATE()
);
GO

/* 4. Buat tabel Pesanan Header */
CREATE TABLE PesananHeader (
    PesananID INT IDENTITY(50001, 1) PRIMARY KEY,
    PelangganID INT NOT NULL,
    TanggalPesanan DATETIME2 DEFAULT GETDATE(),
    StatusPesanan VARCHAR(20) NOT NULL,
    CONSTRAINT CHK_StatusPesanan CHECK (StatusPesanan IN ('Baru', 'Proses', 'Selesai', 'Batal')),
    CONSTRAINT FK_Pesanan_Pelanggan FOREIGN KEY (PelangganID) REFERENCES Pelanggan(PelangganID)
);
GO

/* 5. Buat tabel Pesanan Detail */
CREATE TABLE PesananDetail (
    PesananDetailID INT IDENTITY(1,1) PRIMARY KEY,
    PesananID INT NOT NULL,
    ProdukID INT NOT NULL,
    Jumlah INT NOT NULL,
    HargaSatuan DECIMAL(10, 2) NOT NULL,
    CONSTRAINT CHK_JumlahPositif CHECK (Jumlah > 0),
    CONSTRAINT FK_Detail_Header FOREIGN KEY (PesananID) REFERENCES PesananHeader(PesananID) ON DELETE CASCADE,
    CONSTRAINT FK_Detail_Produk FOREIGN KEY (ProdukID) REFERENCES Produk(ProdukID)
);
GO
PRINT 'Database TokoRetailDB dan semua tabel berhasil dibuat.';