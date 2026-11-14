-- ============================================================================
-- CONDUIT WEB APPLICATION - SQL DATA INTEGRITY & QA AUDIT QUERIES (MYSQL)
-- Database : conduit_qa_db
-- ============================================================================

USE conduit_qa_db;

-- ----------------------------------------------------------------------------
-- SQL-VAL-001: Audit Kualitas Data Profil Pengguna (Deteksi Bug CON-1 & CON-3)
-- Tujuan: Memeriksa format email tidak lengkap tanpa domain & format URL avatar
-- ----------------------------------------------------------------------------
SELECT
    user_id,
    username,
    email,
    image,
    CASE
        WHEN email NOT REGEXP '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$'
            THEN 'FAILED - Format Email Tidak Valid (CON-1)'
        ELSE 'PASSED'
    END AS email_validation_status,
    CASE
        WHEN image IS NOT NULL AND image NOT REGEXP '^https?://.+'
            THEN 'FAILED - URL Avatar Tidak Valid (CON-3)'
        ELSE 'PASSED'
    END AS image_url_status
FROM users
ORDER BY user_id;

-- ----------------------------------------------------------------------------
-- SQL-VAL-002: Verifikasi Relasi Artikel, Penulis & Agregasi Tag (Global Feed)
-- Tujuan: Memastikan data artikel, author, dan daftar tag sesuai tampilan UI
-- ----------------------------------------------------------------------------
SELECT
    a.article_id,
    a.slug,
    a.title,
    u.username AS author_username,
    COALESCE(GROUP_CONCAT(t.name ORDER BY t.name SEPARATOR ', '), 'No Tags') AS tag_list,
    a.created_at
FROM articles a
JOIN users u ON a.author_id = u.user_id
LEFT JOIN article_tags at ON a.article_id = at.article_id
LEFT JOIN tags t ON at.tag_id = t.tag_id
GROUP BY a.article_id, a.slug, a.title, u.username, a.created_at
ORDER BY a.article_id;

-- ----------------------------------------------------------------------------
-- SQL-VAL-003: Rekonsiliasi Jumlah Favorite per Artikel (Modul SOC)
-- Tujuan: Memastikan favoritesCount pada API/UI cocok dengan tabel favorites
-- ----------------------------------------------------------------------------
SELECT
    a.article_id,
    a.title,
    COUNT(f.user_id) AS actual_favorites_count,
    COALESCE(GROUP_CONCAT(u.username ORDER BY u.username SEPARATOR ', '), '-') AS favorited_by
FROM articles a
LEFT JOIN favorites f ON a.article_id = f.article_id
LEFT JOIN users u ON f.user_id = u.user_id
GROUP BY a.article_id, a.title
ORDER BY actual_favorites_count DESC, a.article_id ASC;

-- ----------------------------------------------------------------------------
-- SQL-VAL-004: Validasi Personalized Feed / Your Feed (TC-FEED-002)
-- Tujuan: Memverifikasi artikel yang muncul untuk user 'qa_reader_01'
--         hanya berasal dari penulis yang di-follow di tabel follows
-- ----------------------------------------------------------------------------
SELECT
    follower.username AS current_user,
    author.username   AS followed_author,
    a.article_id,
    a.title,
    a.created_at
FROM follows fl
JOIN users follower ON fl.follower_id = follower.user_id
JOIN users author   ON fl.following_id = author.user_id
JOIN articles a     ON a.author_id = author.user_id
WHERE follower.username = 'qa_reader_01'
ORDER BY a.created_at DESC;

-- ----------------------------------------------------------------------------
-- SQL-VAL-005: Validasi Filter Popular Tags (TC-FEED-001)
-- Tujuan: Menghitung frekuensi penggunaan setiap tag pada artikel aktif
-- ----------------------------------------------------------------------------
SELECT
    t.tag_id,
    t.name AS tag_name,
    COUNT(at.article_id) AS usage_count
FROM tags t
LEFT JOIN article_tags at ON t.tag_id = at.tag_id
GROUP BY t.tag_id, t.name
ORDER BY usage_count DESC, t.name ASC;

-- ----------------------------------------------------------------------------
-- SQL-VAL-006: Audit Sanitasi Komentar & Deteksi Whitespace Bug (CON-6)
-- Tujuan: Mendeteksi komentar kosong atau hanya berisi karakter spasi
-- ----------------------------------------------------------------------------
SELECT
    c.comment_id,
    a.slug AS article_slug,
    u.username AS commenter,
    CHAR_LENGTH(c.body) AS raw_length,
    CHAR_LENGTH(TRIM(c.body)) AS trimmed_length,
    CASE
        WHEN CHAR_LENGTH(TRIM(c.body)) = 0
            THEN 'FAILED - Whitespace-Only Comment (CON-6)'
        ELSE 'PASSED'
    END AS sanitization_status
FROM comments c
JOIN articles a ON c.article_id = a.article_id
JOIN users u    ON c.author_id = u.user_id
ORDER BY c.comment_id;

-- ----------------------------------------------------------------------------
-- SQL-VAL-007: Referential Integrity & Orphan Records Check
-- Tujuan: Memeriksa seluruh relasi foreign key pada model data simulasi
-- ----------------------------------------------------------------------------
SELECT 'Orphan Articles (Invalid Author)' AS check_name, COUNT(*) AS orphan_count
FROM articles a LEFT JOIN users u ON a.author_id = u.user_id WHERE u.user_id IS NULL
UNION ALL
SELECT 'Orphan Comments (Invalid Article)', COUNT(*)
FROM comments c LEFT JOIN articles a ON c.article_id = a.article_id WHERE a.article_id IS NULL
UNION ALL
SELECT 'Orphan Comments (Invalid Author)', COUNT(*)
FROM comments c LEFT JOIN users u ON c.author_id = u.user_id WHERE u.user_id IS NULL
UNION ALL
SELECT 'Orphan Article Tags (Invalid Article)', COUNT(*)
FROM article_tags at LEFT JOIN articles a ON at.article_id = a.article_id WHERE a.article_id IS NULL
UNION ALL
SELECT 'Orphan Article Tags (Invalid Tag)', COUNT(*)
FROM article_tags at LEFT JOIN tags t ON at.tag_id = t.tag_id WHERE t.tag_id IS NULL
UNION ALL
SELECT 'Orphan Favorites (Invalid User/Article)', COUNT(*)
FROM favorites f
LEFT JOIN users u ON f.user_id = u.user_id
LEFT JOIN articles a ON f.article_id = a.article_id
WHERE u.user_id IS NULL OR a.article_id IS NULL
UNION ALL
SELECT 'Orphan Follows (Invalid Follower)', COUNT(*)
FROM follows fl LEFT JOIN users u ON fl.follower_id = u.user_id WHERE u.user_id IS NULL
UNION ALL
SELECT 'Orphan Follows (Invalid Followed User)', COUNT(*)
FROM follows fl LEFT JOIN users u ON fl.following_id = u.user_id WHERE u.user_id IS NULL;

-- ----------------------------------------------------------------------------
-- SQL-VAL-008: Boundary & Constraint Verification (Konfirmasi Bug CON-5)
-- Tujuan: Memverifikasi batasan panjang kolom title VARCHAR(250) pada skema DB
-- ----------------------------------------------------------------------------
SELECT
    table_name,
    column_name,
    data_type,
    character_maximum_length
FROM information_schema.columns
WHERE table_schema = DATABASE()
  AND table_name = 'articles'
  AND column_name = 'title';