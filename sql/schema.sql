-- Portable relational core; run in a new development database.
CREATE TABLE education_level (education_id INTEGER PRIMARY KEY, label VARCHAR(100) NOT NULL UNIQUE);
CREATE TABLE job_title (job_id INTEGER PRIMARY KEY, label VARCHAR(100) NOT NULL UNIQUE);
CREATE TABLE department (department_id INTEGER PRIMARY KEY, label VARCHAR(100) NOT NULL UNIQUE);
CREATE TABLE location (location_id INTEGER PRIMARY KEY, label VARCHAR(100) NOT NULL, city VARCHAR(100) NOT NULL);
CREATE TABLE employee (
 employee_id INTEGER PRIMARY KEY, display_name VARCHAR(100) NOT NULL,
 email VARCHAR(200) NOT NULL UNIQUE, hired_on DATE NOT NULL,
 education_id INTEGER REFERENCES education_level(education_id),
 manager_id INTEGER REFERENCES employee(employee_id),
 CHECK(manager_id IS NULL OR manager_id <> employee_id)
);
CREATE TABLE job_history (
 history_id INTEGER PRIMARY KEY, employee_id INTEGER NOT NULL REFERENCES employee(employee_id),
 job_id INTEGER NOT NULL REFERENCES job_title(job_id), department_id INTEGER NOT NULL REFERENCES department(department_id),
 location_id INTEGER NOT NULL REFERENCES location(location_id), starts_on DATE NOT NULL, ends_on DATE,
 CHECK(ends_on IS NULL OR ends_on >= starts_on)
);
CREATE TABLE salary (
 salary_id INTEGER PRIMARY KEY, employee_id INTEGER NOT NULL REFERENCES employee(employee_id),
 annual_amount DECIMAL(12,2) NOT NULL CHECK(annual_amount >= 0), starts_on DATE NOT NULL, ends_on DATE,
 CHECK(ends_on IS NULL OR ends_on >= starts_on)
);
CREATE VIEW employee_directory AS
 SELECT e.employee_id,e.display_name,e.email,e.hired_on,m.display_name AS manager_name
 FROM employee e LEFT JOIN employee m ON m.employee_id=e.manager_id;
