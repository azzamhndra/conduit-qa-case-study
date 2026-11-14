# Conduit QA Portfolio – Project Overview

> ⚠️ **Catatan Referensi & Cakupan Portofolio**
> Dokumen ini merangkum proyek dan strategi pengujian *end-to-end* untuk **Release 1.0** pada **Conduit Web Application** (`https://conduit.bondaracademy.com`). Dokumen Master Test Plan tersedia di [`Test_Plan/README.md`](./Test_Plan/README.md).
> Tautan berikut mengarah ke artefak yang tersedia di repositori ini:
> - Skenario Pengujian: [`Test_Cases/README.md`](./Test_Cases/README.md)
> - Ekspor Defect & Bukti Reproduksi: [`Jira_Bugs_CON1-CON6.csv`](./Bug_Reports/Jira_Bugs_CON1-CON6.csv)
> - Laporan Akhir & Keputusan Rilis: [`Test_Reports/README.md`](./Test_Reports/README.md)
> - Pengujian Otomatis API: [`API_Testing/README.md`](./API_Testing/README.md)
> - Validasi Integritas Database: [`SQL_Queries/README.md`](./SQL_Queries/README.md)

---

## 📑 Version History

| Version | Date | Author | Reviewer | Keterangan |
| :--- | :--- | :--- | :--- | :--- |
| `0.1-draft` | 10 Nov 2026 | @Azza | Self-Review | Penyusunan awal *scope*, pemetaan *requirement* (`REQ-01`–`REQ-05`), dan konfigurasi *environment* |
| `0.2-draft` | 12 Nov 2026 | @Azza | Self-Review | Penambahan struktur 35 *test case*, strategi eksekusi per *batch* di TestRail, dan alur pelaporan *bug* di Jira |
| `1.0-final` | 14 Nov 2026 | @Azza | QA Baseline Approved | Finalisasi *Master Test Plan* yang sudah disinkronkan dengan hasil eksekusi TestRail & Jira |

---

## 📑 Table of Contents

1. [🎯 Stakeholders](#-stakeholders)
2. [🔍 1. Dampak Spesifik Proyek terhadap Pengujian](#-1-dampak-spesifik-proyek-terhadap-pengujian)
3. [📦 2. Scope Pengujian](#-2-scope-pengujian)
   - [✅ 2.1 In Scope](#-21-in-scope)
   - [❌ 2.2 Out of Scope](#-22-out-of-scope)
   - [🧰 2.3 Sistem Pihak Ketiga (Third-Party Systems)](#-23-sistem-pihak-ketiga-third-party-systems)
   - [🤝 2.4 Sistem yang Divalidasi Pihak Eksternal](#-24-sistem-yang-divalidasi-pihak-eksternal)
4. [✅ 3. Kriteria Kualitas dan Acceptance Criteria](#-3-kriteria-kualitas-dan-acceptance-criteria)
5. [🧪 4. Deskripsi Proses Pengujian (Test Process)](#-4-deskripsi-proses-pengujian-test-process)
   - [🔍 4.1 Gambaran Umum Testing Types](#-41-gambaran-umum-testing-types)
   - [🔍 4.2 Ringkasan Detail Testing Types](#-42-ringkasan-detail-testing-types)
   - [📌 4.3 Manajemen Task di Jira](#-43-manajemen-task-di-jira)
   - [🐞 4.4 Manajemen Defect & Root Cause Analysis (RCA)](#-44-manajemen-defect--root-cause-analysis-rca)
   - [📋 4.5 Pengelolaan & Eksekusi Test Case](#-45-pengelolaan--eksekusi-test-case)
   - [📊 4.6 Struktur Laporan Pengujian (Test Report)](#-46-struktur-laporan-pengujian-test-report)
   - [📐 4.7 Daftar Metrik yang Dipantau (Project Metrics)](#-47-daftar-metrik-yang-dipantau-project-metrics)
6. [⚠️ 5. Risiko dan Asumsi (Risks & Assumptions)](#-5-risiko-dan-asumsi-risks--assumptions)
   - [⚠️ 5.1 Risiko (Risks)](#-51-risiko-risks)
   - [🧾 5.2 Asumsi (Assumptions)](#-52-asumsi-assumptions)
7. [📱 6. Perangkat Pengujian (Devices)](#-6-perangkat-pengujian-devices)
8. [🛠️ 7. Toolset](#-7-toolset)
9. [🌐 8. Test Environments](#-8-test-environments)
10. [📣 9. Communication Plan](#-9-communication-plan)
11. [🚨 10. Escalation Plan](#-10-escalation-plan)
12. [🗓️ 11. Test Schedule](#-11-test-schedule)
    - [📅 11.1 Sprint Schedule](#-111-sprint-schedule)
    - [📅 11.2 Phase Schedule](#-112-phase-schedule)
13. [🧾 12. Test Deliverables](#-12-test-deliverables)

---

## 🎯 Stakeholders

Pembagian peran dan tanggung jawab pada siklus pengujian Conduit **Release 1.0** diatur sebagai berikut:

| Role | Tanggung Jawab | PIC / Referensi |
| :--- | :--- | :--- |
| **QA Engineer / Test Lead** | Penyusunan *Test Plan*, desain *test case*, eksekusi pengujian per *batch*, inspeksi API lewat DevTools, *triage* *defect*, serta penyusunan laporan akhir (*TSR*) | `@Azza` |
| **Product Owner / Business** | Penetapan *baseline* kebutuhan bisnis (`REQ-01`–`REQ-05`) dan persetujuan akhir *Release Readiness* | Spesifikasi RealWorld Conduit |
| **Frontend & Backend Dev Team** | Perbaikan tiket *bug* (`CON-1`–`CON-6`), sinkronisasi *state* aplikasi, serta perbaikan validasi pada sisi API | Tim Pengembang Conduit |

---

## 🔍 1. Dampak Spesifik Proyek terhadap Pengujian

- **Tujuan Utama:** Memastikan seluruh alur utama pengguna (*user journey*), konsistensi *client-side state*, batasan validasi input, dan tampilan UI berjalan sesuai spesifikasi pada platform *blogging* Conduit.
- **Tech Stack:** *Angular Single-Page Application (SPA)* yang terhubung ke JSON REST API (`/api/*`) menggunakan autentikasi token JWT Bearer.
- **Fase Saat Ini:** Pengujian sistem fungsional dan eksplorasi untuk **Release 1.0**.
- **Pertimbangan Teknis Arsitektur:**
  - Karena Conduit dibangun sebagai *Angular SPA*, setiap perpindahan rute (`/login`, `/settings`, `/editor`) dan proses *logout* perlu diaudit secara khusus untuk mendeteksi potensi **stale client-side state** maupun celah pada **Angular Router Guard**.
  - Validasi *form* di sisi tampilan (*frontend*) harus dicocokkan langsung dengan *payload* dan *HTTP status code* (`200`, `422`, `500`) di Chrome DevTools agar kasus *silent failure* tidak terlewat.

---

## 📦 2. Scope Pengujian

### ✅ 2.1 In Scope

Baseline Tiket Jira: [`Jira_Bugs_CON1-CON6.csv`](./Bug_Reports/Jira_Bugs_CON1-CON6.csv) | Repositori Skenario: [`Test_Cases/README.md`](./Test_Cases/README.md)

| Sistem / Komponen / Fitur | Deskripsi Cakupan | PIC | Referensi |
| :--- | :--- | :--- | :--- |
| 🟢 **Authentication (`AUTH`)** | Registrasi akun (`/register`), *login* (`/login`), *logout*, pengecekan duplikasi akun, validasi format email, dan penanganan karakter spasi (*whitespace*). | QA Engineer | `REQ-01` / `TC-AUTH-001`–`003`, `101`–`106`, `201` |
| 🟠 **Profile & Settings (`PROF`)** | Pembaruan bio singkat, URL foto profil, verifikasi ganti *password*, penanganan *broken image fallback*, dan *redirect* rute terproteksi tanpa *login*. | QA Engineer | `REQ-02` / `TC-PROF-001`–`201` |
| 📝 **Article Management (`ART`)** | Pembuatan, penyuntingan (*edit*), dan penghapusan (*delete*) artikel (`/editor`), *tag* opsional, validasi kolom wajib, batas judul >250 karakter, *render* Markdown, dan pencegahan *double-click*. | QA Engineer | `REQ-03` / `TC-ART-001`–`203` |
| 💬 **Social Interaction (`SOC`)** | Penambahan dan penghapusan komentar, tombol *Favorite/Unfavorite* dari *feed* maupun halaman detail, fitur *Follow/Unfollow* penulis, serta validasi komentar kosong/spasi. | QA Engineer | `REQ-04` / `TC-SOC-001`–`101` |
| 📰 **Feed & Navigation (`FEED`)** | Filter artikel lewat *Popular Tags*, pembaruan lini masa `Your Feed` setelah mem-*follow* penulis, navigasi *pagination* di `Global Feed`, serta tab `My Articles` dan `Favorited Articles` di profil. | QA Engineer | `REQ-05` / `TC-FEED-001`–`004` |

### ❌ 2.2 Out of Scope

| Nama Komponen | Alasan Pengecualian |
| :--- | :--- |
| **Load & Stress Performance Testing** | Pengujian beban konkurensi tinggi (seperti JMeter atau k6) tidak termasuk dalam ruang lingkup pengujian fungsional manual Release 1.0. |
| **Aplikasi Mobile Native** | Conduit diuji khusus sebagai aplikasi web *desktop*; versi *native* iOS maupun Android tidak tersedia. |
| **Login Pihak Ketiga (OAuth / SSO)** | Fitur *login* menggunakan akun sosial media (Google/GitHub OAuth) tidak ada di dalam spesifikasi aplikasi Conduit. |
| **Migrasi Skema Database Langsung** | Administrasi server *backend* dan perubahan struktur tabel secara langsung berada di luar wewenang pengujian QA. |

### 🧰 2.3 Sistem Pihak Ketiga (Third-Party Systems)

| Nama Sistem | Fungsi Penggunaan | PIC | Referensi |
| :--- | :--- | :--- | :--- |
| **TestRail Cloud** | Repositori utama pengelolaan 35 *test case*, pencatatan hasil eksekusi per *Test Run*, dan ekspor laporan PDF. | QA Engineer | [`TestRun1`](./Test_Reports/TestRun1_Batch1_AUTH_PROF.pdf) / [`TestRun2`](./Test_Reports/TestRun2_Batch2_ART_SOC_FEED.pdf) |
| **Jira Cloud** | Pengelolaan *requirement* (`REQ-01`–`REQ-05`), pelaporan tiket *bug* (`CON-1`–`CON-6`), *triage*, dan sinkronisasi *traceability* ke TestRail. | QA Engineer | [`Jira_Bugs_CON1-CON6.csv`](./Bug_Reports/Jira_Bugs_CON1-CON6.csv) |
| **External Image Hosts** | Tautan gambar eksternal yang diinputkan pada kolom foto profil (`image`) maupun isi artikel Markdown. | Eksternal / Input QA | `TC-PROF-001`, `TC-PROF-101` |

### 🤝 2.4 Sistem yang Divalidasi Pihak Eksternal

| Nama Komponen | Deskripsi | Pihak Bertanggung Jawab | Referensi |
| :--- | :--- | :--- | :--- |
| **Bondar Academy Hosted API** | Layanan REST API publik (`conduit-api.bondaracademy.com`) beserta lapisan penyimpanan *database* di sisi *server*. | Penyedia Hosting / Tinjauan Tidak Langsung QA | Log Network Chrome DevTools |
| **Shared Sandbox Seed Data** | Data artikel dan akun bawaan yang tersedia di dalam lingkungan demo bersama. | Penyedia Hosting | `Global Feed` & `Popular Tags` |

---

## ✅ 3. Kriteria Kualitas dan Acceptance Criteria

Aplikasi Conduit **Release 1.0** dinyatakan layak naik ke tahap produksi apabila memenuhi seluruh kriteria berikut:

- Seluruh **5 kebutuhan bisnis (`REQ-01` hingga `REQ-05`)** dipetakan ke test case; cakupan `REQ-05` tercatat 90% pada RTM karena beberapa edge case belum diverifikasi.
- Seluruh **35 test case** telah dieksekusi (35/35).
- **Tidak ada (`0`) defect berstatus Critical/Blocker maupun Major** yang masih terbuka sebelum persetujuan rilis.
- Setiap skenario yang gagal (*Failed*) wajib dicatat di Jira lengkap dengan langkah reproduksi, klasifikasi *severity/priority*, bukti tangkapan layar, serta tertaut ke TestRail.
- Dokumen **Test Summary Report (`Test_Reports/README.md`)** telah disusun dan diserahkan di akhir siklus pengujian.
- Tingkat kelulusan (*pass rate*) minimal mencapai **95%** untuk mendapatkan keputusan **GO RELEASE** *(Catatan: Hasil aktual Release 1.0 mencatat pass rate **82,86%** dengan 2 defect Major terbuka sehingga statusnya adalah **HOLD RELEASE**)*.

---

## 🧪 4. Deskripsi Proses Pengujian (Test Process)

Alur kerja QA menerapkan *traceability* dua arah yang ketat mulai dari **Jira Requirements (`REQ-01`–`REQ-05`) $\rightarrow$ Skenario TestRail (`35 TCs`) $\rightarrow$ Test Runs (`Batch 1 & Batch 2`) $\rightarrow$ Tiket Defect Jira (`CON-1`–`CON-6`)**.

### 🔍 4.1 Gambaran Umum Testing Types

| 🧪 Jenis Pengujian | ✍️ Dirancang Oleh | 🛠️ Perangkat / Tools | 👤 Dieksekusi Oleh | 📎 Referensi |
| :--- | :--- | :--- | :--- | :--- |
| **Manual Functional Testing** | `@Azza` | Desktop Chrome, TestRail | Manual QA Engineer | [`Test_Cases/README.md`](./Test_Cases/README.md) |
| **Negative & Boundary Testing** | `@Azza` | Desktop Chrome, DevTools | Manual QA Engineer | Seri `TC-*-101` & `TC-*-201` |
| **Grey-Box API / Network Inspection** | `@Azza` | Chrome DevTools (Fetch/XHR & Console) | Manual QA Engineer | [`Jira_Bugs_CON1-CON6.csv`](./Bug_Reports/Jira_Bugs_CON1-CON6.csv) |
| **Exploratory & State Testing** | `@Azza` | Chrome Incognito Multi-Session | Manual QA Engineer | Bukti `CON-2`, `CON-4` |
| **Smoke & Regression Testing** | `@Azza` | Desktop Chrome, TestRail | Manual QA Engineer | Cakupan Verifikasi Pasca-Perbaikan |
| **API & SQL Validation (Selesai)** | `@Azza` | Postman, MySQL / MariaDB (v26.10) / DBeaver | QA Engineer | `API_Testing/` & `SQL_Queries/` |

### 🔍 4.2 Ringkasan Detail Testing Types

| 🧪 Jenis Pengujian | 👤 Role | 📝 Deskripsi | 📅 Jadwal / Fase | ✅ Kriteria Selesai | 📊 Hasil yang Diharapkan | 🤝 PIC |
| :--- | :--- | :--- | :--- | :--- | :--- | :--- |
| **Smoke Testing** | QA Engineer | Pengecekan cepat ketersediaan aplikasi, akses *login*, dan tampilan *feed* sebelum pengujian penuh dimulai. | Hari ke-3 (Pra-Batch 1) | URL aplikasi dapat diakses dan akun uji (`qa_author_01`, `qa_reader_01`) aktif. | Navigasi utama dan *endpoint* API merespons normal tanpa error `500`. | `@Azza` |
| **Functional Testing** | QA Engineer | Verifikasi menyeluruh seluruh alur normal (*happy path*) pada modul `AUTH`, `PROF`, `ART`, `SOC`, dan `FEED`. | Hari ke-4 s.d. ke-7 (Batch 1 & 2) | Seluruh skenario `TC-*-001` hingga `006` selesai dieksekusi di TestRail. | Semua fitur utama berjalan sesuai spesifikasi RealWorld Conduit. | `@Azza` |
| **Negative & Boundary Testing** | QA Engineer | Menguji input kosong pada kolom wajib, format email/URL tidak valid, input spasi saja, judul >250 karakter, serta *double-click*. | Hari ke-4 s.d. ke-7 (Batch 1 & 2) | Seluruh skenario `TC-*-101` dan `TC-*-201` selesai dieksekusi. | Sistem menolak input tidak valid secara aman dengan pesan error UI yang jelas. | `@Azza` |
| **Exploratory & Grey-Box Testing** | QA Engineer | Mengaudit perilaku *Angular route guard*, transisi sesi JWT, serta kecocokan antara *payload* API dan data yang tampil di UI. | Hari ke-5 s.d. ke-7 | Log Network dan Console di DevTools diperiksa pada setiap anomali. | Celah *client-side state* (`CON-2`, `CON-4`) terisolasi lengkap dengan catatan akar masalah. | `@Azza` |
| **Regression Testing** | QA Engineer | Eksekusi ulang skenario yang gagal beserta pengecekan modul terkait setelah tim pengembang memperbaiki *defect*. | Siklus Pasca-Perbaikan | Perbaikan untuk tiket `CON-1` hingga `CON-6` telah dirilis ke *environment* uji. | Skenario yang sebelumnya gagal kini lulus (*Passed*) tanpa menimbulkan bug baru. | `@Azza` |

---

### 📌 4.3 Manajemen Task di Jira

Seluruh kebutuhan pengujian dan temuan masalah dikelola di Jira di bawah kode proyek **`CON` (Conduit Web App)**:

- 🧩 **Requirement Epics / Stories (`REQ-01` – `REQ-05`):** Ditautkan langsung ke kolom `References` pada setiap *test case* di TestRail.
- 🐞 **Defect Tickets (`CON-1` – `CON-6`):** Dibuat untuk setiap skenario yang gagal lengkap dengan informasi *Environment*, *Severity*, *Steps to Reproduce*, *Actual vs. Expected Result*, *Root Cause Note*, dan lampiran bukti.
- 🔄 **Retest & Verification Tasks:** Dijalankan segera setelah status tiket berubah dari `In Progress` menjadi `Ready for QA`.

---

### 🐞 4.4 Manajemen Defect & Root Cause Analysis (RCA)

Pelacakan *bug* disinkronkan secara langsung antara **Jira Cloud** dan **TestRail**.

#### 🔄 4.4.1 Defect Lifecycle
- **Alur Status Standar:** `To Do (Logged)` $\rightarrow$ `In Progress` $\rightarrow$ `Ready for Retest` $\rightarrow$ `Closed` *(atau `Reopened` jika hasil verifikasi ulang masih gagal)*.
- **Aturan Traceability:** Setiap ID tiket Jira (`CON-1`–`CON-6`) wajib dicatat pada kolom `Defects` di hasil eksekusi TestRail yang bersangkutan.

#### 🧷 4.4.2 Defect Raising Rules
- **Kegagalan Fungsional & Validasi:** Setiap penyimpangan dari perilaku UI maupun API yang diharapkan selama *test run* langsung dicatat sebagai tiket *bug* dengan langkah reproduksi dan bukti `.png`.
- **Pencegahan Duplikasi:** Sebelum membuat tiket baru, daftar isu yang sudah ada diperiksa terlebih dahulu agar masalah dengan akar penyebab yang sama tidak tercatat ganda.

#### 🧠 4.4.3 Root Cause Analysis (RCA)
Setiap temuan pada `CON-1` sampai `CON-6` melewati 5 langkah analisis akar masalah yang didokumentasikan langsung di dalam tiket Jira:
1. Mereproduksi kegagalan secara konsisten dan memastikan apakah isu tetap muncul pada sesi *Incognito* yang bersih.
2. Memeriksa **Chrome DevTools (`Network` $\rightarrow$ `Fetch/XHR`)** untuk membandingkan *JSON payload* dan *HTTP status code* dengan kondisi tampilan UI.
3. Mengisolasi lapisan sumber masalah (**Komponen Frontend Angular / Router Guard** vs. **Validasi API Backend**).
4. Mengelompokkan kategori penyebab utama (misalnya: *tidak adanya sanitasi `.trim()`*, *binding state komponen yang tertinggal/stale*, *redirect router guard yang tidak tertangani*, atau *tidak ada pembatasan `maxlength` / renderer pesan error*).
5. Menuliskan rekomendasi perbaikan teknis bagi *developer* pada bagian *Root Cause Note* di Jira.

---

### 📋 4.5 Pengelolaan & Eksekusi Test Case

Seluruh 35 skenario pengujian dikelola di **TestRail** dan didokumentasikan pada [`Test_Cases/README.md`](./Test_Cases/README.md) serta berkas test case per modul.

#### ✅ 4.5.1 General Rules
- Eksekusi pengujian tidak dimulai sebelum *scope* pada *Test Plan* dan pemetaan *requirement* (`REQ-01`–`REQ-05`) ditetapkan.
- Penamaan seluruh skenario mengikuti standar semantik: `TC-[MODUL]-[NOMOR] - [Judul Skenario Singkat]` (kode `0xx` umumnya *Positive*, `1xx` *Negative*, `2xx` *Boundary/Edge Case*; klasifikasi akhir mengikuti kolom `Type`, dengan `TC-ART-202` sebagai pengecualian fungsional).

#### ⏳ 4.5.2 Milestones
Eksekusi dibagi menjadi dua *Test Run* terpisah di TestRail untuk mencegah gangguan *state* antar-modul:
- **Milestone / Test Run 1 (`Batch 1`):** `Authentication (AUTH)` & `Profile & Settings (PROF)` — 14 Test Cases (`TC-01` s.d. `TC-14`).
- **Milestone / Test Run 2 (`Batch 2`):** `Article Management (ART)`, `Social Interaction (SOC)` & `Feed & Navigation (FEED)` — 21 Test Cases (`TC-15` s.d. `TC-35`).

#### 🧾 4.5.3 Test Case Creation Rules
- Setiap skenario wajib mencantumkan **Type** (`Functional` / `Other`), **Priority** (`High` / `Medium` / `Low`), **References** (`REQ-01`–`REQ-05`), **Preconditions**, urutan **Steps**, serta **Expected Result** yang terukur.
- Komposisi cakupan menjaga keseimbangan antara alur normal (`20 TCs`), validasi input negatif (`11 TCs`), dan *boundary/edge case* (`4 TCs`).

#### ▶️ 4.5.4 Test Case Execution
- **Strategi Isolasi Dua Akun:** Akun `qa_author_01` digunakan untuk membuat dan mengelola artikel (`ART`), sementara akun `qa_reader_01` (dibuka pada jendela *Chrome Incognito* terpisah) menguji interaksi sosial serta pembaruan *feed* (`SOC` & `FEED`).
- **Pengambilan Bukti Real-Time:** Setiap eksekusi berstatus *Failed* langsung didokumentasikan menggunakan tangkapan layar (`Win + Shift + S`) dan disimpan ke folder `Bug_Reports/evidence/` dengan format nama `[TC-ID]_[Deskripsi_Singkat_Bug].png`.

---

### 📊 4.6 Struktur Laporan Pengujian (Test Report)

Setelah seluruh eksekusi selesai, hasil pengujian dirangkum ke dalam [`Test_Reports/README.md`](./Test_Reports/README.md) yang memuat:
- **Rincian Eksekusi per Modul:** Jumlah total skenario, *Passed*, *Failed*, *Blocked*, dan persentase *Pass Rate* di tiap modul.
- **Distribusi Severity & Priority Defect:** Pengelompokan seluruh 6 *bug* (`2 Major`, `4 Minor`).
- **Keputusan Release Readiness:** Rekomendasi resmi **GO / HOLD RELEASE** berdasarkan analisis risiko teknis.

---

### 📐 4.7 Daftar Metrik yang Dipantau (Project Metrics)

| 🧪 **Nama Metrik** | 🧮 **Rumus Perhitungan** | 👤 **PIC** | ⏱️ **Frekuensi** | 📤 **Media Pelaporan** |
| :--- | :--- | :--- | :--- | :--- |
| **Requirements Coverage %** | `(Jumlah Requirement Teruji / Total Requirement) × 100` | QA Engineer | Per Siklus Uji | Tabel RTM di `README.md` & TSR (`100%`) |
| **Passed Test Cases % (Pass Rate)** | `(Jumlah Test Passed / Total Test Dieksekusi) × 100` | QA Engineer | Per Test Run | PDF TestRail & TSR (`82,86%`) |
| **Failed Test Cases %** | `(Jumlah Test Failed / Total Test Dieksekusi) × 100` | QA Engineer | Per Test Run | PDF TestRail & TSR (`17,14%`) |
| **Defect Density per Modul** | `Total Defect Ditemukan / Total Test Case di Modul` | QA Engineer | Akhir Siklus | Tabel Modul TSR (`PROF` tertinggi sebesar `75%`) |
| **Distribusi Severity Defect** | `Jumlah Defect dikelompokkan per Critical, Major, Minor` | QA Engineer | Akhir Siklus | Ekspor CSV Jira & TSR (`2 Major`, `4 Minor`) |
| **Defect Traceability %** | `(Defect Tertaut ke TC & Req / Total Defect) × 100` | QA Engineer | Akhir Siklus | Sinkronisasi Jira $\leftrightarrow$ TestRail (`100%`) |

---

## ⚠️ 5. Risiko dan Asumsi (Risks & Assumptions)

### ⚠️ 5.1 Risiko (Risks)

| # | 🧨 Risiko | 🔢 Probabilitas | 🔴 Severity | 🛠️ Rencana Mitigasi |
| :--- | :--- | :---: | :---: | :--- |
| 1 | **Pencemaran Data pada Environment Publik:** Pengguna lain di lingkungan demo bersama berpotensi menyunting atau menghapus artikel saat pengujian berlangsung. | M | M | Menggunakan akun uji khusus dengan penamaan unik (`qa_author_01`, `qa_reader_01`) serta artikel buatan sendiri agar pengujian tetap terisolasi. |
| 2 | **Kebocoran State SPA Antar-Sesi Login:** Sisa *state* memori Angular dari sesi akun sebelumnya memengaruhi hasil pengujian akun berikutnya. | H | H | Menjalankan pengujian interaksi multi-akun (`Batch 2`) menggunakan sesi *Chrome Incognito* terpisah serta melaporkan kebocoran *state* yang ditemukan (`CON-2`). |
| 3 | **URL Gambar Eksternal Tidak Dapat Diakses:** Tautan foto profil dari sumber luar gagal dimuat atau terblokir kebijakan CORS. | L | L | Menggunakan URL gambar HTTPS statis yang stabil untuk pengujian positif (`TC-PROF-001`) dan string acak tak valid untuk pengujian negatif (`TC-PROF-101`). |
| 4 | **Keterlambatan Respons atau Downtime API Publik:** Server demo mengalami latensi sementara atau *cold-start*. | L | M | Memantau waktu respons HTTP di tab Network Chrome DevTools dan melakukan percobaan ulang sebelum mencatat kendala jaringan sebagai *bug*. |
| 5 | **Perbedaan Model SQL Simulasi dengan Database Production:** Skema lokal tidak merepresentasikan akses langsung ke database Conduit. | M | L | Membatasi kesimpulan SQL pada model dan seed data simulasi; tidak mengklaim hasil sebagai validasi database production. |

### 🧾 5.2 Asumsi (Assumptions)

- Aplikasi Conduit (`https://conduit.bondaracademy.com`) dan layanan REST API-nya dapat diakses dengan stabil selama periode pengujian.
- Spesifikasi fungsional standar RealWorld Conduit menjadi acuan utama dalam menentukan *Expected Result*.
- Seluruh *defect* kategori **Major** (`CON-2` dan `CON-4`) wajib diperbaiki dan diuji ulang sebelum status rilis diubah dari **HOLD RELEASE** menjadi **GO RELEASE**.
- File ekspor dari TestRail dan Jira Cloud (`PDF` dan `CSV`) merepresentasikan status akhir eksekusi seluruh 35 *test case* secara akurat.

---

## 📱 6. Perangkat Pengujian (Devices)

- **Platform Utama:** Komputer Desktop (Windows) menggunakan **Google Chrome (Versi Stabil Terbaru)** pada resolusi layar standar desktop (`1920×1080` / `1366×768`).
- **Konfigurasi Diagnostik:** Panel Chrome DevTools aktif di sisi kanan/bawah browser dengan pemantauan **Network (`Fetch/XHR`)** dan **Console** selama pengiriman *form* maupun perpindahan halaman.
- *(Catatan: Perangkat mobile native dan tampilan tablet tidak masuk dalam cakupan pengujian Release 1.0).*

---

## 🛠️ 7. Toolset

| Kategori | Tool | Peran dalam Proyek |
| :--- | :--- | :--- |
| **Test Management** | **TestRail Cloud** | Penyusunan 35 *test case*, pengelolaan eksekusi *Batch 1* & *Batch 2*, serta ekspor laporan PDF. |
| **Defect & Req Tracking** | **Jira Cloud** | Pengelolaan *requirement* (`REQ-01`–`REQ-05`), pelaporan tiket `CON-1`–`CON-6`, penentuan *Severity/Priority*, dan ekspor laporan CSV. |
| **Browser & Grey-Box Debugging** | **Google Chrome & DevTools** | Inspeksi *request/response* HTTP (`GET /api/user`, `POST /api/articles`, `POST /api/articles/:slug/comments`), log *console*, dan token JWT di `localStorage`. |
| **Dokumentasi & Bukti Uji** | **Windows Snipping Tool & Markdown** | Pengambilan bukti *screenshot* (`.png`) dan penyusunan artefak QA terstruktur di GitHub. |
| **API & SQL Validation** | **Postman & MySQL / MariaDB (v26.10) / DBeaver** | Pengujian koleksi endpoint API (`API_Testing/`) dan kueri model data simulasi (`SQL_Queries/`); hasil tersedia pada dokumentasi masing-masing. |

---

## 🌐 8. Test Environments

| 🏷️ **Nama Environment** | 🔗 **URL / Endpoint** | 💬 **Keterangan** |
| :--- | :--- | :--- |
| **Production / Demo Web UI** | `https://conduit.bondaracademy.com` | *Frontend* utama *Angular SPA* yang digunakan untuk mengeksekusi seluruh 35 skenario pengujian manual (`Release 1.0`). |
| **Backend REST API** | `https://conduit-api.bondaracademy.com/api` | Dipantau melalui tab Network Chrome DevTools untuk memverifikasi *payload* permintaan dan *HTTP status code*. |
| **Test Management Portal** | `TestRail Cloud Workspace` | Menyimpan proyek `Conduit Web App`, `Test Run 1`, dan `Test Run 2`. |
| **Issue Tracking Portal** | `Jira Cloud Workspace (Project: CON)` | Menyimpan daftar kebutuhan `REQ-01`–`REQ-05` dan tiket *defect* `CON-1`–`CON-6`. |

---

## 📣 9. Communication Plan

Dalam alur kerja tim pengembangan *Agile*, koordinasi dan transparansi hasil pengujian dijaga melalui kanal berikut:

- **Daily Stand-Ups / Progress Sync:** Menyampaikan perkembangan eksekusi harian, skenario yang terhambat (*blocked*), serta temuan krusial.
- **Dashboard Manajemen Uji (TestRail):** Pemantauan metrik *pass/fail* secara langsung pada `Batch 1` dan `Batch 2`.
- **Pelaporan & Triage Defect (Jira Cloud):** Notifikasi langsung kepada *developer* setiap kali tiket *bug* baru (`CON-1`–`CON-6`) tercatat lengkap dengan bukti reproduksinya.
- **Dokumentasi Repositori (GitHub):** Pusat dokumentasi utama yang menyimpan *Master Test Plan*, *Test Cases*, file ekspor CSV/PDF, serta *Test Summary Report*.

---

## 🚨 10. Escalation Plan

| Tingkat Eskalasi | Kondisi Pemicu | Tindakan yang Diperlukan | Tujuan Eskalasi |
| :--- | :--- | :--- | :--- |
| **Level 1 — Standard Triage** | Ditemukan *defect* kategori *Minor* pada UI atau validasi input (`CON-1`, `CON-3`, `CON-5`, `CON-6`). | Catat di Jira lengkap dengan bukti tangkapan layar untuk dijadwalkan pada *backlog* perbaikan reguler. | Development Team |
| **Level 2 — High Priority Alert** | Ditemukan *defect* kategori *Major* (`CON-2`, `CON-4`) yang mengganggu integritas *state* atau alur utama pengguna. | Tandai sebagai **Major / High Priority** di Jira, lampirkan analisis log DevTools, dan informasikan segera ke tim *frontend/backend*. | Tech Lead / Frontend Lead |
| **Level 3 — Release Gate Hold** | Masih terdapat *defect* berstatus *Major/Critical* yang belum diperbaiki di akhir pengujian, atau *pass rate* berada di bawah 95%. | Terbitkan rekomendasi resmi **HOLD RELEASE** di dalam [`Test_Reports/README.md`](./Test_Reports/README.md) dan tunda rilis produksi. | Product Owner / Release Manager |

---

## 🗓️ 11. Test Schedule

### 📅 11.1 Sprint Schedule

<style>
  td.activity { font-weight: bold; background-color: #f2f2f2; }

  /* Color Classes */
  .blue-light  { background-color: #e0f2ff; }
  .blue        { background-color: #a5d8ff; }
  .green-light { background-color: #d3f9d8; }
  .green       { background-color: #8ce99a; }
  .red         { background-color: #ffc9c9; }
  .yellow      { background-color: #fff3bf; }
  .yellow-light{ background-color: #fff9db; }
  .gray        { background-color: #e9ecef; }
</style>

<table>
  <thead>
    <tr>
      <th>Aktivitas</th>
      <th>Day 1</th>
      <th>Day 2</th>
      <th>Day 3</th>
      <th>Day 4</th>
      <th>Day 5</th>
      <th>Day 6</th>
      <th>Day 7</th>
      <th>Day 8</th>
      <th>Day 9</th>
      <th>Day 10</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td class="activity" style="font-weight: bold; background-color: #f2f2f2;">Penyusunan Test Plan & RTM</td>
      <td class="blue" style="background-color: #a5d8ff;">Master Test Plan</td>
      <td class="blue" style="background-color: #a5d8ff;">Pemetaan REQ-01–05</td>
      <td></td><td></td><td></td>
      <td class="blue-light" style="background-color: #e0f2ff;">Review Scope</td>
      <td></td><td></td><td></td><td></td>
    </tr>
    <tr>
      <td class="activity" style="font-weight: bold; background-color: #f2f2f2;">Pembuatan Manual Test Cases</td>
      <td class="blue-light" style="background-color: #e0f2ff;"></td>
      <td class="blue" style="background-color: #a5d8ff;">Batch 1 (14 TCs)</td>
      <td class="blue" style="background-color: #a5d8ff;">Batch 2 (21 TCs)</td>
      <td class="blue-light" style="background-color: #e0f2ff;">Review Skenario</td>
      <td></td><td></td><td></td><td></td><td></td><td></td>
    </tr>
    <tr>
      <td class="activity" style="font-weight: bold; background-color: #f2f2f2;">Smoke Testing</td>
      <td></td><td></td>
      <td class="gray" style="background-color: #e9ecef;">Cek Kesiapan AUT</td>
      <td></td><td></td><td></td><td></td>
      <td class="gray" style="background-color: #e9ecef;">Smoke Pasca-Fix</td>
      <td></td><td></td>
    </tr>
    <tr>
      <td class="activity" style="font-weight: bold; background-color: #f2f2f2;">Eksekusi Manual Test Cases</td>
      <td></td><td></td><td></td>
      <td class="green" style="background-color: #8ce99a;">Test Run 1 (AUTH/PROF)</td>
      <td class="green" style="background-color: #8ce99a;">Test Run 2 (ART/SOC/FEED)</td>
      <td class="green-light" style="background-color: #d3f9d8;">Eksplorasi & Audit DevTools</td>
      <td></td><td></td><td></td><td></td>
    </tr>
    <tr>
      <td class="activity" style="font-weight: bold; background-color: #f2f2f2;">Pelaporan Defect & Triage</td>
      <td></td><td></td><td></td>
      <td class="red" style="background-color: #ffc9c9;">CON-1 – CON-4</td>
      <td class="red" style="background-color: #ffc9c9;">CON-5 – CON-6</td>
      <td class="red" style="background-color: #ffc9c9;">RCA & Link TestRail</td>
      <td></td><td></td><td></td><td></td>
    </tr>
    <tr>
      <td class="activity" style="font-weight: bold; background-color: #f2f2f2;">Penyusunan TSR & Ekspor Artefak</td>
      <td></td><td></td><td></td><td></td><td></td><td></td>
      <td class="yellow" style="background-color: #fff3bf;">TSR & Packaging GitHub</td>
      <td></td><td></td><td></td>
    </tr>
    <tr>
      <td class="activity" style="font-weight: bold; background-color: #f2f2f2;">Retest & Regression (Pasca-Fix)</td>
      <td></td><td></td><td></td><td></td><td></td><td></td><td></td>
      <td class="green-light" style="background-color: #d3f9d8;">Verifikasi Perbaikan</td>
      <td class="green" style="background-color: #8ce99a;">Regression Run</td>
      <td></td>
    </tr>
    <tr>
      <td class="activity" style="font-weight: bold; background-color: #f2f2f2;">Release Readiness Sign-Off</td>
      <td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td><td></td>
      <td class="blue" style="background-color: #a5d8ff;">Keputusan Go / Hold</td>
    </tr>
  </tbody>
</table>

### 📅 11.2 Phase Schedule

<style>
  td.activity { font-weight: bold; background-color: #f2f2f2; }
  .c1 { background-color: #fefddbff; }
  .c2 { background-color: #dbeafe; }
  .c3 { background-color: #e0ffd4ff; }
  .c4 { background-color: #60a5fa; }
  .c5 { background-color: #cdf8f8ff; }
  .c6 { background-color: #6c29d8ff; color: white; }
  .c7 { background-color: #1d4ed8; color: white; }
</style>

<table>
  <thead>
    <tr>
      <th class="c7" style="background-color: #1d4ed8; color: white;">Aktivitas</th>
      <th class="c7" style="background-color: #1d4ed8; color: white;">Fase 1: Planning</th>
      <th class="c7" style="background-color: #1d4ed8; color: white;">Fase 2: Batch 1 QA</th>
      <th class="c7" style="background-color: #1d4ed8; color: white;">Fase 3: Batch 2 QA</th>
      <th class="c7" style="background-color: #1d4ed8; color: white;">Fase 4: Reporting</th>
      <th class="c7" style="background-color: #1d4ed8; color: white;">Fase 5: API & SQL Validation</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td class="activity" style="font-weight: bold; background-color: #f2f2f2;">Test Plan & Pemetaan Requirement</td>
      <td class="c1" style="background-color: #fefddbff;">✓</td>
      <td></td><td></td><td></td><td></td>
    </tr>
    <tr>
      <td class="activity" style="font-weight: bold; background-color: #f2f2f2;">Functional & Negative Testing</td>
      <td></td>
      <td class="c1" style="background-color: #fefddbff;">✓ (AUTH & PROF)</td>
      <td class="c1" style="background-color: #fefddbff;">✓ (ART, SOC & FEED)</td>
      <td></td><td></td>
    </tr>
    <tr>
      <td class="activity" style="font-weight: bold; background-color: #f2f2f2;">Smoke & Exploratory State Testing</td>
      <td></td>
      <td class="c4" style="background-color: #60a5fa;">✓</td>
      <td class="c4" style="background-color: #60a5fa;">✓</td>
      <td></td><td></td>
    </tr>
    <tr>
      <td class="activity" style="font-weight: bold; background-color: #f2f2f2;">Pelaporan Defect & RCA (Jira)</td>
      <td></td>
      <td class="c2" style="background-color: #dbeafe;">✓ (CON-1–4)</td>
      <td class="c2" style="background-color: #dbeafe;">✓ (CON-5–6)</td>
      <td></td><td></td>
    </tr>
    <tr>
      <td class="activity" style="font-weight: bold; background-color: #f2f2f2;">Validasi Integritas API & SQL</td>
      <td></td><td></td><td></td><td></td>
      <td class="c5" style="background-color: #cdf8f8ff;">Postman & MySQL / Maria DB (v26.10)</td>
    </tr>
    <tr>
      <td class="activity" style="font-weight: bold; background-color: #f2f2f2;">Release Readiness & TSR</td>
      <td></td><td></td><td></td>
      <td class="c6" style="background-color: #6c29d8ff; color: white;">✓ (HOLD RELEASE)</td>
      <td class="c3" style="background-color: #e0ffd4ff;">Full Regression Sign-Off</td>
    </tr>
  </tbody>
</table>

---

## 🧾 12. Test Deliverables

| # | Artefak yang Diserahkan | Target Audiens | PIC / Penulis | Waktu Penyerahan | Media Penyimpanan |
| :--- | :--- | :--- | :--- | :--- | :--- |
| 1 | **Master Test Plan (`Test_Plan/README.md`)** | Stakeholders, Tim Pengembang, Recruiter | `@Azza` | Sebelum eksekusi dimulai; diperbarui jika ada perubahan *scope* | Repositori GitHub (`Test_Plan/`) |
| 2 | **Test Cases Repository (`Test_Cases/README.md` & berkas per modul)** | Tim Pengembang, QA Reviewer | `@Azza` | Sebelum eksekusi dimulai; diperbarui dengan status hasil akhir | Repositori GitHub (`Test_Cases/`) & TestRail |
| 3 | **Test Execution Reports (`TestRun1` & `TestRun2` PDF)** | QA Reviewer, Engineering Lead | `@Azza` | Segera setelah masing-masing *batch* eksekusi selesai | Repositori GitHub (`Test_Reports/`) |
| 4 | **Defect Reports & Evidence (`Jira_Bugs_CON1-CON6.csv` & `.png`)** | Tim Pengembang, Product Owner | `@Azza` | Langsung saat setiap *defect* ditemukan | Jira Cloud & GitHub (`Bug_Reports/`) |
| 5 | **Test Summary Report (`Test_Reports/README.md`)** | Product Owner, Release Manager, Recruiter | `@Azza` | Setelah seluruh siklus pengujian Release 1.0 selesai | Repositori GitHub (`Test_Reports/`) |
| 6 | **API Test Collection & Report (`Conduit_API_Collection.json`, `Conduit_Environment.json`, dan `README.md`)** | QA Reviewer, Tim Pengembang | `@Azza` | Setelah pengujian API dan Collection Runner selesai | Repositori GitHub (`API_Testing/`) |
| 7 | **SQL Schema & Data Audit Queries (`schema_and_seed.sql` dan `data_integrity.sql`)** | QA Reviewer, Tim Pengembang | `@Azza` | Setelah penyusunan dan validasi model data simulasi | Repositori GitHub (`SQL_Queries/`) |