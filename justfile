# Install development dependencies
install:
    @echo "Checking for uv..."
    @if ! command -v uv >/dev/null 2>&1; then echo "Installing uv..."; brew install uv; else echo "uv is already installed"; fi
    @echo "Checking for ollama..."
    @if ! command -v ollama >/dev/null 2>&1; then echo "Installing ollama..."; brew install ollama; else echo "ollama is already installed"; fi

# Install uv only
install-uv:
    @echo "Checking for uv..."
    @if ! command -v uv >/dev/null 2>&1; then echo "Installing uv..."; brew install uv; else echo "uv is already installed"; fi

# Install ollama only
install-ollama:
    @echo "Checking for ollama..."
    @if ! command -v ollama >/dev/null 2>&1; then echo "Installing ollama..."; brew install ollama; else echo "ollama is already installed"; fi
