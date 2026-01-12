# ollama-osx

A setup script for macOS to install and configure Ollama with AI models for development tasks.

This repository provides a `justfile` that automates the installation and setup of:
- uv package manager
- Ollama server
- Aider AI coding assistant
- Pre-trained language models for Django and Infrastructure as Code (IaC) tasks

The setup process includes:
1. Installing required tools via Homebrew or uv
2. Starting the Ollama server
3. Pulling specified AI models
4. Generating Modelfile configurations
5. Providing usage instructions for running aider with each model

```bash
brew install just
git clone https://github.com/yolabingo/ollama-osx.git
cd ollama-osx
just
# add OLLAMA_API_BASE=http://127.0.0.1:11434 to your shell env vars for aider
```

https://aider.chat/docs/llms/ollama.html