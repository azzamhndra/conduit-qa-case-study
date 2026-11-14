# 📊 Test Summary Report (TSR) – Conduit Web Application

> 📌 **Ringkasan Eksekutif & Status Rilis**
> Laporan ini merangkum hasil akhir pengujian fungsional dan eksplorasi pada **Conduit Web Application** (`Release 1.0`). Dari total **35 test case** yang dijalankan di TestRail, tercatat **29 skenario Passed** dan **6 skenario Failed** (*Pass Rate*: **82,86%**). Karena masih ditemukan **2 defect berstatus Major (`CON-2` dan `CON-4`)** yang berdampak langsung pada integritas *session state* dan *rendering* halaman utama, status rilis ditetapkan sebagai **HOLD RELEASE**.

---

## 📑 Version History

| Version | Date | Author | Reviewer | Keterangan |
| :--- | :--- | :--- | :--- | :--- |
| `1.0-final` | 14 Nov 2026 | @Azza | QA Baseline Approved | Laporan akhir eksekusi Batch 1 & Batch 2 yang disinkronkan dengan TestRail dan Jira Cloud |

---

## 1. Informasi Umum Pengujian

| Atribut Pengujian | Detail |
| :--- | :--- |
| **Nama Proyek** | End-to-End Manual QA Testing — Conduit Web Application |
| **Application Under Test (AUT)** | [https://conduit.bondaracademy.com](https://conduit.bondaracademy.com) (*Angular SPA*) |
| **Versi Build** | Release 1.0 |
| **Tanggal Eksekusi** | 14 November 2026 |
| **Test Environment** | Google Chrome Desktop (`Windows`) & Chrome DevTools (*Network Fetch/XHR*, *Console*, *Application*) |
| **Akun Uji Terisolasi** | `qa_author_01` (Author / Pembuat Artikel) & `qa_reader_01` (Reader / Interaksi Sosial via *Incognito*) |
| **Tools** | TestRail Cloud (*Test Execution*) & Jira Cloud (`Project Key: CON`) |
| **QA Engineer** | `@Azza` |

---

## 2. Ringkasan Eksekusi Pengujian (Test Execution Metrics)

Eksekusi dibagi ke dalam dua *Test Run* terpisah di TestRail untuk mencegah pencampuran *client-side state* antar-sesi akun:
- **Test Run 1 (`Batch 1`):** Modul `Authentication (AUTH)` & `Profile & Settings (PROF)` — [`TestRun1_Batch1_AUTH_PROF.pdf`](./TestRun1_Batch1_AUTH_PROF.pdf)
- **Test Run 2 (`Batch 2`):** Modul `Article Management (ART)`, `Social Interaction (SOC)` & `Feed & Navigation (FEED)` — [`TestRun2_Batch2_ART_SOC_FEED.pdf`](./TestRun2_Batch2_ART_SOC_FEED.pdf)

| Modul Pengujian | Req ID | Total TC | Passed | Failed | Blocked | Pass Rate | Defect Density |
| :--- | :---: | :---: | :---: | :---: | :---: | :---: | :---: |
| **Authentication (`AUTH`)** | `REQ-01` | 10 | 9 | 1 | 0 | 90,00% | 10,00% |
| **Profile & Settings (`PROF`)** | `REQ-02` | 4 | 1 | 3 | 0 | 25,00% | 75,00% |
| **Article Management (`ART`)** | `REQ-03` | 10 | 9 | 1 | 0 | 90,00% | 10,00% |
| **Social Interaction (`SOC`)** | `REQ-04` | 7 | 6 | 1 | 0 | 85,71% | 14,29% |
| **Feed & Navigation (`FEED`)** | `REQ-05` | 4 | 4 | 0 | 0 | 100,00% | 0,00% |
| **Total Keseluruhan** | **5 Reqs** | **35** | **29** | **6** | **0** | **82,86%** | **17,14%** |

---

## 3. Daftar Temuan Defect & Analisis Akar Masalah

Seluruh skenario yang gagal telah dilaporkan ke **Jira Cloud** (`CON-1` hingga `CON-6`), dilengkapi bukti tangkapan layar UI maupun log jaringan API dari Chrome DevTools, serta tertaut langsung ke hasil eksekusi TestRail.

| Jira ID | Test Case ID | Modul | Ringkasan Bug | Severity | Priority | Status | Bukti |
| :--- | :--- | :---: | :--- | :---: | :---: | :---: | :--- |
| **CON-1** | `TC-AUTH-103` | `AUTH` | Validasi form registrasi meloloskan format email tidak lengkap tanpa domain (contoh: `qatest@`) | Minor | Medium | To Do | [Screenshot](../Bug_Reports/evidence/TC-AUTH-103_Invalid_Email_Accepted.png) |
| **CON-2** | `TC-PROF-001` | `PROF` | Halaman `/settings` menampilkan *stale username* sesi sebelumnya dan kolom email kosong meski respons `GET /api/user` valid | **Major** | **High** | To Do | [Screenshot](../Bug_Reports/evidence/BUG-PROF-001_Stale_User_State_In_Settings.png) |
| **CON-3** | `TC-PROF-101` | `PROF` | URL foto profil tidak valid tetap tersimpan tanpa validasi dan merender ikon *broken image* tanpa *fallback* | Minor | Low | To Do | [Screenshot](../Bug_Reports/evidence/TC-PROF-101_Broken_Profile_Image.png) |
| **CON-4** | `TC-PROF-201` | `PROF` | Akses langsung ke `/settings` atau `/editor` tanpa *login* melakukan *redirect* yang menghasilkan *blank white screen* di Home | **Major** | **High** | To Do | [Screenshot](../Bug_Reports/evidence/TC-PROF-201_Blank_Home_After_Redirect.png) |
| **CON-5** | `TC-ART-201` | `ART` | Publikasi artikel dengan judul >250 karakter gagal tanpa pesan validasi error pada UI (*silent failure*) | Minor | Medium | To Do | [Screenshot](../Bug_Reports/evidence/TC-ART-201_Silent_Failure_Long_Title.png) |
| **CON-6** | `TC-SOC-101` | `SOC` | Komentar yang hanya berisi karakter spasi (`"     "`) lolos validasi dan terposting sebagai kartu komentar kosong | Minor | Low | To Do | [Screenshot](../Bug_Reports/evidence/TC-SOC-101_Whitespace_Comment_Accepted.png) |

### Distribusi Defect Berdasarkan Tingkat Keparahan (Severity)
- **Critical / Blocker:** `0` defect (0,00%)
- **Major:** `2` defect (`CON-2`, `CON-4` — 33,33%)
- **Minor:** `4` defect (`CON-1`, `CON-3`, `CON-5`, `CON-6` — 66,67%)

---

## 4. Evaluasi Exit Criteria & Keputusan Release Readiness

Evaluasi kelayakan rilis mengacu langsung pada *Quality & Acceptance Criteria* yang telah ditetapkan di dalam [Master Test Plan](../Test_Plans/README.md):

| Kriteria Kelulusan (Exit Criteria) | Target Baseline | Hasil Aktual | Status |
| :--- | :---: | :---: | :---: |
| **Test Case Execution** | ≥95% (minimal 34/35 TCs) | 100% (35/35 TCs dieksekusi) | ✅ Terpenuhi |
| **Requirement Coverage (RTM)** | Semua REQ dipetakan | `REQ-01`–`REQ-04`: 100%; `REQ-05`: 90% (sesuai RTM) | ⚠️ Parsial |
| **Defect Critical / Blocker berstatus To Do** | `0` Defect | `0` Defect | ✅ Terpenuhi |
| **Defect Major berstatus To Do** | `0` Defect | `2` Defect (`CON-2`, `CON-4`) | ❌ Belum Terpenuhi |
| **Minimum Pass Rate** | ≥ 95,00% | 82,86% | ❌ Belum Terpenuhi |
| **Traceability Defect (Jira $\leftrightarrow$ TestRail)** | 100% Tertaut | 100% (6/6 tiket tertaut) | ✅ Terpenuhi |

### Keputusan Akhir: **HOLD RELEASE**

Aplikasi **belum direkomendasikan untuk naik ke tahap produksi** hingga dua temuan *Major* selesai diperbaiki dan lulus verifikasi ulang:

1. **Kestabilan Fitur Inti (*Happy Path*):** Seluruh alur utama pengguna—mulai dari registrasi, autentikasi, pembuatan hingga penghapusan artikel, *render* format Markdown, proteksi *double-click* saat publikasi, komentar, *favorite*, *follow*, filter *tag*, hingga *pagination*—berjalan sesuai spesifikasi tanpa kendala kritikal.
2. **Kerentanan State Management (`PROF`):** Modul `Profile & Settings` mencatat *pass rate* terendah (**25,00%**) akibat dua *defect* Major:
   - **`CON-2`:** Kegagalan sinkronisasi *state* komponen Angular pada halaman `/settings` setelah pergantian akun (*stale state*), padahal payload `GET /api/user` dari server sudah sesuai.
   - **`CON-4`:** Kegagalan *rendering* komponen halaman utama (`Home`) setelah mekanisme *Angular Router Guard* mengalihkan akses langsung ke rute terproteksi (`/settings` atau `/editor`) dari sesi belum *login*.
3. **Celah Validasi Input Sisi Client:** Empat temuan *Minor* (`CON-1`, `CON-3`, `CON-5`, `CON-6`) menunjukkan belum konsistennya validasi di sisi *frontend* (format email tanpa domain, format URL avatar, pembatasan `maxlength` judul artikel, serta sanitasi `.trim()` pada kolom komentar).

---

## 5. Rekomendasi Tindak Lanjut (Next Steps)

1. **Prioritas Perbaikan Utama:** Tim pengembang memfokuskan perbaikan pada tiket **`CON-2`** (pembersihan *state* sesi saat *logout* dan sinkronisasi *data binding* `GET /api/user`) serta **`CON-4`** (perbaikan siklus *redirect* komponen pada *Angular Router Guard*).
2. **Siklus Retest & Smoke Regression:** Setelah perbaikan dirilis ke *environment* uji, QA akan melakukan *re-testing* terhadap seluruh tiket `CON-1`–`CON-6`, dilanjutkan *smoke regression testing* pada modul `AUTH` dan `PROF` sebelum meninjau ulang keputusan rilis menjadi **GO RELEASE**.

---

## 6. Artefak Terkait

- **Dokumen Perencanaan:** [Master Test Plan](../Test_Plans/README.md)
- **Repositori Skenario Pengujian:** [`Test_Cases/README.md`](../Test_Cases/README.md)
- **Laporan Eksekusi TestRail:** [`TestRun1_Batch1_AUTH_PROF.pdf`](./TestRun1_Batch1_AUTH_PROF.pdf) | [`TestRun2_Batch2_ART_SOC_FEED.pdf`](./TestRun2_Batch2_ART_SOC_FEED.pdf)
- **Data Ekspor Bug Jira:** [`Jira_Bugs_CON1-CON6.csv`](../Bug_Reports/Jira_Bugs_CON1-CON6.csv)