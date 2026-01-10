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
    @ollama pull codegemma:7b 
    @ollama pull qwen3-coder:30b 
    @ollama pull gpt-oss:latest 
    @ollama pull deepseek-coder:6.7b 
    @ollama pull codellama:13b 
    @ollama pull starcoder2:7b