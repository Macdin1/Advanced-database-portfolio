-- ==========================================
-- PORTFOLIO 2: Query Processing & Optimisation
-- Greenfield Community Library
-- ==========================================

-- Q1: List all books with their category and authors
SELECT b.title, c.name AS category, STRING_AGG(a.full_name, ', ') AS authors
FROM books b
LEFT JOIN categories c ON c.category_id = b.category_id
LEFT JOIN book_authors ba ON ba.book_id = b.book_id
LEFT JOIN authors a ON a.author_id = ba.author_id
GROUP BY b.book_id, b.title, c.name
ORDER BY b.title;

-- Q2: Currently borrowed books (not yet returned)
SELECT l.loan_id, m.full_name AS member, b.title, l.borrowed_on, l.due_on
FROM loans l
JOIN members m ON m.member_id = l.member_id
JOIN book_copies bc ON bc.copy_id = l.copy_id
JOIN books b ON b.book_id = bc.book_id
WHERE l.status = 'active'
ORDER BY l.due_on;

-- Q3: Overdue loans with days overdue
SELECT l.loan_id, m.full_name, b.title, l.due_on, CURRENT_DATE - l.due_on AS days_overdue
FROM loans l
JOIN members m ON m.member_id = l.member_id
JOIN book_copies bc ON bc.copy_id = l.copy_id
JOIN books b ON b.book_id = bc.book_id
WHERE l.status = 'active' AND l.due_on < CURRENT_DATE
ORDER BY days_overdue DESC;

-- Q4: Top 5 most borrowed titles
SELECT b.title, COUNT(*) AS times_borrowed
FROM loans l
JOIN book_copies bc ON bc.copy_id = l.copy_id
JOIN books b ON b.book_id = bc.book_id
GROUP BY b.book_id, b.title
ORDER BY times_borrowed DESC
LIMIT 5;

-- Q5: Members with unpaid fines
SELECT m.member_id, m.full_name, SUM(f.amount) AS total_unpaid
FROM members m
JOIN fines f ON f.member_id = m.member_id
WHERE f.is_paid = FALSE
GROUP BY m.member_id, m.full_name
HAVING SUM(f.amount) > 0
ORDER BY total_unpaid DESC;

-- Q6: Window function — rank members by number of loans
SELECT m.full_name, COUNT(l.loan_id) AS loans_count,
       RANK() OVER (ORDER BY COUNT(l.loan_id) DESC) AS rank
FROM members m
LEFT JOIN loans l ON l.member_id = m.member_id
GROUP BY m.member_id, m.full_name;

-- Q7: Books never borrowed
SELECT b.title
FROM books b
WHERE b.book_id NOT IN (
    SELECT bc.book_id FROM book_copies bc
    JOIN loans l ON l.copy_id = bc.copy_id
);

-- Q8: Monthly loan statistics
SELECT DATE_TRUNC('month', borrowed_on) AS month, COUNT(*) AS loans
FROM loans
GROUP BY month
ORDER BY month;

-- Q9: Average loan duration per category
SELECT c.name AS category,
       ROUND(AVG(EXTRACT(EPOCH FROM (returned_on - borrowed_on))/86400),1) AS avg_days
FROM loans l
JOIN book_copies bc ON bc.copy_id = l.copy_id
JOIN books b ON b.book_id = bc.book_id
JOIN categories c ON c.category_id = b.category_id
WHERE l.returned_on IS NOT NULL
GROUP BY c.name
ORDER BY avg_days DESC;

-- Q10: Members who currently have 5+ active loans
SELECT m.full_name, COUNT(*) AS active_loans
FROM loans l
JOIN members m ON m.member_id = l.member_id
WHERE l.status = 'active'
GROUP BY m.member_id, m.full_name
HAVING COUNT(*) >= 5;