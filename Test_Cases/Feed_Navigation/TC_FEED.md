# 📰 Module 05: Feed & Navigation (`FEED`)

- **Requirement Reference:** `REQ-05` — Tag Filtering, Personalized Feed, Pagination & Profile Tabs
- **Test Execution Report:** [`TestRun2_Batch2_ART_SOC_FEED.pdf`](../../Test_Reports/TestRun2_Batch2_ART_SOC_FEED.pdf)
- **Ringkasan Hasil:** 4 Test Cases | **4 Passed**, **0 Failed** | Pass Rate: **100,00%**

---

### 1. `TC-FEED-001` — Filter artikel berdasarkan Popular Tags
- **Type:** `Functional` | **Priority:** `High` | **Status:** `Passed`
- **Preconditions:** Pengguna berada di halaman utama (*Home*) dan panel *Popular Tags* di sisi kanan menampilkan daftar *tag* aktif.
- **Steps:**
  1. Klik salah satu *tag* yang tersedia di dalam panel *Popular Tags*.
- **Expected Result:** Muncul tab baru `#nama-tag` di sebelah *Global Feed*, dan daftar artikel yang tampil terfilter hanya menampilkan artikel yang memiliki *tag* tersebut.

---

### 2. `TC-FEED-002` — Verifikasi konten Your Feed setelah mem-follow penulis
- **Type:** `Functional` | **Priority:** `High` | **Status:** `Passed`
- **Preconditions:** Pengguna sudah *login* (`qa_reader_01`) dan telah melakukan *Follow* pada minimal satu penulis yang memiliki artikel (`qa_author_01`).
- **Steps:**
  1. Kembali ke halaman utama (*Home*).
  2. Klik tab *Your Feed*.
- **Expected Result:** Artikel-artikel yang diterbitkan oleh penulis yang sudah di-*follow* tampil pada lini masa *Your Feed*.

---

### 3. `TC-FEED-003` — Navigasi Pagination antar halaman di Global Feed
- **Type:** `Functional` | **Priority:** `Medium` | **Status:** `Passed`
- **Preconditions:** Terdapat lebih dari 10 artikel di *Global Feed* sehingga navigasi nomor halaman (*pagination*) muncul di bagian bawah daftar artikel.
- **Steps:**
  1. Gulir layar ke bagian paling bawah daftar *Global Feed*.
  2. Klik nomor halaman `2`, lalu klik kembali nomor halaman `1`.
- **Expected Result:** Daftar artikel berpindah menampilkan konten halaman ke-2, dan indikator tombol halaman aktif ikut berpindah sesuai halaman yang dipilih.

---

### 4. `TC-FEED-004` — Verifikasi tab My Articles dan Favorited Articles di profil
- **Type:** `Functional` | **Priority:** `Medium` | **Status:** `Passed`
- **Preconditions:** Pengguna sudah *login*, memiliki minimal 1 artikel buatan sendiri, dan telah me-*favorite* minimal 1 artikel.
- **Steps:**
  1. Klik nama profil sendiri pada bilah navigasi kanan atas.
  2. Periksa daftar artikel yang muncul pada tab *My Articles*.
  3. Klik tab *Favorited Articles* dan periksa daftar artikel di dalamnya.
- **Expected Result:** Artikel buatan sendiri tampil di tab *My Articles*, sedangkan artikel yang di-*favorite* tampil di tab *Favorited Articles*.