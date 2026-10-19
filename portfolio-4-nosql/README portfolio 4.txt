# Portfolio 4: NoSQL and Advanced Data Models

## 1. The NoSQL Data Model (MongoDB)
For the Greenfield Community Library, we used **MongoDB** (a Document Database) to store our book catalogue. 

### Why Document Model?
A library holds many types of media: books, audiobooks, DVDs, and journals. 
In a relational database (SQL), storing an audiobook requires creating new columns (e.g., `narrator`, `duration_minutes`) which will be `NULL` for all physical books. This creates a sparse, messy table.
In MongoDB, we can store variable attributes easily because each document can have its own unique structure. 

### Evidence
In the `books` collection (Screenshot: `mongodb-cloud.png`):
- **Document 1 (Effective Java):** A physical book. It has an `isbn`, `publisher`, and an array of `copies` (each with a physical barcode and shelf location).
- **Document 2 (Intro to Data Science):** An audiobook. It does not have an ISBN, but it has unique fields like `duration_minutes`, `narrator`, and `format`. 

This flexibility is why the document model is highly suitable for a library catalogue with diverse media types and nested data (like an array of physical copies inside one book record).