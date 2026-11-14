# 👤 Module 02: Profile & Settings (`PROF`)

- **Requirement Reference:** `REQ-02` — Profile Customization & Protected Route Access Control
- **Test Execution Report:** [`TestRun1_Batch1_AUTH_PROF.pdf`](../../Test_Reports/TestRun1_Batch1_AUTH_PROF.pdf)
- **Ringkasan Hasil:** 4 Test Cases | **1 Passed**, **3 Failed** (`CON-2`, `CON-3`, `CON-4`) | Pass Rate: **25,00%**

---

### 1. `TC-PROF-001` — Memperbarui bio dan URL foto profil pengguna
- **Type:** `Functional` | **Priority:** `High` | **Status:** `Failed` | **Defect:** `CON-2`
- **Preconditions:** Pengguna sudah *login* dan membuka halaman *Settings* (`/settings`).
- **Steps:**
  1. Periksa data akun yang muncul pada *form* *Settings*.
  2. Ubah teks pada kolom *Short bio about you* dan masukkan URL gambar yang valid pada kolom *URL of profile picture*.
  3. Klik tombol *Update Settings*.
- **Expected Result:** *Form* menampilkan data akun yang sedang aktif secara akurat dan seluruh perubahan profil tersimpan dengan benar.
- **Actual Result & Evidence:** Halaman `/settings` menampilkan *stale username* dari sesi akun sebelumnya serta kolom *Email* dalam keadaan kosong, padahal respons `GET /api/user` di tab Network DevTools membawa data akun aktif yang valid. Lihat bukti: [`BUG-PROF-001_Stale_User_State_In_Settings.png`](../../Bug_Reports/evidence/BUG-PROF-001_Stale_User_State_In_Settings.png).

---

### 2. `TC-PROF-002` — Memperbarui password pengguna dan login ulang dengan password baru
- **Type:** `Functional` | **Priority:** `High` | **Status:** `Passed`
- **Preconditions:** Pengguna sudah *login* dan membuka halaman *Settings* (`/settings`).
- **Steps:**
  1. Isi kolom *New Password* dengan kata sandi baru yang valid, lalu klik *Update Settings*.
  2. Lakukan *Logout*, kemudian masuk kembali (*Sign in*) menggunakan *password* baru tersebut.
- **Expected Result:** Kata sandi berhasil diperbarui dan pengguna dapat *login* kembali tanpa kendala menggunakan *password* baru.

---

### 3. `TC-PROF-101` — Menyimpan URL foto profil dengan format URL tidak valid
- **Type:** `Functional` | **Priority:** `Low` | **Status:** `Failed` | **Defect:** `CON-3`
- **Preconditions:** Pengguna sudah *login* dan membuka halaman *Settings* (`/settings`).
- **Steps:**
  1. Isi kolom *URL of profile picture* dengan *string* acak yang bukan format URL gambar (contoh: `bukan-url-gambar`).
  2. Klik tombol *Update Settings*, lalu periksa tampilan foto profil pada halaman profil pengguna.
- **Expected Result:** Sistem menolak format URL yang tidak valid atau menampilkan gambar *avatar fallback* bawaan ketika gambar gagal dimuat.
- **Actual Result & Evidence:** *String* non-URL tetap tersimpan ke data profil tanpa validasi format dan merender ikon gambar rusak (*broken image*) pada halaman profil maupun kartu artikel. Lihat bukti: [`TC-PROF-101_Broken_Profile_Image.png`](../../Bug_Reports/evidence/TC-PROF-101_Broken_Profile_Image.png).

---

### 4. `TC-PROF-201` — Mengakses rute terproteksi (`/settings` atau `/editor`) secara langsung tanpa login
- **Type:** `Other` | **Priority:** `High` | **Status:** `Failed` | **Defect:** `CON-4`
- **Preconditions:** Pengguna dalam keadaan belum *login* (*logged out*).
- **Steps:**
  1. Ketik dan akses URL `https://conduit.bondaracademy.com/settings` atau `/editor` secara langsung melalui *address bar* browser.
- **Expected Result:** Sistem mengalihkan (*redirect*) pengguna ke halaman *Home* atau *Sign in* dengan tampilan antarmuka yang ter-render normal.
- **Actual Result & Evidence:** Mekanisme *redirect* mengembalikan URL ke halaman utama (`/`), tetapi komponen tampilan gagal di-render sehingga layar hanya menampilkan halaman putih kosong (*blank white screen*). Lihat bukti: [`TC-PROF-201_Blank_Home_After_Redirect.png`](../../Bug_Reports/evidence/TC-PROF-201_Blank_Home_After_Redirect.png).