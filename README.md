# dbt\_gcp

A dbt project to build a multi-layered analytics pipeline for orders and customers data in BigQuery.
It implements Bronze/Silver/Gold schemas, incremental models, custom tests (using `dbt_utils`), and GitHub Actions CI.

---

## 📖 Table of Contents

* [Project Structure](#project-structure)
* [Getting Started](#getting-started)

  * [Install dependencies](#install-dependencies)
  * [Configure your profile](#configure-your-profile)
  * [Run models](#run-models)
  * [Run tests](#run-tests)
* [Layers & Models](#layers--models)
* [Packages & Macros](#packages--macros)
* [CI / GitHub Actions](#ci--github-actions)
* [Ref](#ref)

---

## Project Structure

```
.
├── analyses/             # Ad-hoc queries and analysis SQL
├── macros/               # Custom macros (if any)
├── models/
│   ├── bronze/           # Raw staging models
│   ├── silver/           # Enriched, conformed models
│   └── gold/             # Business-ready marts
├── seeds/                # CSV files to load as seed tables
├── snapshots/            # Historical snapshots
├── tests/                # Data tests (dbt test --data)
├── .github/workflows/    # CI pipelines
├── dbt_project.yml       # dbt project config
├── packages.yml          # dbt package dependencies
├── package-lock.yml      # lockfile for packages
├── requirements.txt      # Python dependencies (if used)
└── README.md             # ← you are here
```

---

## Getting Started

### Install dependencies

```bash
# Install requirements.txt
pip install -r requirements.txt

# Install dbt packages
dbt deps
```

### Configure your profile

Edit `~/.dbt/profiles.yml` to include:

```yaml
dbt_felix:
  target: dev
  outputs:
    dev:
      type: bigquery
      method: service-account
      project_id: <your-gcp-project-id>
      dataset: <your_dataset_name>
      keyfile: </path/to/your/service-account.json>
      threads: 4
      timeout_seconds: 300
```

### Run models

```bash
dbt run
```

Or materialize specific layers:

```bash
dbt run --models bronze.*
dbt run --models silver.*
dbt run --models gold.*
```

### Run tests

Schema-based & data tests:

```bash
dbt test
```

Data-only tests:

```bash
dbt test --data
```

---

## Layers & Models

| Layer      | Description                                   | Example models                                |
| ---------- | --------------------------------------------- | --------------------------------------------- |
| **Bronze** | Raw staging: ingest source tables as they are | `b_customers`,                                |
| **Silver** | Conformed, cleaned & enriched staging         | `s_orders`, `s_order_details`,                |
| **Gold**   | Business-ready marts & aggregates             | `g_customers`, (future-customer LTV, RFM)     |

Incremental models use `merge` to upsert only new/changed rows.

---

## Packages & Macros

* **dbt\_utils** — for common macros & schema tests

  * e.g. `expression_is_true` with `severity: warn`

Custom macros live under `macros/`.

---

## CI / GitHub Actions

Workflow in `.github/workflows/` runs on push:

1. `dbt deps`
2. `dbt run --models bronze.* silver.*`
3. `dbt test`

Adjust or extend as needed.



## Ref
- Learn more about dbt [in the docs](https://docs.getdbt.com/docs/introduction)
- Check out [Discourse](https://discourse.getdbt.com/) for commonly asked questions and answers
- Join the [chat](https://community.getdbt.com/) on Slack for live discussions and support
- Find [dbt events](https://events.getdbt.com) near you
- Check out [the blog](https://blog.getdbt.com/) for the latest news on dbt's development and best practices
