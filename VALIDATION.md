# Validation

Run `python smoke_test.py` for the included offline behavior checks. These use synthetic inputs or an in-memory database. They do not recertify historical benchmark metrics or test a live external service.

The relational core runs on SQLite in the included test. PostgreSQL-specific role grants are provided separately and have not been exercised against a live PostgreSQL server.

## Executed checks — October 17, 2026

Relational integrity, nonnegative salary, valid dates, and salary-free directory checks passed on SQLite. PostgreSQL role setup is separate.

Executed locally on Python 3.14.3. The hosted workflow repeats these checks on Python 3.12.
