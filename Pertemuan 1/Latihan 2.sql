CREATE TABLE Pelanggan (
    -- IDENTITY(1,1) adalah sintaks SQL Server untuk auto-increment
    -- Dimulai dari 1, bertambah 1 setiap ada data baru.
    PelangganID INT IDENTITY(1,1) PRIMARY KEY,

    NamaDepan VARCHAR(50) NOT NULL,
    NamaBelakang VARCHAR(50) NULL,

    Email VARCHAR(100) NOT NULL UNIQUE,

    TanggalDaftar DATE DEFAULT GETDATE()
);

-- Cek struktur dan constraint
EXEC sp_help 'Pelanggan';