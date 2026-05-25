# CodeJudge Database System — Schema Explanation

This document outlines the core entities identified within the raw CodeJudge dataset, their real-world system responsibilities, and structural constraints.

## Core Entities & Architecture

### 1. Students
* **What it represents:** Users registered on the CodeJudge platform who write and submit code.
* **Why a separate table:** Contains student-specific static attributes (e.g., name, email) which should not repeat every time a student makes a submission or marks attendance.
* **Primary Key:** `student_id` (Unique, NOT NULL)
* **Unique Columns:** `email`

### 2. Batches
* **What it represents:** Time-bound operational cohorts or classes of students.
* **Why a separate table:** Isolates batch metadata (start dates, active status) from individual student entities.
* **Primary Key:** `batch_id`

### 3. Courses
* **What it represents:** The curriculum modules or syllabus units taught.
* **Why a separate table:** Multiple batches can run the same course over time; separating it prevents curriculum data duplication.
* **Primary Key:** `course_id`

### 4. Enrollments
* **What it represents:** The functional junction table linking a Student to a specific Batch.
* **Primary Key:** Composite Key `(student_id, batch_id)`
* **Foreign Keys:** `student_id` referencing `Students(student_id)`, `batch_id` referencing `Batches(batch_id)`

### 5. Contests & Problems
* **Contests:** Coding evaluations mapped to specific dates/batches. (PK: `contest_id`)
* **Problems:** Individual programmatic algorithmic tasks with specific statement descriptions and point tallies. (PK: `problem_id`)

### 6. Contest-Problem Mappings
* **What it represents:** A many-to-many lookup table because a single problem can be featured across multiple coding contests.
* **Primary Key:** Composite Key `(contest_id, problem_id)`

### 7. Submissions & Test Results
* **Submissions:** Captures the raw code record sent by a student for a problem. (PK: `submission_id`)
* **Test Results:** Fine-grained execution metrics (CPU time, memory consumption, status like 'AC' or 'TLE') against individual hidden test cases for each submission. (PK: `test_result_id`)

### 8. Sessions & Attendance
* **Sessions:** Live class occurrences or lecture events. (PK: `session_id`)
* **Attendance:** Trackers mapping which student attended which scheduled session. (PK: `attendance_id` or composite `(student_id, session_id)`)

### 9. Operational Tables (Regrade Requests, Plagiarism Flags, Operation Requests)
* Isolated handling of background system exceptions. Plagiarism flags maintain a strict foreign key constraint referencing `submission_id`.
