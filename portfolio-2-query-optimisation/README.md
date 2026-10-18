# Portfolio 2: Query Processing and Optimisation

## Overview
This portfolio contains 10 SQL queries written for the Greenfield Community Library database, ranging from basic JOINs to advanced Window Functions. 

## Query Results
Screenshot of the 10 queries executing successfully can be found in `query-results.png`.

## Optimisation Exercise
**Target Query:** Query 4 (Top 5 most borrowed titles)

### Before Optimisation
- **Execution Plan:** Sequential Scan (`Seq Scan`) on the `loans` table.
- **Analysis:** PostgreSQL had to read every single row in the `loans` table to find matches, which is inefficient as the database grows.
- **Execution Time:** ~5.3 ms
- **Screenshot:** `before-index.png`

### Action Taken
Added a B-Tree index to the foreign key column:
`CREATE INDEX idx_loans_copy_id ON loans(copy_id);`

### After Optimisation
- **Execution Plan:** Changed to a Bitmap Index Scan / Index Scan.
- **Analysis:** PostgreSQL can now use the index to quickly locate the relevant `copy_id` without scanning the whole table.
- **Screenshot:** `after-index.png`

## Conclusion
Adding an index significantly improves query performance for JOIN operations by reducing the number of rows the database engine needs to read.