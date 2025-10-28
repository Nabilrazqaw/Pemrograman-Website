CREATE TABLE departments (
dept_id INT PRIMARY KEY,
dept_name VARCHAR(100)
);

CREATE TABLE students (
student_id INT PRIMARY KEY,
student_name VARCHAR(100),
entry_year INT,
dept_id INT,
FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE lecturers (
lect_id INT PRIMARY KEY,
lect_name VARCHAR(100),
dept_id INT,
FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE courses (
course_id INT PRIMARY KEY,
course_code VARCHAR(20) UNIQUE,
course_title VARCHAR(150),
credits INT,
dept_id INT,
FOREIGN KEY (dept_id) REFERENCES departments(dept_id)
);

CREATE TABLE classes (
class_id INT PRIMARY KEY,
course_id INT,
lect_id INT,
semester VARCHAR(10), -- misal: '2025-1'
FOREIGN KEY (course_id) REFERENCES courses(course_id),
FOREIGN KEY (lect_id) REFERENCES lecturers(lect_id)
);

CREATE TABLE rooms (
room_id INT PRIMARY KEY,
room_name VARCHAR(50),
capacity INT
);

CREATE TABLE schedules (
schedule_id INT PRIMARY KEY,
class_id INT,
room_id INT,
day_of_week VARCHAR(10), 
start_time TIME,
end_time TIME,
FOREIGN KEY (class_id) REFERENCES classes(class_id),
FOREIGN KEY (room_id) REFERENCES rooms(room_id)
);

CREATE TABLE enrollments (
student_id INT,
class_id INT,
grade VARCHAR(2), -- contoh: 'A','B','C', NULL bila belum nilai
PRIMARY KEY (student_id, class_id),
FOREIGN KEY (student_id) REFERENCES students(student_id),
FOREIGN KEY (class_id) REFERENCES classes(class_id)
);

CREATE TABLE prerequisites (
course_id INT,
prereq_id INT,
PRIMARY KEY (course_id, prereq_id),
FOREIGN KEY (course_id) REFERENCES courses(course_id),
FOREIGN KEY (prereq_id) REFERENCES courses(course_id)
);

CREATE TABLE lecturer_supervisions (
lect_id INT,
supervisor_id INT,
PRIMARY KEY (lect_id, supervisor_id),
FOREIGN KEY (lect_id) REFERENCES lecturers(lect_id),
FOREIGN KEY (supervisor_id) REFERENCES lecturers(lect_id)
);

INSERT INTO departments VALUES
(10,'Sistem Informasi Kelautan'),
(20,'Ilmu Komputer'),
(30,'Biologi Kelautan');

INSERT INTO students VALUES
(2103118,'Roni Antonius Sinabutar',2021,10),
(2103120,'Salsa Aurelia',2021,10),
(2204101,'Rakhil Syakira Yusuf',2022,10),
(2205205,'Adit Pratama',2022,20),
(2306102,'Nadia Putri',2023,20),
(2307107,'Bima Mahesa',2023,30);

INSERT INTO lecturers VALUES
(501, 'Willdan',10),
(502,'Supriadi',10),
(503,'Ayang',20),
(504,'Alam',30),
(505,'Luthfi',10);

INSERT INTO courses VALUES
(1001,'KL202','Algoritma & Pemrograman',3,10),
(1002,'KL218','Sistem Basis Data',3,10),
(1003,'CS101','Pengantar Ilmu Komputer',2,20),
(1004,'CS205','Basis Data Lanjut',3,20),
(1005,'MB110','Biologi Laut Dasar',2,30),
(1006,'KL305','SIG Kelautan',3,10);

INSERT INTO classes VALUES
(9001,1002,501,'2025-1'), -- SBD oleh Willdan
(9002,1001,502,'2025-1'), -- Algo oleh Supriadi
(9003,1003,503,'2025-1'), -- Pengantar IK oleh Ayang
(9004,1005,504,'2025-1'), -- Biologi Laut Dasar oleh Alam
(9005,1004,503,'2025-1'), -- Basis Data Lanjut oleh Ayang
(9006,1006,505,'2025-1'); -- SIG Kelautan oleh Luthfi

INSERT INTO rooms VALUES
(221,'Lab Big Data',30),
(222,'Ruang Kuliah 201',40),
(223,'Lab Komputasi 1',25),
(224,'Aula 3',100);

INSERT INTO schedules VALUES
(7001,9001,3,'Monday','08:00','10:30'),
(7002,9002,2,'Tuesday','10:00','12:00'),
(7003,9003,2,'Wednesday','08:00','10:00'),
(7004,9004,4,'Thursday','13:00','15:00'),
(7005,9005,3,'Friday','09:00','11:30'),
(7006,9006,1,'Monday','13:00','15:30');

INSERT INTO enrollments VALUES
(2103118,9001,'A'),
(2103118,9002,'B'),
(2103120,9001,'B'),
(2103120,9006,'A'),
(2204101,9001,NULL),
(2204101,9005,NULL),
(2205205,9003,'A'),
(2306102,9003,'B'),
(2306102,9005,NULL),
(2307107,9004,'A');

INSERT INTO prerequisites VALUES
(1004,1002), -- Basis Data Lanjut mensyaratkan Sistem Basis Data
(1006,1001); -- SIG Kelautan mensyaratkan Algoritma & Pemrograman

INSERT INTO lecturer_supervisions VALUES
(501,505), -- Willdan dibina oleh Luthfi
(502,501), -- Supriadi dibina oleh Willdan
(503,501), -- Ayang dibina oleh Willdan
(504,505); -- Alam dibina oleh Luthfi

## no 1

SELECT s.student_name, d.dept_name
FROM students s
JOIN departments d ON s.dept_id = d.dept_id;

## no 2
SELECT c.class_id, cr.course_code, cr.course_title, l.lect_name
FROM classes c
JOIN courses cr ON c.course_id = cr.course_id
JOIN lecturers l ON c.lect_id = l.lect_id;


## no 3
SELECT s.student_id, s.student_name
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN classes c ON e.class_id = c.class_id
WHERE c.course_id = 1002;


## no 4
SELECT cr.course_code, cr.course_title, sch.day_of_week, sch.start_time, sch.end_time, r.room_name
FROM schedules sch
JOIN classes c ON sch.class_id = c.class_id
JOIN courses cr ON c.course_id = cr.course_id
JOIN rooms r ON sch.room_id = r.room_id;

## no 5
SELECT d.dept_name, COUNT(DISTINCT e.student_id) AS jumlah_mahasiswa
FROM enrollments e
JOIN classes c ON e.class_id = c.class_id AND c.semester = '2025-1'
JOIN students s ON e.student_id = s.student_id
JOIN departments d ON s.dept_id = d.dept_id
GROUP BY d.dept_name;

## no 6
SELECT c.class_id, cr.course_code, cr.course_title, l.lect_name, l.dept_id AS lect_dept, cr.dept_id AS course_dept
FROM classes c
JOIN courses cr ON c.course_id = cr.course_id
JOIN lecturers l ON c.lect_id = l.lect_id
WHERE l.dept_id = cr.dept_id;

## no 7
SELECT DISTINCT s.student_id, s.student_name, cr.course_code, cr.course_title, cr.dept_id AS course_dept
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN classes cl ON e.class_id = cl.class_id
JOIN courses cr ON cl.course_id = cr.course_id
WHERE s.dept_id = 10 AND cr.dept_id <> 10;

## no 8
SELECT c.course_code AS course, c.course_title AS course_title,
       p.course_code AS prereq_code, p.course_title AS prereq_title
FROM prerequisites pr
JOIN courses c ON pr.course_id = c.course_id
JOIN courses p ON pr.prereq_id = p.course_id;

## no 9
SELECT l.lect_name AS dosen, sup.lect_name AS pembina
FROM lecturer_supervisions ls
JOIN lecturers l ON ls.lect_id = l.lect_id
JOIN lecturers sup ON ls.supervisor_id = sup.lect_id;

## no 10
SELECT DISTINCT c.class_id, cr.course_code, cr.course_title
FROM enrollments e
JOIN classes c ON e.class_id = c.class_id
JOIN courses cr ON c.course_id = cr.course_id
WHERE e.grade IS NULL;

## no 11
-- cari dept untuk course 1006 dulu (diketahui di DML dept 10)
SELECT dept_id FROM courses WHERE course_id = 1006;

-- lalu:
SELECT s.student_id, s.student_name
FROM students s
WHERE s.dept_id = (SELECT dept_id FROM courses WHERE course_id = 1006)
  AND s.student_id NOT IN (
    SELECT e.student_id
    FROM enrollments e
    JOIN classes c ON e.class_id = c.class_id
    WHERE c.course_id = 1006
  );

## no 12
SELECT sch.day_of_week,
       COUNT(sch.schedule_id) AS jumlah_kelas,
       SUM(r.capacity) AS total_kapasitas_dipakai
FROM schedules sch
JOIN rooms r ON sch.room_id = r.room_id
GROUP BY sch.day_of_week;

## no 13
SELECT s.student_id, s.student_name, COALESCE(SUM(cr.credits),0) AS total_sks
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
LEFT JOIN classes c ON e.class_id = c.class_id
LEFT JOIN courses cr ON c.course_id = cr.course_id
GROUP BY s.student_id, s.student_name;

## no 14
SELECT c.class_id, cr.course_code, cr.course_title, cr.dept_id AS course_dept, l.lect_id, l.lect_name, l.dept_id AS lect_dept
FROM classes c
JOIN courses cr ON c.course_id = cr.course_id
JOIN lecturers l ON c.lect_id = l.lect_id
WHERE cr.dept_id <> l.dept_id;

## no 15
SELECT c.class_id,
       cr.course_code,
       COUNT(e.student_id) AS peserta,
       r.capacity,
       CASE WHEN COUNT(e.student_id) >= r.capacity THEN 'PENUH' ELSE 'TERSISA' END AS status
FROM classes c
LEFT JOIN enrollments e ON c.class_id = e.class_id
LEFT JOIN schedules sch ON c.class_id = sch.class_id
LEFT JOIN rooms r ON sch.room_id = r.room_id
LEFT JOIN courses cr ON c.course_id = cr.course_id
GROUP BY c.class_id, cr.course_code, r.capacity;

## no 16
SELECT s.student_name, cr.course_code, cr.course_title
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN classes c ON e.class_id = c.class_id
JOIN courses cr ON c.course_id = cr.course_id
WHERE c.semester = '2025-1'
ORDER BY s.student_name, cr.course_code;

## no 17
SELECT DISTINCT p.course_id AS prereq_course_id, c.course_code AS prereq_course_code, c.course_title
FROM prerequisites pr
JOIN courses c ON pr.prereq_id = c.course_id;

## no 18
SELECT sup.lect_name AS pembina, COUNT(ls.lect_id) AS jumlah_dosen_dibina
FROM lecturer_supervisions ls
JOIN lecturers sup ON ls.supervisor_id = sup.lect_id
GROUP BY sup.lect_name;

## no 19
SELECT s.student_id, s.student_name, c.class_id, cr.course_code, r.room_name, sch.day_of_week
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN classes c ON e.class_id = c.class_id
JOIN schedules sch ON c.class_id = sch.class_id
JOIN rooms r ON sch.room_id = r.room_id
JOIN courses cr ON c.course_id = cr.course_id
WHERE sch.day_of_week = 'Monday';

## no 20
SELECT s.student_id, s.student_name, s.dept_id AS student_dept, cr.course_code, cr.course_title, cr.dept_id AS course_dept
FROM enrollments e
JOIN students s ON e.student_id = s.student_id
JOIN classes c ON e.class_id = c.class_id
JOIN courses cr ON c.course_id = cr.course_id
WHERE s.dept_id <> cr.dept_id;

## no 21
SELECT l.lect_id, l.lect_name, c.class_id, cr.course_code
FROM lecturers l
LEFT JOIN classes c ON l.lect_id = c.lect_id
LEFT JOIN courses cr ON c.course_id = cr.course_id
ORDER BY l.lect_name;

## no 22
SELECT cr.course_id, cr.course_code, cr.course_title, c.class_id, c.semester
FROM courses cr
LEFT JOIN classes c ON cr.course_id = c.course_id AND c.semester = '2025-1'
ORDER BY cr.course_code;

## no 23
SELECT cr.course_code, cr.course_title, p.course_code AS prereq_code, p.course_title AS prereq_title
FROM courses cr
LEFT JOIN prerequisites pr ON cr.course_id = pr.course_id
LEFT JOIN courses p ON pr.prereq_id = p.course_id
ORDER BY cr.course_code;

## no 24
SELECT DISTINCT s.student_id, s.student_name, sup.lect_name AS pembina, cr.course_code
FROM lecturer_supervisions ls
JOIN lecturers sup ON ls.supervisor_id = sup.lect_id           -- pembina
JOIN classes c ON sup.lect_id = c.lect_id                      -- kelas yang diajar pembina
JOIN enrollments e ON c.class_id = e.class_id
JOIN students s ON e.student_id = s.student_id
JOIN courses cr ON c.course_id = cr.course_id;

## no 25
SELECT s1.schedule_id AS sch1, s2.schedule_id AS sch2,
       s1.class_id AS class1, s2.class_id AS class2,
       s1.day_of_week, r.room_name,
       s1.start_time AS start1, s1.end_time AS end1, s2.start_time AS start2, s2.end_time AS end2
FROM schedules s1
JOIN schedules s2 ON s1.room_id = s2.room_id
  AND s1.day_of_week = s2.day_of_week
  AND s1.schedule_id < s2.schedule_id  -- untuk menghindari duplikasi pasangan
JOIN rooms r ON s1.room_id = r.room_id
WHERE s1.start_time < s2.end_time
  AND s2.start_time < s1.end_time;

