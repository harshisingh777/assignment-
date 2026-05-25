# Database Keys and Integrity Constraints

The structural safety of the CodeJudge ecosystem relies heavily on explicit constraint declarations:

| Table Name | Primary Key | Foreign Key(s) | Candidate / Unique Keys | NOT NULL Constraints |
| :--- | :--- | :--- | :--- | :--- |
| **students** | `student_id` | None | `email` | `name`, `email` |
| **batches** | `batch_id` | `course_id` | None | `batch_name`, `course_id` |
| **enrollments** | `(student_id, batch_id)` | `student_id`, `batch_id` | None | `student_id`, `batch_id` |
| **contest_problems**| `(contest_id, problem_id)`| `contest_id`, `problem_id`| None | `contest_id`, `problem_id` |
| **submissions** | `submission_id` | `student_id`, `problem_id`, `contest_id` | None | `student_id`, `problem_id`, `submitted_at` |
| **test_results** | `test_result_id` | `submission_id`, `test_case_id`| None | `submission_id`, `status` |
| **plagiarism_flags**| `flag_id` | `submission_id` | None | `submission_id`, `similarity_score` |

### Constraint Justifications

* **Foreign Keys:** Enforce **Referential Integrity**. For example, a row in `plagiarism_flags` cannot point to a non-existent `submission_id`. If a submission is deleted, cascading logic manages downstream integrity.
* **Unique Constraints:** Ensures business operations stay distinct (e.g., two students cannot share an identical platform login `email`).
* **NOT NULL Constraints:** Protects downstream logic from application crashes. A submission must record *who* submitted it (`student_id`) and *when* (`submitted_at`).
