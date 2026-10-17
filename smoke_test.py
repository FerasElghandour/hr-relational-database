import sqlite3
from pathlib import Path
db=sqlite3.connect(':memory:');db.execute('PRAGMA foreign_keys=ON')
db.executescript(Path('sql/schema.sql').read_text())
db.execute("INSERT INTO employee(employee_id,display_name,email,hired_on) VALUES (1,'Example employee','example@example.invalid','2024-01-01')")
db.execute("INSERT INTO salary VALUES (1,1,50000,'2024-01-01',NULL)")
assert 'annual_amount' not in [c[1] for c in db.execute('PRAGMA table_info(employee_directory)')]
for query in ["INSERT INTO salary VALUES (2,1,-1,'2024-01-01',NULL)","INSERT INTO salary VALUES (3,99,1,'2024-01-01',NULL)","INSERT INTO salary VALUES (4,1,1,'2024-01-02','2024-01-01')"]:
    try:db.execute(query)
    except sqlite3.IntegrityError:pass
    else:raise AssertionError('Invalid salary record accepted')
db.close();print('Relational integrity, nonnegative salary, valid dates, and salary-free directory checks passed on SQLite. PostgreSQL role setup is separate.')
