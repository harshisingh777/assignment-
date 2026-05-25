# Normalization Analysis & Architectural Trade-offs

### 1. Examples of Redundancy Identified in Raw Data
* **Raw Student Imports (`raw_student_import.csv`):** Denormalized files contain student names, emails, batch names, and course schedules flatly repeating on every single row. 
* **Submissions Flat Files:** Redundant structural logs showing problem titles, point weights, and contest details mixed right next to unique source code payloads.

### 2. Benefits of Splitting into Normalized Tables
* **Elimination of Update Anomalies:** Changing a course description or title now requires updating exactly **one row** in the `courses` table, rather than updating millions of historical rows inside a flat table.
* **Storage Reduction:** Storing strings like "Intro to SQL Programming" millions of times wastes storage footprint compared to linking an integer foreign key `course_id = 101`.

### 3. Normal Form Verification (Target: 3NF)
* **1NF (First Normal Form):** Verified. All attribute cells contain atomic, single values. No repeating multi-valued arrays exist within a row cell.
* **2NF (Second Normal Form):** Verified. All tables are in 1NF, and every non-prime attribute is fully functionally dependent on the complete primary key (No partial dependencies present on composite keys like `enrollments`).
* **3NF (Third Normal Form):** Verified. No transitive dependencies are allowed. Non-prime attributes depend solely upon the primary key (e.g., batch names depend on `batch_id`, not transitively via student profiles).

### 4. Applied Trade-offs
* **Read Performance vs. Normalization:** To compute leaderboard tallies quickly, writing intensive query chains requires a highly normalized schema. We trade away write latency (which now involves updating multiple tables during complex workflows) for robust data hygiene and low update overhead.
