# Portfolio 5: Distributed and Cloud Database Exercise

## 1. Cloud Deployment Evidence
For the Greenfield Community Library, we deployed our NoSQL catalogue using **MongoDB Atlas**, a fully managed cloud database service. 
- **Provider:** AWS (N. Virginia - us-east-1)
- **Tier:** M0 Free Tier (Shared Cluster)
- *Screenshot of the live cloud cluster attached: `mongodb-atlas-cluster.png`*

## 2. Replication
In a production environment, MongoDB Atlas automatically uses a **Replica Set** (typically 3 nodes). 
- One node is the **Primary** (handles all writes, like adding a new book).
- Two nodes are **Secondaries** (replicate the data and handle reads, like members searching the catalogue).
If the Primary node goes down, the Secondaries automatically elect a new Primary, ensuring high availability.

## 3. Sharding (Horizontal Scaling)
If the library grows to millions of books and users, a single server will run out of storage. We would implement **Sharding**.
- **Shard Key:** We would shard the `books` collection by `category` (e.g., "Fiction", "Science"). 
- This means all Fiction books are stored on Server A, and Science books on Server B. This distributes the read/write load.

## 4. CAP Theorem Trade-off
The CAP theorem states a distributed system can only guarantee two of three: Consistency, Availability, and Partition Tolerance.
For a library:
- **Catalogue Search (AP):** We prioritize **Availability** and **Partition Tolerance**. If a member searches for a book, it is better to return a slightly outdated result than to make the website crash. 
- **Borrowing/Fines (CP):** We prioritize **Consistency** and **Partition Tolerance**. We cannot allow two people to borrow the same book at the same time. The system must lock the record and ensure all nodes see the same data.