# Reproduction and benchmark scope

The portable SQLite checks are retained. A rollback-only PostgreSQL integration script now checks the reporting role, salary exclusion and actual directory query in a disposable database.

## Execute a recorded profile

```sh
python run_reproduction.py --profile checks --output reproduced/checks
```

Use a new output directory for each run. The driver writes command logs, source/input SHA-256 values, versions and an explicit outcome. It does not silently download data or turn generated fixtures into dataset-performance claims.

| Profile | Actual scope | Required inputs |
|---|---|---|
| `checks` | Offline behavioral regressions; not a fresh dataset benchmark | None |

Supply named paths with `--input name=/absolute/path`. Exact commands are versioned in [reproduction.json](reproduction.json); direct training commands and preparation contracts are below.

## Evidence boundary

No PostgreSQL test server was available in this pass. The PostgreSQL privilege script is prepared but not certified by SQLite checks.

Keep input acquisition and source credits in [DATA.md](DATA.md). Historical results, new reference runs and small contract fixtures have separate evidential scope.

## Direct commands and inputs

On an empty disposable PostgreSQL database with role-management rights:

```sh
psql "$HR_TEST_DSN" -X -v ON_ERROR_STOP=1 -f sql/integration_postgresql.sql
```

All schema, role and privilege changes are transactionally rolled back. This integration was not executed on the current host.

## Recorded command definitions

### checks

```text
{python} smoke_test.py
```

`{python}` is the current interpreter. `{output}` is the new run directory. `{input:name}` refers to a named absolute input path supplied to the driver. Install declared dependencies in a clean environment before executing. Never execute untrusted serialized models or notebooks.
