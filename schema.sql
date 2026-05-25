-- ==========================================
-- CODEJUDGE SYSTEM RELATIONAL SCHEMA DDL
-- ==========================================

-- 1. Course Table
CREATE TABLE courses (
    course_id INTEGER PRIMARY KEY AUTOINCREMENT,
    course_name VARCHAR(255) NOT NULL,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 2. Batches Table
CREATE TABLE batches (
    batch_id INTEGER PRIMARY KEY AUTOINCREMENT,
    batch_name VARCHAR(100) NOT NULL,
    course_id INTEGER NOT NULL,
    start_date DATE NOT NULL,
    is_active BOOLEAN DEFAULT 1,
    FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE
);

-- 3. Students Table
CREATE TABLE students (
    student_id INTEGER PRIMARY KEY AUTOINCREMENT,
    name VARCHAR(155) NOT NULL,
    email VARCHAR(255) NOT NULL UNIQUE,
    joined_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- 4. Enrollments Table (Many-to-Many Junction)
CREATE TABLE enrollments (
    student_id INTEGER NOT NULL,
    batch_id INTEGER NOT NULL,
    enrolled_at DATE DEFAULT CURRENT_DATE,
    PRIMARY KEY (student_id, batch_id),
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (batch_id) REFERENCES batches(batch_id) ON DELETE CASCADE
);

-- 5. Contests Table
CREATE TABLE contests (
    contest_id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(200) NOT NULL,
    batch_id INTEGER NOT NULL,
    start_time TIMESTAMP NOT NULL,
    end_time TIMESTAMP NOT NULL,
    FOREIGN KEY (batch_id) REFERENCES batches(batch_id) ON DELETE CASCADE
);

-- 6. Problems Table
CREATE TABLE problems (
    problem_id INTEGER PRIMARY KEY AUTOINCREMENT,
    title VARCHAR(255) NOT NULL,
    difficulty VARCHAR(50) CHECK (difficulty IN ('Easy', 'Medium', 'Hard')),
    max_score INTEGER DEFAULT 100
);

-- 7. Contest-Problem Mappings Table
CREATE TABLE contest_problems (
    contest_id INTEGER NOT NULL,
    problem_id INTEGER NOT NULL,
    sequence_order INTEGER DEFAULT 1,
    PRIMARY KEY (contest_id, problem_id),
    FOREIGN KEY (contest_id) REFERENCES contests(contest_id) ON DELETE CASCADE,
    FOREIGN KEY (problem_id) REFERENCES problems(problem_id) ON DELETE CASCADE
);

-- 8. Submissions Table
CREATE TABLE submissions (
    submission_id INTEGER PRIMARY KEY AUTOINCREMENT,
    student_id INTEGER NOT NULL,
    problem_id INTEGER NOT NULL,
    contest_id INTEGER,
    language VARCHAR(50) NOT NULL,
    code_payload TEXT NOT NULL,
    submitted_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (problem_id) REFERENCES problems(problem_id) ON DELETE CASCADE,
    FOREIGN KEY (contest_id) REFERENCES contests(contest_id) ON DELETE SET NULL
);

-- 9. Plagiarism Flags Table
CREATE TABLE plagiarism_flags (
    flag_id INTEGER PRIMARY KEY AUTOINCREMENT,
    submission_id INTEGER NOT NULL,
    similarity_score REAL NOT NULL CHECK (similarity_score BETWEEN 0.0 AND 100.0),
    flagged_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (submission_id) REFERENCES submissions(submission_id) ON DELETE CASCADE
);
