INSERT INTO categories (name, description) VALUES
('Programming', 'Software development and coding'), ('Databases', 'Database design and management'), ('Fiction', 'Novels and short stories'), ('Science', 'Scientific research and theory'), ('History', 'Historical accounts and biographies');

INSERT INTO authors (full_name, nationality) VALUES
('Joshua Bloch', 'American'), ('Martin Kleppmann', 'German'), ('Chinua Achebe', 'Nigerian'), ('Jane Austen', 'British'), ('Stephen Hawking', 'British');

INSERT INTO staff (full_name, email, role) VALUES
('Sarah Jenkins', 'sarah.j@greenfieldlib.org', 'librarian'), ('David Osei', 'david.o@greenfieldlib.org', 'admin'), ('Emily Chen', 'emily.c@greenfieldlib.org', 'assistant');

INSERT INTO members (full_name, email, phone, membership_type) VALUES
('John Doe', 'john@example.com', '555-0101', 'public'), ('Ada Lovelace', 'ada@example.com', '555-0102', 'student'), ('Chidi Okonkwo', 'chidi@example.com', '555-0103', 'student'), ('Mary Smith', 'mary@example.com', '555-0104', 'staff'), ('James Wilson', 'james@example.com', '555-0105', 'public');

INSERT INTO books (isbn, title, category_id, publisher, published_year) VALUES
('978-0134685991', 'Effective Java', 1, 'Addison-Wesley', 2018), ('978-1491950357', 'Designing Data-Intensive Applications', 2, 'OReilly Media', 2017), ('978-0385474542', 'Things Fall Apart', 3, 'Anchor Books', 1994), ('978-0141439518', 'Pride and Prejudice', 3, 'Penguin Classics', 2002), ('978-0553380163', 'A Brief History of Time', 4, 'Bantam', 1998);

INSERT INTO book_authors (book_id, author_id) VALUES
(1, 1), (2, 2), (3, 3), (4, 4), (5, 5);

INSERT INTO book_copies (book_id, barcode, status, shelf_loc) VALUES
(1, 'GF-0001', 'available', 'A1-01'), (1, 'GF-0002', 'borrowed', 'A1-01'), (2, 'GF-0003', 'available', 'B2-04'), (2, 'GF-0004', 'available', 'B2-04'), (3, 'GF-0005', 'borrowed', 'C1-12'), (3, 'GF-0006', 'available', 'C1-12'), (4, 'GF-0007', 'available', 'C1-15'), (5, 'GF-0008', 'available', 'D3-08');

INSERT INTO loans (copy_id, member_id, issued_by, borrowed_on, due_on, status) VALUES
(2, 1, 1, CURRENT_TIMESTAMP - INTERVAL '2 days', CURRENT_DATE + 12, 'active'), (5, 2, 2, CURRENT_TIMESTAMP - INTERVAL '20 days', CURRENT_DATE - 6, 'active');

INSERT INTO loans (copy_id, member_id, issued_by, borrowed_on, due_on, returned_on, status) VALUES
(1, 3, 1, CURRENT_TIMESTAMP - INTERVAL '30 days', CURRENT_DATE - 16, CURRENT_TIMESTAMP - INTERVAL '18 days', 'returned');

INSERT INTO fines (loan_id, member_id, amount, reason, is_paid) VALUES
(2, 2, 300.00, 'overdue', FALSE);

INSERT INTO reservations (book_id, member_id, status) VALUES
(2, 4, 'pending'), (4, 5, 'pending');
