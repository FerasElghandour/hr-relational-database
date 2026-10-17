"""Offline example using the public implementation; see README for evidence scope."""
import sys
import os
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
sys.path.insert(0, str(ROOT))
sys.path.insert(0, str(ROOT / "src"))
os.chdir(ROOT)

import sqlite3
from pathlib import Path
# Fictional in-memory employee; no operational HR database.
db = sqlite3.connect(':memory:')
db.execute('PRAGMA foreign_keys=ON')
db.executescript(Path('sql/schema.sql').read_text())
db.execute("INSERT INTO employee(employee_id,display_name,email,hired_on) VALUES (1,'Example employee','example@example.invalid','2024-01-01')")
db.execute("INSERT INTO salary VALUES (1,1,50000,'2024-01-01',NULL)")
result = {'directory_columns': [c[1] for c in db.execute('PRAGMA table_info(employee_directory)')], 'directory_rows': db.execute('SELECT * FROM employee_directory').fetchall()}
db.close()

import json
print(json.dumps(result, indent=2))

