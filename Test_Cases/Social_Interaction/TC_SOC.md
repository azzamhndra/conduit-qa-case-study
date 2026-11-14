# 💬 Module 04: Social Interaction (`SOC`)

- **Requirement Reference:** `REQ-04` — Article Comments, Favorites & Author Following
- **Test Execution Report:** [`TestRun2_Batch2_ART_SOC_FEED.pdf`](../../Test_Reports/TestRun2_Batch2_ART_SOC_FEED.pdf)
- **Ringkasan Hasil:** 7 Test Cases | **6 Passed**, **1 Failed** (`CON-6`) | Pass Rate: **85,71%**

---

### 1. `TC-SOC-001` — Menambahkan komentar valid pada artikel
- **Type:** `Functional` | **Priority:** `High` | **Status:** `Passed`
- **Preconditions:** Pengguna sudah *login* (`qa_reader_01`) dan membuka halaman detail suatu artikel.
- **Steps:**
  1. Gulir ke bagian bawah artikel dan ketik komentar valid pada kotak *Write a comment...* (`Artikel yang sangat informatif dan mudah dipahami!`).
  2. Klik tombol *Post Comment*.
- **Expected Result:** Komentar langsung tampil pada daftar komentar di bawah artikel lengkap dengan nama penulis dan tanggal posting.

---

### 2. `TC-SOC-002` — Menghapus komentar milik sendiri
- **Type:** `Functional` | **Priority:** `Medium` | **Status:** `Passed`
- **Preconditions:** Pengguna sudah *login* dan memiliki komentar yang tampil pada suatu artikel.
- **Steps:**
  1. Klik ikon tempat sampah (*Delete*) di pojok kanan bawah kartu komentar milik sendiri.
- **Expected Result:** Komentar langsung terhapus dari daftar komentar artikel tersebut.

---

### 3. `TC-SOC-003` — Memberikan Favorite (Like) dari halaman Global Feed
- **Type:** `Functional` | **Priority:** `High` | **Status:** `Passed`
- **Preconditions:** Pengguna sudah *login* dan berada di halaman utama (*Global Feed*).
- **Steps:**
  1. Catat angka awal pada tombol ikon hati (*Favorite*) di salah satu artikel.
  2. Klik tombol ikon hati tersebut.
- **Expected Result:** Warna tombol berubah menjadi hijau solid (status aktif) dan angka penghitung *favorite* bertambah `+1`.

---

### 4. `TC-SOC-004` — Memberikan Favorite (Like) dari halaman Detail Artikel
- **Type:** `Functional` | **Priority:** `Medium` | **Status:** `Passed`
- **Preconditions:** Pengguna sudah *login* dan membuka halaman detail artikel yang belum di-*favorite*.
- **Steps:**
  1. Klik tombol *Favorite Article* pada banner atas atau bagian bawah artikel.
- **Expected Result:** Label tombol berubah menjadi *Unfavorite Article* dan angka penghitung *favorite* bertambah `+1`.

---

### 5. `TC-SOC-005` — Membatalkan Favorite (Unlike) pada artikel
- **Type:** `Functional` | **Priority:** `Medium` | **Status:** `Passed`
- **Preconditions:** Pengguna sudah *login* dan melihat artikel yang sebelumnya sudah di-*favorite*.
- **Steps:**
  1. Klik kembali tombol *Favorite* / *Unfavorite Article* pada artikel tersebut.
- **Expected Result:** Status aktif tombol hilang dan angka penghitung *favorite* berkurang `-1`.

---

### 6. `TC-SOC-006` — Follow dan Unfollow penulis lain
- **Type:** `Functional` | **Priority:** `High` | **Status:** `Passed`
- **Preconditions:** Pengguna sudah *login* dan membuka halaman profil milik penulis lain (`qa_author_01`).
- **Steps:**
  1. Klik tombol *Follow [Username]*.
  2. Setelah status berubah, klik kembali tombol *Unfollow [Username]*.
- **Expected Result:** Label dan tampilan tombol berubah dinamis dari *Follow* menjadi *Unfollow*, lalu kembali ke *Follow* setelah diklik ulang.

---

### 7. `TC-SOC-101` — Mengirim komentar kosong atau hanya berisi spasi
- **Type:** `Functional` | **Priority:** `Low` | **Status:** `Failed` | **Defect:** `CON-6`
- **Preconditions:** Pengguna sudah *login* dan membuka halaman detail artikel.
- **Steps:**
  1. Biarkan kotak *Write a comment...* kosong, lalu uji kembali dengan mengisi karakter spasi saja (`"     "`).
  2. Klik tombol *Post Comment*.
- **Expected Result:** Sistem menolak pengiriman komentar kosong maupun spasi saja dan menampilkan pesan validasi error (*"body can't be blank"*).
- **Actual Result & Evidence:** Komentar yang benar-benar kosong berhasil ditolak, namun komentar yang hanya berisi karakter spasi lolos validasi dan terposting sebagai kartu komentar kosong tanpa teks karena tidak ada sanitasi `.trim()`. Lihat bukti: [`TC-SOC-101_Whitespace_Comment_Accepted.png`](../../Bug_Reports/evidence/TC-SOC-101_Whitespace_Comment_Accepted.png).