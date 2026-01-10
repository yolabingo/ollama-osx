# Define models to pull
MODELS := "codegemma:7b qwen3-coder:30b gpt-oss:latest deepseek-coder:6.7b codellama:13b starcoder2:7b"

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
    @for model in {{MODELS}}; do echo "Pulling $model..."; ollama pull $model; done
