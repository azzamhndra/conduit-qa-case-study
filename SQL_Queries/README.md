# 🗄️ SQL Data Validation & QA Audit — Conduit (`MySQL`)

![Database](https://img.shields.io/badge/Database-MySQL%20%2F%20MariaDB%2026.10-blue)
![Validation Queries](https://img.shields.io/badge/Audit%20Queries-8%20Sets-success)

## Ringkasan Validasi Database

Direktori ini mendokumentasikan skema relasional, data contoh (*seed data*), serta kumpulan kueri audit integritas data untuk aplikasi web **Conduit** menggunakan **MySQL 8.0**. Skema lokal ini merupakan model simulasi, bukan database production Conduit. Seed data merepresentasikan anomali yang berkaitan dengan temuan *defect* manual (seperti format email tidak valid `CON-1`, batas judul `CON-5`, dan komentar spasi kosong `CON-6`).

Skrip skema tidak menghapus tabel secara default. Blok reset yang bersifat destruktif dikomentari; aktifkan hanya untuk database QA lokal sekali pakai setelah memastikan data di dalamnya boleh dihapus.

---

## Struktur Skema Relasional & Artefak

| Komponen | Keterangan |
| :--- | :--- |
| **Database Engine** | MySQL (Charset `utf8mb4`, Engine `InnoDB`) |
| **Skema & Seed Data** | [`schema_and_seed.sql`](./schema_and_seed.sql) |
| **Kueri Audit QA** | [`data_integrity.sql`](./data_integrity.sql) |

### Daftar Tabel Utama (`conduit_qa_db`)
1. `users`: Menyimpan informasi akun pengguna (kredensial, bio, URL avatar).
2. `articles`: Menyimpan data artikel utama (`slug`, `title`, `description`, `body`, relasi ke `author_id`).
3. `comments`: Menyimpan ulasan/komentar pada artikel.
4. `tags` & `article_tags`: Menangani pengelolaan *tag* artikel secara *many-to-many*.
5. `favorites`: Relasi *likes* artikel oleh pengguna.
6. `follows`: Relasi pertemanan antar-pengguna untuk mendukung lini masa *Your Feed*.

---

## Cakupan Skenario Kueri Audit (`data_integrity.sql`)

| No | ID Kueri | Nama Audit & Tujuan | Temuan QA / Catatan Teknis |
| :--- | :--- | :--- | :--- |
| 1 | `SQL-VAL-001` | Audit Kualitas Data Profil (`CON-1` & `CON-3`) | Mendeteksi email tanpa domain (`qatest@` -> `FAILED`) dan format URL avatar tidak valid. |
| 2 | `SQL-VAL-002` | Verifikasi Global Feed & Agregasi Tag | Menggabungkan tabel `articles`, `users`, dan `tags` menggunakan `GROUP_CONCAT`. |
| 3 | `SQL-VAL-003` | Rekonsiliasi Jumlah Favorite (`favoritesCount`) | Memastikan angka penghitung *like* di UI/API akurat dengan agregasi tabel `favorites`. |
| 4 | `SQL-VAL-004` | Validasi Personalized Feed / Your Feed | Memverifikasi artikel di lini masa *Your Feed* hanya berasal dari penulis yang di-*follow*. |
| 5 | `SQL-VAL-005` | Validasi Filter Popular Tags | Menghitung frekuensi penggunaan tiap *tag* untuk panel navigasi samping. |
| 6 | `SQL-VAL-006` | Audit Sanitasi Komentar (`CON-6`) | Mendeteksi komentar kosong atau hanya berisi spasi (`"     "` -> `FAILED` karena kurang `TRIM`). |
| 7 | `SQL-VAL-007` | Pemeriksaan Referential Integrity (Orphan Check) | Memeriksa orphan pada seluruh relasi foreign key dalam model (`users`, `articles`, `comments`, `tags`, `article_tags`, `favorites`, `follows`). |
| 8 | `SQL-VAL-008` | Verifikasi Batas Kolom Title (`CON-5`) | Mengonfirmasi batasan kolom skema `VARCHAR(250)` pada tabel `articles`. |

---

## Catatan Eksekusi

Kueri dijalankan pada database lokal MySQL yang dibentuk oleh `schema_and_seed.sql`. Hasilnya hanya memvalidasi model dan seed data simulasi, bukan data live pada layanan Conduit. Screenshot hasil eksekusi tidak disertakan dalam repositori ini.