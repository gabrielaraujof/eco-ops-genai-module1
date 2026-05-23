# Eco-Ops: Infraestrutura Inteligente com GenAI

Este repositório contém os artefatos práticos para o Módulo 1 do curso **GenAI for DevOps Engineers**.

## 🚀 Objetivo do Módulo
Aprender a integrar assistentes de IA (coding agents) no fluxo de trabalho de engenharia de infraestrutura, focando em geração de código (IaC), auditoria de segurança e modularização.

## 🛠 Pré-requisitos
Para realizar os exercícios, você precisará de:
1. **Terraform CLI** (v1.5+)
2. **Um coding agent de sua preferência** (Claude Code, Gemini CLI, Copilot CLI, Cursor, etc.)
3. **AWS CLI** (Configurado, apenas para `terraform plan` local)

## 📂 Estrutura das Atividades
- **[hands-on-1-intro](./hands-on-1-intro):** Lab 1 — Setup & S3. Cria o esqueleto do projeto Eco-Ops (provider, variáveis, bucket S3 com segurança).
- **[hands-on-2-legacy](./hands-on-2-legacy):** Lab 2 — IAM & Auditoria. Adiciona políticas IAM e usa a IA como auditora de segurança.
- **[hands-on-3-foundation](./hands-on-3-foundation):** Lab 3 — VPC & Modularização. Constrói a fundação de rede do projeto Eco-Ops com chain-of-prompts.

Cada lab é evolutivo: o resultado de um é o ponto de partida do próximo. Ao final do Módulo 1, o diretório `eco-ops/` conterá a infraestrutura completa que será usada no Módulo 2 (CI/CD com n8n).
