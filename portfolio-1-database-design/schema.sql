-- =========================================================
-- Greenfield Community Library - Relational Schema
-- MIT 8103 Advanced Database Systems - Portfolio 1
-- =========================================================

DROP TABLE IF EXISTS fines CASCADE;
DROP TABLE IF EXISTS loans CASCADE;
DROP TABLE IF EXISTS reservations CASCADE;
DROP TABLE IF EXISTS book_copies CASCADE;
DROP TABLE IF EXISTS book_authors CASCADE;
DROP TABLE IF EXISTS books CASCADE;
DROP TABLE IF EXISTS authors CASCADE;
DROP TABLE IF EXISTS categories CASCADE;
DROP TABLE IF EXISTS members CASCADE;
DROP TABLE IF EXISTS staff CASCADE;

-- Staff (librarians/admins)
CREATE TABLE staff (
    staff_id     SERIAL PRIMARY KEY,
    full_name    VARCHAR(100) NOT NULL,
    email        VARCHAR(150) UNIQUE NOT NULL,
    role         VARCHAR(30)  NOT NULL CHECK (role IN ('librarian','admin','assistant')),
    hired_on     DATE         NOT NULL DEFAULT CURRENT_DATE
);

-- Members
CREATE TABLE members (
    member_id       SERIAL PRIMARY KEY,
    full_name       VARCHAR(100) NOT NULL,
    email           VARCHAR(150) UNIQUE NOT NULL,
    phone           VARCHAR(20),
    membership_type VARCHAR(20) NOT NULL CHECK (membership_type IN ('student','public','staff')),
    joined_on       DATE NOT NULL DEFAULT CURRENT_DATE,
    is_active       BOOLEAN NOT NULL DEFAULT TRUE
);

-- Categories
CREATE TABLE categories (
    category_id   SERIAL PRIMARY KEY,
    name          VARCHAR(80) UNIQUE NOT NULL,
    description   TEXT
);

-- Authors
CREATE TABLE authors (
    author_id   SERIAL PRIMARY KEY,
    full_name   VARCHAR(100) NOT NULL,
    nationality VARCHAR(60)
);

-- Books (titles - bibliographic record)
CREATE TABLE books (
    book_id         SERIAL PRIMARY KEY,
    isbn            VARCHAR(20) UNIQUE NOT NULL,
    title           VARCHAR(200) NOT NULL,
    category_id     INTEGER REFERENCES categories(category_id),
    publisher       VARCHAR(120),
    published_year  INTEGER CHECK (published_year BETWEEN 1400 AND 2100),
    language        VARCHAR(40) DEFAULT 'English'
);

-- Many-to-many: books <-> authors
CREATE TABLE book_authors (
    book_id     INTEGER NOT NULL REFERENCES books(book_id) ON DELETE CASCADE,
    author_id   INTEGER NOT NULL REFERENCES authors(author_id) ON DELETE CASCADE,
    PRIMARY KEY (book_id, author_id)
);

-- Physical copies of a book
CREATE TABLE book_copies (
    copy_id      SERIAL PRIMARY KEY,
    book_id      INTEGER NOT NULL REFERENCES books(book_id) ON DELETE CASCADE,
    barcode      VARCHAR(30) UNIQUE NOT NULL,
    status       VARCHAR(20) NOT NULL DEFAULT 'available'
                 CHECK (status IN ('available','borrowed','reserved','lost','damaged')),
    shelf_loc    VARCHAR(30)
);

-- Loans (borrow transactions)
CREATE TABLE loans (
    loan_id       SERIAL PRIMARY KEY,
    copy_id       INTEGER NOT NULL REFERENCES book_copies(copy_id),
    member_id     INTEGER NOT NULL REFERENCES members(member_id),
    issued_by     INTEGER NOT NULL REFERENCES staff(staff_id),
    borrowed_on   TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    due_on        DATE NOT NULL,
    returned_on   TIMESTAMP,
    status        VARCHAR(20) NOT NULL DEFAULT 'active'
                  CHECK (status IN ('active','returned','overdue','lost')),
    CONSTRAINT chk_due_after_borrow CHECK (due_on >= borrowed_on::date)
);

-- Fines
CREATE TABLE fines (
    fine_id      SERIAL PRIMARY KEY,
    loan_id      INTEGER NOT NULL REFERENCES loans(loan_id) ON DELETE CASCADE,
    member_id    INTEGER NOT NULL REFERENCES members(member_id),
    amount       NUMERIC(10,2) NOT NULL CHECK (amount >= 0),
    reason       VARCHAR(60) NOT NULL DEFAULT 'overdue',
    is_paid      BOOLEAN NOT NULL DEFAULT FALSE,
    issued_on    TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    paid_on      TIMESTAMP
);

-- Reservations
CREATE TABLE reservations (
    reservation_id  SERIAL PRIMARY KEY,
    book_id         INTEGER NOT NULL REFERENCES books(book_id),
    member_id       INTEGER NOT NULL REFERENCES members(member_id),
    reserved_on     TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    status          VARCHAR(20) NOT NULL DEFAULT 'pending'
                    CHECK (status IN ('pending','fulfilled','cancelled','expired'))
);

-- Indexes
CREATE INDEX idx_loans_member       ON loans(member_id);
CREATE INDEX idx_loans_copy         ON loans(copy_id);
CREATE INDEX idx_loans_status_due   ON loans(status, due_on);
CREATE INDEX idx_copies_book        ON book_copies(book_id);
CREATE INDEX idx_fines_member_paid  ON fines(member_id, is_paid);

-- =========================================================
-- END OF SCHEMA
-- =========================================================