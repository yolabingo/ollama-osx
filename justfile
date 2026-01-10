# Define models to pull
CODE_MODELS := "codellama:13b"
IAC_MODELS := "qwen3-coder:30b deepseek-coder:6.7b"

install: install-uv install-ollama ollama-run-server ollama-pull-models

install-uv:
    @echo "Checking for uv..."
    @if ! command -v uv >/dev/null 2>&1; then echo "Installing uv..."; brew install uv; fi

install-ollama:
    @echo "Checking for ollama..."
    @if ! command -v ollama >/dev/null 2>&1; then echo "Installing ollama..."; brew install ollama; fi

ollama-run-server:
    @brew services start ollama

ollama-pull-models:
    @for model in {{CODE_MODELS}}; do echo "Pulling $model..."; ollama pull $model; done
    @for model in {{IAC_MODELS}}; do echo "Pulling $model..."; ollama pull $model; done
