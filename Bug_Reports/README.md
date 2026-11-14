# 🐞 Defect Reports & Evidence — Conduit Web Application (`CON-1` – `CON-6`)

![Defect Tracking](https://img.shields.io/badge/Issue%20Tracker-Jira%20Cloud-blue)
![Total Defects](https://img.shields.io/badge/Total%20Defects-6%20Logged-red)
![Severity](https://img.shields.io/badge/Severity-2%20Major%20%7C%204%20Minor-orange)

## Ringkasan Pelaporan Defect

Direktori ini menyimpan data ekspor tiket *defect* dari **Jira Cloud** (`Project Key: CON`) beserta bukti tangkapan layar (*evidence*) dan inspeksi Chrome DevTools untuk seluruh kegagalan yang ditemukan selama pengujian **Conduit Web Application (Release 1.0)**.

---

## Artefak di Dalam Direktori

| Artefak | Lokasi / File | Keterangan |
| :--- | :--- | :--- |
| **Ekspor Tiket Jira (CSV)** | [`Jira_Bugs_CON1-CON6.csv`](./Jira_Bugs_CON1-CON6.csv) | Data lengkap tiket `CON-1`–`CON-6` (*Summary, Steps to Reproduce, Actual vs. Expected Result, Root Cause Note*). |
| **Bukti Reproduksi (`.png`)** | [`evidence/`](./evidence/) | Kumpulan 6 tangkapan layar UI dan log *Network/Console* DevTools untuk setiap *defect*. |

---

## Daftar Defect Terdokumentasi (`CON-1` – `CON-6`)

| Jira ID | Test Case | Modul | Ringkasan Masalah | Severity | Priority | Status | Bukti |
| :--- | :--- | :---: | :--- | :---: | :---: | :---: | :--- |
| **CON-1** | `TC-AUTH-103` | `AUTH` | Form registrasi meloloskan format email tidak lengkap tanpa domain (contoh: `qatest@`) | Minor | Medium | To Do | [`TC-AUTH-103_Invalid_Email_Accepted.png`](./evidence/TC-AUTH-103_Invalid_Email_Accepted.png) |
| **CON-2** | `TC-PROF-001` | `PROF` | Halaman `/settings` menampilkan *stale username* sesi sebelumnya dan kolom email kosong meski respons `GET /api/user` valid | **Major** | **High** | To Do | [`BUG-PROF-001_Stale_User_State_In_Settings.png`](./evidence/BUG-PROF-001_Stale_User_State_In_Settings.png) |
| **CON-3** | `TC-PROF-101` | `PROF` | URL foto profil tidak valid tetap tersimpan dan merender ikon *broken image* tanpa *fallback* | Minor | Low | To Do | [`TC-PROF-101_Broken_Profile_Image.png`](./evidence/TC-PROF-101_Broken_Profile_Image.png) |
| **CON-4** | `TC-PROF-201` | `PROF` | Akses langsung ke `/settings` atau `/editor` tanpa *login* melakukan *redirect* yang menghasilkan *blank white screen* di Home | **Major** | **High** | To Do | [`TC-PROF-201_Blank_Home_After_Redirect.png`](./evidence/TC-PROF-201_Blank_Home_After_Redirect.png) |
| **CON-5** | `TC-ART-201` | `ART` | Publikasi artikel dengan judul >250 karakter gagal tanpa pesan validasi error pada UI (*silent failure*) | Minor | Medium | To Do | [`TC-ART-201_Silent_Failure_Long_Title.png`](./evidence/TC-ART-201_Silent_Failure_Long_Title.png) |
| **CON-6** | `TC-SOC-101` | `SOC` | Komentar yang hanya berisi karakter spasi (`"     "`) lolos validasi dan terposting sebagai kartu komentar kosong | Minor | Low | To Do | [`TC-SOC-101_Whitespace_Comment_Accepted.png`](./evidence/TC-SOC-101_Whitespace_Comment_Accepted.png) |

---

## Dokumen Terkait

- [Master Test Plan](../Test_Plans/README.md)
- [Test Cases Repository](../Test_Cases/README.md)
- [Test Summary Report (TSR)](../Test_Reports/README.md)