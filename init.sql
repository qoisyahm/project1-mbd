-- ============================================================
-- 1. PEMBUATAN SKEMA & TABEL MAHASISWAS (Soal No. 3)
-- ============================================================
CREATE SCHEMA IF NOT EXISTS SALAM;

CREATE TABLE SALAM.mahasiswas (
    id SERIAL PRIMARY KEY,
    nim VARCHAR(15) UNIQUE NOT NULL,
    nama VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    ipk NUMERIC(3,2) CHECK (ipk >= 0.00 AND ipk <= 4.00),
    sks_tempuh INT CHECK (sks_tempuh >= 0 AND sks_tempuh <= 160),
    status_akademik VARCHAR(20) DEFAULT 'Aktif' CHECK (status_akademik IN ('Aktif', 'Cuti', 'Lulus', 'DO'))
);

INSERT INTO SALAM.mahasiswas (nim, nama, email, ipk, sks_tempuh, status_akademik)
VALUES 
('20230801001', 'Budi Santoso', 'budi@esaunggul.ac.id', 3.75, 84, 'Aktif'),
('20230801002', 'Siti Rahma', 'siti@esaunggul.ac.id', 3.80, 90, 'Aktif');


-- ============================================================
-- 2. PEMBUATAN USER & ROLE / HAK AKSES (Soal No. 4)
-- ============================================================

CREATE USER backend_dev WITH PASSWORD 'backend123';
GRANT USAGE ON SCHEMA SALAM TO backend_dev;
GRANT SELECT, INSERT, UPDATE, DELETE ON ALL TABLES IN SCHEMA SALAM TO backend_dev;
GRANT USAGE, SELECT ON ALL SEQUENCES IN SCHEMA SALAM TO backend_dev;
ALTER DEFAULT PRIVILEGES IN SCHEMA SALAM GRANT SELECT, INSERT, UPDATE, DELETE ON TABLES TO backend_dev;
ALTER DEFAULT PRIVILEGES IN SCHEMA SALAM GRANT USAGE, SELECT ON SEQUENCES TO backend_dev;

CREATE USER bi_dev WITH PASSWORD 'bidev123';
GRANT USAGE ON SCHEMA SALAM TO bi_dev;
GRANT SELECT ON ALL TABLES IN SCHEMA SALAM TO bi_dev;
ALTER DEFAULT PRIVILEGES IN SCHEMA SALAM GRANT SELECT ON TABLES TO bi_dev;

CREATE VIEW SALAM.v_rekap_mahasiswa AS
SELECT id, nim, nama, ipk, status_akademik FROM SALAM.mahasiswas;
GRANT SELECT ON SALAM.v_rekap_mahasiswa TO bi_dev;


CREATE USER data_engineer WITH PASSWORD 'dataeng123';
GRANT USAGE, CREATE ON SCHEMA SALAM TO data_engineer;
GRANT ALL PRIVILEGES ON ALL TABLES IN SCHEMA SALAM TO data_engineer;
GRANT ALL PRIVILEGES ON ALL SEQUENCES IN SCHEMA SALAM TO data_engineer;
ALTER DEFAULT PRIVILEGES IN SCHEMA SALAM GRANT ALL ON TABLES TO data_engineer;
ALTER DEFAULT PRIVILEGES IN SCHEMA SALAM GRANT ALL ON SEQUENCES TO data_engineer;