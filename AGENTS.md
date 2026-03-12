# AGENTS.md — Anthology of Data Science

Guidance for AI agents (and humans) working on this codebase.

## What this project is

A Quarto website published at <https://anthology-of-data.science>. It is a curated, opinionated collection of open-access data science learning materials maintained by Daniel Kapitan. Content is organised into five sections: Books, Lectures, Perspectives (posts), Use Cases, and Notebooks.

Source repo: <https://github.com/anthology-of-data-science/anthology-of-data-science.github.io>  
Published from the `main` branch via GitHub Actions to the `gh-pages` branch.

---

## Repository layout

```
_quarto.yml                    # Site-wide Quarto configuration
_extensions/
  marimo-team/marimo/          # quarto-marimo engine extension (v0.4.4, requires Quarto >=1.9.20)
  data-intuitive/quarto-d2/   # D2 diagram extension
_freeze/                       # Quarto freeze cache (auto-generated, committed)
_site/                         # Build output (gitignored)
pyproject.toml                 # Python deps managed with uv
uv.lock                        # Locked dependency graph (always commit this)
justfile                       # Shortcuts: `just render`, `just preview`
.python-version                # Pinned Python version (3.12)
.github/workflows/publish.yml  # CI: render + publish to gh-pages
index.qmd                      # Site homepage / preface
books.qmd                      # Books listing page
lectures.qmd                   # Lectures listing page
books/                         # One .qmd per book entry
lectures/                      # Revealjs presentation files
posts/                         # "Perspectives on data science" articles
  index.qmd
  altair/
  analytical-problem-solving/
  daps/
  design-philosophy/
  hamilton-ibis/
  ibis-analytics/
  precision-recall/
  predictive-power-score/
  python/
  stop-aggregating-signal/
cases/                         # Use case write-ups
  index.qmd
  energiearmoede/
  enterobase/
  landscape-biomedical-research/
  microclimate-vision/
  rice-grain-classification/
  verkeersveiligheidmodel/
  wolves-in-germany/
notebooks/                     # Hands-on worked examples
  index.qmd
  ames-housing/                # Predicting house prices (lazypredict, marimo)
  deconfounding/
  overfitting/
  pima-indians/                # Predicting diabetes (lazypredict + SHAP, marimo)
resources/                     # PDFs referenced from notebooks/posts
```

---

## Technology stack

| Concern | Tool |
|---|---|
| Site generator | [Quarto](https://quarto.org) 1.9.32 |
| Notebook engine | [marimo](https://marimo.io) via `quarto-marimo` extension |
| Python package manager | [uv](https://docs.astral.sh/uv/) |
| Python version | 3.12 (see `.python-version`) |
| Visualisation | [Altair](https://altair-viz.github.io/) (Vega-Altair) |
| Data profiling | ydata-profiling |
| AutoML comparison | lazypredict |
| SHAP explanations | shap (pima-indians notebook only) |
| Feature importance | ppscore |
| Diagrams | D2 (via `quarto-d2` extension) |
| Analytics | GoatCounter + Google Analytics |

---

## Python environment

Dependencies are declared in `pyproject.toml` and pinned in `uv.lock`.

```bash
uv sync --locked          # install exact locked versions into .venv
uv lock                   # regenerate uv.lock after editing pyproject.toml
```

**Key overrides** (in `[tool.uv]`):
- `pandas>=2.0` — lazypredict/mlflow would otherwise pull pandas 1.5.3, which breaks ydata-profiling.
- `visions>=0.8.1` — older visions used `numba.generated_jit` (removed in numba 0.60).
- `no-build-isolation-package = ["ppscore"]` — ppscore needs `setuptools` at build time.

Always commit `uv.lock` after any dependency change.

---

## Quarto setup

**Quarto version:** 1.9.32 (required by the `quarto-marimo` engine extension, which needs ≥1.9.20).

**Extensions** are committed in `_extensions/` and also installed in CI via:
```yaml
- run: quarto add --no-prompt data-intuitive/quarto-d2
- run: quarto add --no-prompt marimo-team/quarto-marimo
```

**Freeze:** `execute: freeze: auto` in `_quarto.yml` means cells only re-execute when source changes. The `_freeze/` directory is committed to avoid re-running expensive cells in CI.

---

## Notebook format (marimo)

Notebooks under `notebooks/` use the marimo Quarto engine, **not** Jupyter. The `.qmd` files use `{python .marimo}` code fences.

**Required frontmatter for every notebook:**
```yaml
engine: marimo
external-env: true          # use the project's .venv, not uv's sandbox
```

> **Note on `engine:` value**: use `engine: marimo` (short name), **not** `engine: marimo-team/marimo`.
> Quarto's engine dispatch matches on `engine.name === "marimo"`; the full extension path form is only used when registering the extension in `_quarto.yml`.

**Cell syntax:**
````markdown
```python {.marimo}
#| echo: true
# your code here
```
````

Prose goes between code cells as normal markdown — no special delimiters needed.

**Do not** add `filters: marimo-team/quarto-marimo` to `_quarto.yml` or individual frontmatter; that is the deprecated approach and prints a warning.

---

## Local development

```bash
just preview          # quarto preview (live reload)
just render           # quarto render (full build to _site/)

# Or directly (must have .venv/bin on PATH for external-env notebooks):
PATH=".venv/bin:$PATH" quarto preview
PATH=".venv/bin:$PATH" quarto render notebooks/pima-indians/index.qmd
```

The `justfile` exports `.venv/bin` onto `PATH` automatically, so `just render` and `just preview` always use the project venv. If you call `quarto` directly, prepend `.venv/bin` manually or the marimo engine will fail to find `python` with the project packages.

Requires Quarto 1.9.32 to be installed locally. Install from:
<https://github.com/quarto-dev/quarto-cli/releases/tag/v1.9.32>

---

## CI/CD

`.github/workflows/publish.yml` runs on every push to `main`:

1. Checks out repo
2. Installs uv and runs `uv sync --locked`
3. Adds `.venv/bin` to `PATH` (so `quarto` can find `python`, `marimo`, etc.)
4. Installs Quarto 1.9.32
5. Installs the D2 CLI
6. Installs both Quarto extensions (`quarto-d2`, `quarto-marimo`)
7. Renders and publishes to `gh-pages` using `GITHUB_TOKEN`

---

## Content conventions

- All written content is in English.
- Altair is the only visualisation library used in notebooks (no matplotlib charts as primary output, though matplotlib may appear inside SHAP plots wrapped in `mo.mpl.interactive`).
- Notebook titles: plain descriptive names, e.g. "Predicting diabetes", "Predicting house prices" — no "with \<library\>" suffixes.
- Each notebook section under `notebooks/` is a directory containing `index.qmd` plus data files and any pre-generated HTML reports (e.g. ydata-profiling output).
- Pre-generated profiling reports (`.html`) are committed alongside the notebook so they are available without re-running the profiling step.

---

## Common tasks

**Add a new notebook:**
1. Create `notebooks/<name>/index.qmd` with marimo frontmatter (see above).
2. Add data files to the same directory.
3. Run `quarto render notebooks/<name>/index.qmd` locally to verify.
4. The notebook is auto-discovered by `notebooks/index.qmd` via `contents: notebooks/*/*`.

**Add a new post or use case:**
1. Create `posts/<name>/index.qmd` or `cases/<name>/index.qmd`.
2. Standard Quarto `.qmd` with knitr or jupyter engine as appropriate — no marimo required unless it is an interactive notebook.

**Update Python dependencies:**
1. Edit `pyproject.toml`.
2. Run `uv lock` — commit both `pyproject.toml` and `uv.lock`.
3. Verify imports still work: `uv run python -c "import <package>"`.
4. Re-render affected notebooks locally before pushing.
