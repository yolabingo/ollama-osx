# ollama-osx

<details>
<summary>Table of Contents</summary>

- [Overview](#ollama-osx)
- [Setup with just](#setup-with-just)
- [Connecting terminal AI coding assistants](#connecting-terminal-ai-coding-assistants)
  - [Aider](#aider)
  - [Claude Code (via LiteLLM proxy)](#claude-code-via-litellm-proxy)
  - [Codex CLI](#codex-cli)
- [Sample output - create and run models](#sample-output---create-and-run-models)

</details>

A setup script for macOS to install and configure Ollama with AI models for development tasks.

This repository provides a `justfile` that automates the installation and setup of:
- uv package manager
- [Ollama server](https://docs.ollama.com/)
- [Aider AI coding assistant](https://aider.chat/)
- Pre-trained language models for Django and Infrastructure as Code (IaC) tasks

The setup process includes:
1. Installing required tools via Homebrew or uv
2. Starting the Ollama server
3. Pulling specified AI models
4. Generating Modelfile configurations
5. Providing usage instructions for running aider with each model


### Setup with just
```bash
brew install just
git clone https://github.com/yolabingo/ollama-osx.git
cd ollama-osx
just
```


## Connecting terminal AI coding assistants

### Aider

Aider has native Ollama support via the `ollama_chat/` model prefix.

Set env var and run Aider with a model:
```bash
export OLLAMA_API_BASE=http://127.0.0.1:11434
aider --model ollama_chat/iac-qwen3-coder:30b [FILES...]
```

See https://aider.chat/docs/llms/ollama.html for full documentation.


### Claude Code (via LiteLLM proxy)

Claude Code speaks the Anthropic API protocol. LiteLLM bridges it to Ollama.

Install LiteLLM:
```bash
uv tool install 'litellm[proxy]'
```

Start the proxy (in a separate terminal):
```bash
litellm --model ollama/iac-qwen3-coder:30b --port 4000
```

Set env vars and run Claude Code:
```bash
export ANTHROPIC_BASE_URL=http://localhost:4000
export ANTHROPIC_API_KEY=fake-key
claude
```


### Codex CLI

Codex CLI supports OpenAI-compatible endpoints — Ollama provides one out of the box.

Set env vars and run Codex with a model:
```bash
export OPENAI_BASE_URL=http://localhost:11434/v1
export OPENAI_API_KEY=ollama
codex --model iac-qwen3-coder:30b
```


### Sample output - create and run models

Tune SYSTEM prompts and settings in [Modelfile-tmpl.sh](Modelfile-tmpl.sh) as needed. 
```
# ➡ create model:
  ollama create -f /Users/toddj/github/ollama-osx/modelfiles/Modelfile-qwen3-coder:30b-iac iac-qwen3-coder:30b
# ➡ create model:
  ollama create -f /Users/toddj/github/ollama-osx/modelfiles/Modelfile-deepseek-coder:6.7b-iac iac-deepseek-coder:6.7b
# ➡ create model:
  ollama create -f /Users/toddj/github/ollama-osx/modelfiles/Modelfile-codellama:13b-django django-codellama:13b

# ➡ run model with ollama or aider:
   ollama run iac-qwen3-coder:30b
   aider --model ollama_chat/iac-qwen3-coder:30b [FILES...]
# ➡ run model with ollama or aider:
   ollama run iac-deepseek-coder:6.7b
   aider --model ollama_chat/iac-deepseek-coder:6.7b [FILES...]
# ➡ run model with ollama or aider:
   ollama run django-codellama:13b
   aider --model ollama_chat/django-codellama:13b [FILES...]
```
