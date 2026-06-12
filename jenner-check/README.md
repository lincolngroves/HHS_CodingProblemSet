# Jenner compatibility bundles

This directory was added by a pull request from the
[Jenner](https://jenneranalytics.com) project. Each `tNNN_*` subdirectory is a
small, self-contained SAS bundle adapted from a program in this repository. Each
one runs on the Jenner API — a SAS-compatible engine that runs SAS code — so you
can see your own analysis run unmodified.

## What's in here

```
jenner-check/
├── README.md            # this file
├── run_jenner.sh        # mac/linux runner (curl)
├── run_jenner.bat       # windows runner
├── run_jenner.sas       # run from base SAS (PROC HTTP)
└── tNNN_<slug>/
    ├── script.sas       # the SAS under test (data is inline)
    ├── autoexec.sas     # options applied before the script
    ├── expected.json    # the stable fields a passing run pins
    ├── expected/        # a captured snapshot: log.txt, output.txt, files.md
    └── meta.json        # which program it was adapted from, and how
```

The CPS microdata the original programs read from the `ipums` library are
represented inside each `script.sas` as a small inline sample, collapsed to
weighted demographic cells, so every bundle is fully self-contained.

## How to run it

From inside `jenner-check/`:

```bash
./run_jenner.sh --all          # run every bundle
./run_jenner.sh t001_covid_labor_supply_sql   # run just one
```

On Windows use `run_jenner.bat t001_covid_labor_supply_sql`. From base SAS
(9.4 M5+), `%include 'run_jenner.sas';` then `%jenner_check_all();`.

Each bundle's `script.sas` (prefixed with its `autoexec.sas`) is posted to
`https://api.jenneranalytics.com/v1/run`; the runner prints the status, the
SAS log, and the listing. You can also paste any `script.sas` into the hosted
workspace at [jenneranalytics.com](https://jenneranalytics.com).

## The bundles

| bundle | adapted from | exercises |
|--------|--------------|-----------|
| `t001_covid_labor_supply_sql` | Task 2a | weighted US-wide UE/LFP rates in PROC SQL |
| `t002_labor_supply_macro`     | Task 2b | a reporting macro invoked across subgroups |
| `t003_transpose_reshape`      | Task 3  | PROC TRANSPOSE + a DATA-step reshape |
| `t004_sgpanel_state`          | Task 3  | a PROC SGPANEL state lattice |
| `t005_format_recode`          | Task 4  | PROC FORMAT bands + PROC FREQ tally |

## Don't want future PRs from us?

Reply with `no-more-prs` (case-insensitive) anywhere in a comment, or open an
issue titled `jenner-check: opt out`, and we'll stop.

## About this project

Jenner runs SAS code, with support for more than 200 SAS procedures. Full
context is at [jenneranalytics.com](https://jenneranalytics.com).
