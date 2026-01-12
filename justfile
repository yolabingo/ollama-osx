# Define models to pull
DJANGO_MODELS := "codellama:13b"
IAC_MODELS := "qwen3-coder:30b deepseek-coder:6.7b"

default: install model-configs

install: install-uv \
         install-ollama \
         ollama-run-server \
         ollama-pull-models

install-uv:
    @echo "Checking for uv..."
    @if ! command -v uv >/dev/null 2>&1; then echo "Installing uv..."; brew install uv; fi

install-ollama:
    @echo "Checking for ollama..."
    @if ! command -v ollama >/dev/null 2>&1; then echo "Installing ollama..."; brew install ollama; fi

ollama-run-server:
    @brew services start ollama
    @echo "Waiting for ollama server to start..."
    @sleep 4
    @while ! ollama list >/dev/null 2>&1; do echo "Waiting for ollama server..."; sleep 2; done
    @echo "Ollama server is ready!"

ollama-pull-models:
    @for model in {{DJANGO_MODELS}}; do echo "Pulling $model..."; ollama pull $model; done
    @for model in {{IAC_MODELS}}; do echo "Pulling $model..."; ollama pull $model; done

model-configs:
    @mkdir -p modelfiles
    @for model in {{IAC_MODELS}}; do \
        mf="modelfiles/Modelfile-$model-iac" \
        ./Modelfile-tmpl.sh $model iac > $mf; \
        echo "ollama create $mf"; \
    done
    @for model in {{DJANGO_MODELS}}; do \
        mf=modelfiles/Modelfile-$model-django
        ./Modelfile-tmpl.sh $model iac > $mf; \
        echo "ollama create $mf"; \
    done