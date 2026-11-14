# Test Cases

## Overview

Direktori ini berisi seluruh *manual test cases* yang disusun untuk menguji aplikasi web **Conduit** (`https://conduit.bondaracademy.com`) pada **Release 1.0**. Seluruh skenario dikelola di **TestRail** dan terhubung langsung dengan kebutuhan bisnis (`REQ-01`–`REQ-05`) serta laporan *defect* (`CON-1`–`CON-6`) di **Jira Cloud**.

### Objective

Skenario pengujian ini dirancang untuk memvalidasi fungsionalitas utama aplikasi, meliputi:

- User Authentication & Session Management (`AUTH`)
- Profile Customization & Protected Route Access (`PROF`)
- Article Creation, Editing, Deletion & Markdown Rendering (`ART`)
- Social Interactions: Comments, Favorites & Author Following (`SOC`)
- Feed Filtering, Pagination & Profile Navigation (`FEED`)

### Test Design Technique

Beberapa teknik desain pengujian yang diterapkan dalam menyusun skenario:

- Positive Testing (*Happy Path*)
- Negative Testing & Input Validation
- Boundary Value Analysis (BVA)
- Equivalence Partitioning (EP)
- State & Session Transition Testing
- Grey-Box API & Network Inspection (via Chrome DevTools)

---

## Test Case Modules

| Module | Description | Number of Test Cases |
| :--- | :--- | :---: |
| [Authentication (AUTH)](./Authentication/TC_AUTH.md) | Registrasi akun, *login*, *logout*, pengecekan duplikasi data, dan validasi format email | 10 |
| [Profile & Settings (PROF)](./Profile_Settings/TC_PROF.md) | Pembaruan bio, URL foto profil, ganti *password*, dan proteksi *route guard* tanpa *login* | 4 |
| [Article Management (ART)](./Article_Management/TC_ART.md) | Pembuatan, *edit*, *delete* artikel, validasi kolom wajib, batas karakter judul, dan *render* Markdown | 10 |
| [Social Interaction (SOC)](./Social_Interaction/TC_SOC.md) | Penambahan/penghapusan komentar, validasi komentar kosong/spasi, *Favorite*, dan *Follow* penulis | 7 |
| [Feed & Navigation (FEED)](./Feed_Navigation/TC_FEED.md) | Filter *Popular Tags*, lini masa `Your Feed`, *pagination* `Global Feed`, dan tab artikel di profil | 4 |

**Total Test Cases: 35**

---

## Directory Structure

```text
Test_Cases/
├── README.md
├── Authentication/TC_AUTH.md
├── Profile_Settings/TC_PROF.md
├── Article_Management/TC_ART.md
├── Social_Interaction/TC_SOC.md
└── Feed_Navigation/TC_FEED.md
```

---

## Test Case Naming Convention

Format penamaan:

```text
TC-[MODULE]-[NUMBER]
```

*Keterangan nomor: seri `0xx` umumnya Positive Test, seri `1xx` Negative Test, dan seri `2xx` Boundary / Edge Case. Klasifikasi akhir mengikuti kolom `Type`; `TC-ART-202` merupakan pengecualian fungsional/positif.*

Contoh pada proyek ini:

```text
TC-AUTH-001
TC-AUTH-103
TC-PROF-001
TC-ART-201
TC-SOC-101
TC-FEED-001
```

---

## Test Case Status

| **Status** | **Description** |
| :--- | :--- |
| **Draft** | *Test case* sudah dibuat tetapi belum melalui tahap *review* |
| **Ready** | *Test case* sudah di-*review* dan siap dieksekusi di TestRail |
| **Executed** | *Test case* sudah dijalankan pada *environment* pengujian |
| **Passed** | Hasil aktual (*Actual Result*) sesuai dengan yang diharapkan (*Expected Result*) |
| **Failed** | Hasil aktual menyimpang dari *Expected Result* dan tercatat sebagai *bug* di Jira |
| **Blocked** | Eksekusi pengujian tidak dapat dilanjutkan karena kendala dependensi atau sistem |

---

## Traceability

| **Requirement / Feature** | **Test Cases** | **Linked Defects** |
| :--- | :--- | :--- |
| `REQ-01` — User Authentication | `TC-AUTH-001`–`003`, `101`–`106`, `201` | `CON-1` |
| `REQ-02` — Profile & Settings | `TC-PROF-001`, `002`, `101`, `201` | `CON-2`, `CON-3`, `CON-4` |
| `REQ-03` — Article Management | `TC-ART-001`–`004`, `101`–`103`, `201`–`203` | `CON-5` |
| `REQ-04` — Social Interaction | `TC-SOC-001`–`006`, `101` | `CON-6` |
| `REQ-05` — Feed & Navigation | `TC-FEED-001`–`004` | — |

---

## Related Documents

- [Master Test Plan](../Test_Plan/README.md)
- [Test Summary Report (TSR)](../Test_Reports/README.md)
- [TestRail Execution Report — Batch 1 (`AUTH` & `PROF`)](../Test_Reports/TestRun1_Batch1_AUTH_PROF.pdf)
- [TestRail Execution Report — Batch 2 (`ART`, `SOC` & `FEED`)](../Test_Reports/TestRun2_Batch2_ART_SOC_FEED.pdf)
- [Jira Bug Reports Export (`CON-1` – `CON-6`)](../Bug_Reports/Jira_Bugs_CON1-CON6.csv)

---

## Author

- **Created by:** Azza
- **Role:** Manual QA Engineer Portfolio Project
- **Last Updated:** November 2026