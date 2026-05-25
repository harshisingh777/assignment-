# Entity Relationship Diagram (ERD)

```mermaid
erDiagram
    COURSES ||--o{ BATCHES : "hosts"
    BATCHES ||--o{ ENROLLMENTS : "contains"
    STUDENTS ||--o{ ENROLLMENTS : "undertakes"
    BATCHES ||--o{ CONTESTS : "schedules"
    CONTESTS ||--o{ CONTEST_PROBLEMS : "includes"
    PROBLEMS ||--o{ CONTEST_PROBLEMS : "maps_to"
    STUDENTS ||--o{ SUBMISSIONS : "executes"
    PROBLEMS ||--o{ SUBMISSIONS : "receives"
    CONTESTS ||--o{ SUBMISSIONS : "evaluates"
    SUBMISSIONS ||--o| PLAGIARISM_FLAGS : "checks"

    STUDENTS {
        int student_id PK
        string name
        string email UK
    }
    BATCHES {
        int batch_id PK
        string batch_name
        int course_id FK
    }
    ENROLLMENTS {
        int student_id PK, FK
        int batch_id PK, FK
    }
    SUBMISSIONS {
        int submission_id PK
        int student_id FK
        int problem_id FK
        string language
    }
