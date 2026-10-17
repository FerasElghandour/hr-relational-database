-- Run with a role allowed to manage privileges in a dedicated development database.
CREATE ROLE portfolio_hr_reader NOLOGIN;
GRANT USAGE ON SCHEMA public TO portfolio_hr_reader;
GRANT SELECT ON education_level,job_title,department,location,employee,job_history,employee_directory TO portfolio_hr_reader;
REVOKE ALL ON salary FROM portfolio_hr_reader;
SELECT has_table_privilege('portfolio_hr_reader','salary','SELECT') AS salary_readable;
