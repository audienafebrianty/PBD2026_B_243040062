IF OBJECT_ID('dbo.PesananDetail', 'U') IS NOT NULL
    DROP TABLE dbo.PesananDetail;
GO

-- Menghapus PesananHeader yang sudah ada
IF OBJECT_ID('dbo.PesananHeader', 'U') IS NOT NULL
    DROP TABLE dbo.PesananHeader;
GO

CREATE TABLE PesananHeader (
    PesananID INT IDENTITY(1,1) PRIMARY KEY,

    TanggalPesanan DATETIME2 NOT NULL,

    -- Ini adalah kolom Foreign Key
    PelangganID INT NOT NULL,

    StatusPesanan VARCHAR(10) NOT NULL,

    -- Mendefinisikan constraint FOREIGN KEY (out-of-line)
    CONSTRAINT FK_Pesanan_Pelanggan
    FOREIGN KEY (PelangganID)
    REFERENCES Pelanggan(PelangganID),

    CONSTRAINT CHK_StatusPesanan
    CHECK (StatusPesanan IN ('Baru', 'Proses', 'Selesai'))
);

-- Cek relasi
EXEC sp_help 'PesananHeader';