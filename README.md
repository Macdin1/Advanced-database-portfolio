# MIT 8103 Advanced Database Systems - Portfolio
**Case Study:** Greenfield Community Library
**Student:** Macdonald Enerijiofi
**Academic Session:** 2026/2027, First Semester

## 📚 Case Study Overview
Greenfield Community Library is a mid-sized public/university library. The database supports librarians, members, and admin staff. It manages books, authors, physical book copies, loans, returns, fines, and reservations. Key operations include borrowing books, returning books, calculating overdue fines, and managing the catalogue.

## 🗂️ Portfolio Structure
- [Portfolio 1: Database Design & Modelling](./portfolio-1-database-design/)
- [Portfolio 2: Query Processing & Optimisation](./portfolio-2-query-optimisation/)
- [Portfolio 3: Transactions & Concurrency](./portfolio-3-transactions-concurrency/)
- [Portfolio 4: NoSQL & Advanced Data Models](./portfolio-4-nosql/)
- [Portfolio 5: Distributed & Cloud Database](./portfolio-5-distributed-cloud/)

## 🛠️ Tools Used
- **PostgreSQL 16** (Relational Database)
- **MongoDB Atlas** (Cloud NoSQL Database)
- **Git & GitHub** (Version Control)
- **PowerShell** (CLI for database management)

## 🧠 Individual Technical Reflection
Through this portfolio, I learned how to translate a real-world library workflow into a normalised relational schema using PostgreSQL. A key challenge was handling the "max 5 books per member" rule, which I realised requires application-level logic or a trigger rather than a simple CHECK constraint.

Implementing query optimisation in Portfolio 2 demonstrated the massive impact of indexing on JOIN performance. Moving to Portfolio 4, I explored the NoSQL document model. I learned that while SQL is perfect for strict transactional data (like loans and fines), a document model is vastly superior for variable catalogue metadata (e.g., mixing physical books and audiobooks with different attributes). Finally, using MongoDB Atlas for Portfolio 5 gave me practical insight into cloud deployment, replication, and the CAP theorem. 

## 🤖 AI Use Declaration
- **Tool Used:** ChatGPT (OpenAI)
- **Purpose:** Used as a learning aid to format GitHub documentation, troubleshoot Windows PATH environment variables for PostgreSQL/MongoDB, and verify SQL syntax.
- **Verification:** All SQL queries, transactions, and concurrency locks were executed and verified locally on my machine. The NoSQL architecture was deployed and tested on MongoDB Atlas. The concepts were cross-referenced with official PostgreSQL and MongoDB documentation.
