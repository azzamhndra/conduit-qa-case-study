-- ============================================================================
-- CONDUIT WEB APPLICATION - DATABASE SCHEMA & QA SEED DATA (MYSQL)
-- Project : End-to-End QA Portfolio (Release 1.0)
-- Author  : Azza
-- ============================================================================

USE conduit_qa_db;

-- SAFETY: the script targets the local QA schema above and does not drop tables by default.
-- To reset a disposable QA database, uncomment the following block only after confirming
-- that conduit_qa_db contains no data that needs to be preserved.
-- SET FOREIGN_KEY_CHECKS = 0;
-- DROP TABLE IF EXISTS follows;
-- DROP TABLE IF EXISTS favorites;
-- DROP TABLE IF EXISTS article_tags;
-- DROP TABLE IF EXISTS tags;
-- DROP TABLE IF EXISTS comments;
-- DROP TABLE IF EXISTS articles;
-- DROP TABLE IF EXISTS users;
-- SET FOREIGN_KEY_CHECKS = 1;

-- 1. Tabel Users (Modul AUTH & PROF)
CREATE TABLE users (
    user_id       INT AUTO_INCREMENT PRIMARY KEY,
    username      VARCHAR(50)  NOT NULL UNIQUE,
    email         VARCHAR(100) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    bio           TEXT,
    image         TEXT,
    created_at    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at    TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 2. Tabel Articles (Modul ART)
-- Catatan: Batas VARCHAR(250) pada kolom title mencerminkan batas backend pada defect CON-5
CREATE TABLE articles (
    article_id  INT AUTO_INCREMENT PRIMARY KEY,
    slug        VARCHAR(255) NOT NULL UNIQUE,
    title       VARCHAR(250) NOT NULL,
    description TEXT         NOT NULL,
    body        TEXT         NOT NULL,
    author_id   INT          NOT NULL,
    created_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_at  TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_articles_author FOREIGN KEY (author_id) REFERENCES users(user_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 3. Tabel Comments (Modul SOC)
CREATE TABLE comments (
    comment_id INT AUTO_INCREMENT PRIMARY KEY,
    body       TEXT      NOT NULL,
    article_id INT       NOT NULL,
    author_id  INT       NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_comments_article FOREIGN KEY (article_id) REFERENCES articles(article_id) ON DELETE CASCADE,
    CONSTRAINT fk_comments_author  FOREIGN KEY (author_id)  REFERENCES users(user_id)    ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 4. Tabel Tags & Relasi Many-to-Many Article_Tags (Modul ART & FEED)
CREATE TABLE tags (
    tag_id INT AUTO_INCREMENT PRIMARY KEY,
    name   VARCHAR(50) NOT NULL UNIQUE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE article_tags (
    article_id INT NOT NULL,
    tag_id     INT NOT NULL,
    PRIMARY KEY (article_id, tag_id),
    CONSTRAINT fk_articletags_article FOREIGN KEY (article_id) REFERENCES articles(article_id) ON DELETE CASCADE,
    CONSTRAINT fk_articletags_tag     FOREIGN KEY (tag_id)     REFERENCES tags(tag_id)         ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 5. Tabel Favorites (Modul SOC & FEED)
CREATE TABLE favorites (
    user_id    INT       NOT NULL,
    article_id INT       NOT NULL,
    created_at TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (user_id, article_id),
    CONSTRAINT fk_favorites_user    FOREIGN KEY (user_id)    REFERENCES users(user_id)       ON DELETE CASCADE,
    CONSTRAINT fk_favorites_article FOREIGN KEY (article_id) REFERENCES articles(article_id) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- 6. Tabel Follows (Modul SOC & FEED - Your Feed)
CREATE TABLE follows (
    follower_id  INT       NOT NULL,
    following_id INT       NOT NULL,
    created_at   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (follower_id, following_id),
    CONSTRAINT fk_follows_follower  FOREIGN KEY (follower_id)  REFERENCES users(user_id) ON DELETE CASCADE,
    CONSTRAINT fk_follows_following FOREIGN KEY (following_id) REFERENCES users(user_id) ON DELETE CASCADE,
    CONSTRAINT chk_no_self_follow   CHECK (follower_id <> following_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- ============================================================================
-- SEED DATA PENGUJIAN (Mencakup data normal & jejak anomali bug CON-1, CON-3, CON-6)
-- ============================================================================

INSERT INTO users (username, email, password_hash, bio, image) VALUES
('qa_author_01', 'qa_author_01@test.com', '$2b$10$hashedpasswordauthor01', 'Manual & API QA Engineer', 'https://api.realworld.io/images/smiley-cyrus.jpeg'),
('qa_reader_01', 'qa_reader_01@test.com', '$2b$10$hashedpasswordreader01', 'Tech reader and reviewer', 'https://api.realworld.io/images/demo-avatar.png'),
('qa_boundary_02', 'qatest@', '$2b$10$hashedpasswordedge02', 'Akun uji validasi email tanpa domain (CON-1)', 'bukan-url-gambar');

INSERT INTO articles (slug, title, description, body, author_id) VALUES
('panduan-dasar-qa-manual-untuk-pemula', 'Panduan Dasar QA Manual untuk Pemula', 'Pengenalan fundamental software testing dan siklus hidup bug', '# Pendahuluan\n**Software Testing** memastikan kualitas aplikasi sebelum rilis.', 1),
('strategi-pengujian-rest-api-dengan-postman', 'Strategi Pengujian REST API dengan Postman', 'Validasi status code, payload JSON, dan token autentikasi', 'Pengujian API membantu mendeteksi bug backend lebih awal.', 1),
('checklist-validasi-integritas-database-sql', 'Checklist Validasi Integritas Database SQL', 'Memastikan konsistensi relasi tabel dan constraint di MySQL', 'Gunakan JOIN dan agregasi untuk memverifikasi akurasi data UI.', 2);

INSERT INTO tags (name) VALUES
('qa'),
('testing'),
('postman'),
('sql'),
('mysql');

INSERT INTO article_tags (article_id, tag_id) VALUES
(1, 1), (1, 2),
(2, 1), (2, 3),
(3, 4), (3, 5);

INSERT INTO comments (body, article_id, author_id) VALUES
('Artikel yang sangat informatif dan mudah dipahami!', 1, 2),
('Terima kasih atas panduannya, sangat membantu untuk persiapan portofolio.', 1, 3),
('     ', 1, 2); -- Anomali CON-6: Komentar hanya berisi spasi yang lolos validasi UI

INSERT INTO favorites (user_id, article_id) VALUES
(2, 1),
(3, 1),
(2, 2);

INSERT INTO follows (follower_id, following_id) VALUES
(2, 1), -- qa_reader_01 mem-follow qa_author_01
(3, 1); -- qa_boundary_02 mem-follow qa_author_01