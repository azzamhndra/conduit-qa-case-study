# 🔐 Module 01: Authentication (`AUTH`)

- **Requirement Reference:** `REQ-01` — User Registration, Login & Session Logout
- **Test Execution Report:** [`TestRun1_Batch1_AUTH_PROF.pdf`](../../Test_Reports/TestRun1_Batch1_AUTH_PROF.pdf)
- **Ringkasan Hasil:** 10 Test Cases | **9 Passed**, **1 Failed** (`CON-1`) | Pass Rate: **90,00%**

---

### 1. `TC-AUTH-001` — Registrasi akun baru dengan data valid
- **Type:** `Functional` | **Priority:** `High` | **Status:** `Passed`
- **Preconditions:** Pengguna dalam kondisi belum *login* dan berada di halaman Sign Up (`/register`).
- **Steps:**
  1. Isi kolom *Username*, *Email*, dan *Password* menggunakan kombinasi data unik yang valid (contoh: `qa_author_01` / `qa_author_01@test.com`).
  2. Klik tombol *Sign up*.
- **Expected Result:** Akun berhasil didaftarkan, pengguna otomatis masuk (*logged in*), dan diarahkan ke halaman utama (*Home*) dengan nama profil tampil di bilah navigasi kanan atas.

---

### 2. `TC-AUTH-002` — Login menggunakan email dan password yang valid
- **Type:** `Functional` | **Priority:** `High` | **Status:** `Passed`
- **Preconditions:** Pengguna sudah memiliki akun terdaftar dan berada di halaman Sign In (`/login`).
- **Steps:**
  1. Masukkan *Email* dan *Password* yang sesuai dengan akun terdaftar.
  2. Klik tombol *Sign in*.
- **Expected Result:** Proses autentikasi berhasil dan pengguna diarahkan ke halaman utama dengan tab *Your Feed* aktif.

---

### 3. `TC-AUTH-003` — Logout dari sesi akun yang sedang aktif
- **Type:** `Functional` | **Priority:** `High` | **Status:** `Passed`
- **Preconditions:** Pengguna sudah *login* dan membuka halaman *Settings* (`/settings`).
- **Steps:**
  1. Gulir layar ke bagian paling bawah halaman *Settings*.
  2. Klik tombol *Or click here to logout*.
- **Expected Result:** Sesi berakhir, token JWT dihapus dari penyimpanan *browser*, dan bilah navigasi kembali menampilkan menu *Sign in* dan *Sign up*.

---

### 4. `TC-AUTH-101` — Registrasi menggunakan email yang sudah terdaftar
- **Type:** `Functional` | **Priority:** `High` | **Status:** `Passed`
- **Preconditions:** Pengguna berada di halaman Sign Up (`/register`).
- **Steps:**
  1. Masukkan *Username* baru yang belum terpakai, *Email* yang sudah terdaftar sebelumnya, dan *Password* valid.
  2. Klik tombol *Sign up*.
- **Expected Result:** Pendaftaran ditolak dan sistem menampilkan pesan validasi error (*"email has already been taken"*).

---

### 5. `TC-AUTH-102` — Registrasi menggunakan username yang sudah terdaftar
- **Type:** `Functional` | **Priority:** `Medium` | **Status:** `Passed`
- **Preconditions:** Pengguna berada di halaman Sign Up (`/register`).
- **Steps:**
  1. Masukkan *Username* yang sudah digunakan akun lain, *Email* baru yang valid, dan *Password* valid.
  2. Klik tombol *Sign up*.
- **Expected Result:** Pendaftaran ditolak dan sistem menampilkan pesan validasi error (*"username has already been taken"*).

---

### 6. `TC-AUTH-103` — Registrasi dengan format email tidak valid tanpa domain
- **Type:** `Functional` | **Priority:** `Medium` | **Status:** `Failed` | **Defect:** `CON-1`
- **Preconditions:** Pengguna berada di halaman Sign Up (`/register`).
- **Steps:**
  1. Masukkan *Username* valid, *Email* tanpa nama domain lengkap (contoh: `qatest@`), dan *Password* valid.
  2. Klik tombol *Sign up*.
- **Expected Result:** Sistem menolak format email yang tidak lengkap dan memunculkan pesan validasi error di *form*.
- **Actual Result & Evidence:** *Form* registrasi meloloskan input email tanpa domain (`qatest@`) dan tetap mengirimkan *request* ke *server* karena tidak ada validasi format email di sisi *frontend*. Lihat bukti: [`TC-AUTH-103_Invalid_Email_Accepted.png`](../../Bug_Reports/evidence/TC-AUTH-103_Invalid_Email_Accepted.png).

---

### 7. `TC-AUTH-104` — Registrasi dengan mengosongkan kolom wajib
- **Type:** `Functional` | **Priority:** `High` | **Status:** `Passed`
- **Preconditions:** Pengguna berada di halaman Sign Up (`/register`).
- **Steps:**
  1. Biarkan salah satu atau seluruh kolom (*Username*, *Email*, *Password*) dalam keadaan kosong.
  2. Klik tombol *Sign up*.
- **Expected Result:** Tombol *Sign up* tetap nonaktif (*disabled*) atau sistem memunculkan pesan error bahwa kolom wajib tidak boleh kosong.

---

### 8. `TC-AUTH-105` — Login menggunakan password yang salah
- **Type:** `Functional` | **Priority:** `High` | **Status:** `Passed`
- **Preconditions:** Pengguna berada di halaman Sign In (`/login`).
- **Steps:**
  1. Masukkan *Email* yang terdaftar dan kombinasi *Password* yang keliru.
  2. Klik tombol *Sign in*.
- **Expected Result:** Proses *login* ditolak dan muncul pesan error (*"email or password is invalid"*).

---

### 9. `TC-AUTH-106` — Login menggunakan email yang tidak terdaftar
- **Type:** `Functional` | **Priority:** `Medium` | **Status:** `Passed`
- **Preconditions:** Pengguna berada di halaman Sign In (`/login`).
- **Steps:**
  1. Masukkan alamat *Email* yang belum pernah didaftarkan beserta sembarang *Password*.
  2. Klik tombol *Sign in*.
- **Expected Result:** Proses *login* ditolak dan muncul pesan error (*"email or password is invalid"*).

---

### 10. `TC-AUTH-201` — Login dengan spasi di awal/akhir pada kolom email
- **Type:** `Other` | **Priority:** `Low` | **Status:** `Passed`
- **Preconditions:** Pengguna berada di halaman Sign In (`/login`).
- **Steps:**
  1. Masukkan *Email* valid dengan tambahan spasi di bagian depan atau belakang (contoh: `" qa_author_01@test.com "`) serta *Password* valid.
  2. Klik tombol *Sign in*.
- **Expected Result:** Sistem memangkas spasi (*trim*) secara otomatis atau menolak input dengan pesan validasi yang jelas tanpa memicu error *server* (`500`).