# 📝 Module 03: Article Management (`ART`)

- **Requirement Reference:** `REQ-03` — Article CRUD, Markdown Rendering & Input Boundaries
- **Test Execution Report:** [`TestRun2_Batch2_ART_SOC_FEED.pdf`](../../Test_Reports/TestRun2_Batch2_ART_SOC_FEED.pdf)
- **Ringkasan Hasil:** 10 Test Cases | **9 Passed**, **1 Failed** (`CON-5`) | Pass Rate: **90,00%**

---

### 1. `TC-ART-001` — Buat artikel baru dengan seluruh field terisi lengkap
- **Type:** `Functional` | **Priority:** `High` | **Status:** `Passed`
- **Preconditions:** Pengguna sudah *login* (`qa_author_01`) dan berada di halaman utama (*Home*).
- **Steps:**
  1. Klik menu *New Article* pada bilah navigasi.
  2. Isi *Article Title* (`Panduan Dasar QA Manual untuk Pemula`), *What's this article about?* (`Pengenalan fundamental software testing dan siklus hidup bug`), *Write your article*, dan *Enter tags* (`qa`, lalu tekan Enter).
  3. Klik tombol *Publish Article*.
- **Expected Result:** Artikel berhasil diterbitkan, pengguna diarahkan ke halaman detail artikel, dan seluruh isi konten beserta *tag* tampil sesuai input.

---

### 2. `TC-ART-002` — Buat artikel baru tanpa mengisi kolom Tags
- **Type:** `Functional` | **Priority:** `Medium` | **Status:** `Passed`
- **Preconditions:** Pengguna sudah *login* dan berada di halaman *New Article* (`/editor`).
- **Steps:**
  1. Isi *Article Title*, *Description*, dan *Body* menggunakan teks yang valid.
  2. Biarkan kolom *Enter tags* tetap kosong.
  3. Klik tombol *Publish Article*.
- **Expected Result:** Artikel tetap berhasil diterbitkan tanpa kendala karena kolom *Tags* bersifat opsional.

---

### 3. `TC-ART-003` — Menyunting (Edit) artikel milik sendiri
- **Type:** `Functional` | **Priority:** `High` | **Status:** `Passed`
- **Preconditions:** Pengguna sudah memiliki minimal satu artikel yang telah diterbitkan.
- **Steps:**
  1. Buka halaman detail artikel milik sendiri, lalu klik tombol *Edit Article*.
  2. Perbarui teks pada kolom *Article Title* dan *Write your article*.
  3. Klik tombol *Publish Article*.
- **Expected Result:** Perubahan tersimpan dan konten terbaru langsung tampil pada halaman detail artikel maupun di *Global Feed*.

---

### 4. `TC-ART-004` — Menghapus (Delete) artikel milik sendiri
- **Type:** `Functional` | **Priority:** `High` | **Status:** `Passed`
- **Preconditions:** Pengguna sedang membuka halaman detail artikel miliknya sendiri.
- **Steps:**
  1. Klik tombol *Delete Article*.
- **Expected Result:** Artikel terhapus secara permanen, pengguna diarahkan kembali ke *Home*, dan artikel tersebut tidak lagi muncul di *Global Feed* maupun tab *My Articles*.

---

### 5. `TC-ART-101` — Buat artikel dengan mengosongkan kolom Title
- **Type:** `Functional` | **Priority:** `High` | **Status:** `Passed`
- **Preconditions:** Pengguna sudah *login* dan berada di halaman *New Article* (`/editor`).
- **Steps:**
  1. Kosongkan kolom *Article Title*.
  2. Isi kolom *Description* dan *Body* dengan teks yang valid.
  3. Klik tombol *Publish Article*.
- **Expected Result:** Publikasi ditolak dan muncul pesan validasi error (*"title can't be blank"*).

---

### 6. `TC-ART-102` — Buat artikel dengan mengosongkan kolom Description
- **Type:** `Functional` | **Priority:** `Medium` | **Status:** `Passed`
- **Preconditions:** Pengguna sudah *login* dan berada di halaman *New Article* (`/editor`).
- **Steps:**
  1. Isi kolom *Article Title* dan *Body* dengan teks yang valid.
  2. Kosongkan kolom *What's this article about?* (*Description*).
  3. Klik tombol *Publish Article*.
- **Expected Result:** Publikasi ditolak dan muncul pesan validasi error (*"description can't be blank"*).

---

### 7. `TC-ART-103` — Buat artikel dengan mengosongkan kolom Body
- **Type:** `Functional` | **Priority:** `High` | **Status:** `Passed`
- **Preconditions:** Pengguna sudah *login* dan berada di halaman *New Article* (`/editor`).
- **Steps:**
  1. Isi kolom *Article Title* dan *Description* dengan teks yang valid.
  2. Kosongkan kolom *Write your article* (*Body*).
  3. Klik tombol *Publish Article*.
- **Expected Result:** Publikasi ditolak dan muncul pesan validasi error (*"body can't be blank"*).

---

### 8. `TC-ART-201` — Input karakter sangat panjang (>250 karakter) pada Title
- **Type:** `Other` | **Priority:** `Low` | **Status:** `Failed` | **Defect:** `CON-5`
- **Preconditions:** Pengguna sudah *login* dan berada di halaman *New Article* (`/editor`).
- **Steps:**
  1. Masukkan rangkaian teks sepanjang lebih dari 250 karakter (276 karakter) pada kolom *Article Title*.
  2. Isi *Description* dan *Body* dengan teks valid, lalu klik tombol *Publish Article*.
  3. Periksa respons sistem serta tampilan judul pada UI.
- **Expected Result:** Sistem membatasi panjang karakter (`maxlength`) atau menampilkan pesan validasi error yang jelas ketika judul melebihi batas *server*.
- **Actual Result & Evidence:** *Server* menolak penyimpanan judul >250 karakter (`POST /api/articles` gagal di tab Network DevTools), namun *frontend* tidak memiliki pembatasan panjang karakter maupun menampilkan pesan error ke UI (*silent failure*). Lihat bukti: [`TC-ART-201_Silent_Failure_Long_Title.png`](../../Bug_Reports/evidence/TC-ART-201_Silent_Failure_Long_Title.png).

---

### 9. `TC-ART-202` — Render format Markdown pada isi artikel (Body)
- **Type:** `Functional` | **Priority:** `Medium` | **Status:** `Passed`
- **Preconditions:** Pengguna sudah *login* dan berada di halaman *New Article* (`/editor`).
- **Steps:**
  1. Isi *Title* dan *Description* dengan teks valid.
  2. Pada kolom *Body*, ketik sintaks Markdown (`# Heading Satu`, `**teks cetak tebal**`, dan `- Poin pertama`).
  3. Klik tombol *Publish Article*.
- **Expected Result:** Halaman detail artikel me-render elemen HTML sesuai format Markdown (heading besar, huruf tebal, dan daftar poin), bukan menampilkan simbol mentahnya.

---

### 10. `TC-ART-203` — Klik tombol Publish Article dua kali dengan cepat (Double-Click)
- **Type:** `Other` | **Priority:** `Medium` | **Status:** `Passed`
- **Preconditions:** Pengguna sudah *login* dan mengisi seluruh kolom *New Article* secara lengkap.
- **Steps:**
  1. Klik tombol *Publish Article* sebanyak dua kali berturut-turut dengan cepat (*double-click*).
  2. Periksa daftar artikel pada *Global Feed* maupun tab *My Articles* di halaman profil.
- **Expected Result:** Tombol otomatis nonaktif (*disabled*) selama proses pengiriman berlangsung sehingga hanya terbentuk **1 artikel** tanpa duplikasi.