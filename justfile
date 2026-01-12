# Define models to pull
DJANGO_MODELS := "codellama:13b"
IAC_MODELS := "qwen3-coder:30b deepseek-coder:6.7b"

default: install ollama-models

install: install-uv \
         install-ollama \
         install-aider \
         ollama-run-server
         

ollama-models: ollama-pull-models \
               model-configs

install-uv:
    @echo "Checking for uv..."
    @if ! command -v uv >/dev/null 2>&1; then echo "Installing uv..."; brew install uv; fi

install-ollama:
    @echo "Checking for ollama..."
    @if ! command -v ollama >/dev/null 2>&1; then echo "Installing ollama..."; brew install ollama; fi

install-aider:
    @echo "Checking for aider..."
    @if ! command -v aider >/dev/null 2>&1; then echo "Installing aider..."; uv tool install aider; fi

ollama-run-server:
    @brew services start ollama
    @while ! ollama list >/dev/null 2>&1; do echo "Waiting for ollama server..."; sleep 2; done
    @echo "Ollama server is ready!"

ollama-pull-models:
    @for model in {{DJANGO_MODELS}}; do echo "Pulling $model..."; ollama pull $model; done
    @for model in {{IAC_MODELS}}; do echo "Pulling $model..."; ollama pull $model; done

model-configs:
    @mkdir -p modelfiles
    @for model in {{IAC_MODELS}}; do \
        mf="$(pwd)/modelfiles/Modelfile-$model-iac"; \
        ./Modelfile-tmpl.sh $model iac > $mf; \
        echo "# ➡ create model:"; \
        echo "  ollama create -f $mf iac-$model"; \
    done
    @for model in {{DJANGO_MODELS}}; do \
        mf="$(pwd)/modelfiles/Modelfile-$model-django"; \
        ./Modelfile-tmpl.sh $model django > $mf; \
        echo "# ➡ create model:"; \
        echo "  ollama create -f $mf django-$model"; \
    done
    @echo
    @for model in {{IAC_MODELS}}; do \
        echo "# ➡ run aider with model:"; \
        echo "   ollama run iac-$model"; \
        echo "   aider --model ollama_chat/iac-$model [FILES...]"; \
        echo "   ollama stop iac-$model"; \
    done
    @for model in {{DJANGO_MODELS}}; do \
        echo "# ➡ run aider with model:"; \
        echo "   ollama run django-$model"; \
        echo "   aider --model ollama_chat/django-$model [FILES...]"; \
        echo "   ollama stop django-$model"; \
    done

