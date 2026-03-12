default: render

# Prepend .venv/bin so quarto's external-env python resolves to the project venv
export PATH := ".venv/bin:" + env_var("PATH")

render:
    uv sync --locked
    quarto render

preview:
    uv sync --locked
    quarto preview