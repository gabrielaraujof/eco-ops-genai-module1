# Lab 1: Setup & S3 — Primeiros Passos

## Missão
Criar o esqueleto do projeto Eco-Ops e o primeiro recurso na AWS, usando IA de ponta a ponta.

## Conexão com a Aula
Este lab usa os conceitos dos Slides 4-9: como LLMs funcionam, anatomia do prompt, e fluxo de geração no terminal.

## Pré-requisitos
- Terraform CLI (v1.5+)
- Um coding agent de sua preferência (Gemini CLI, Claude Code, Copilot CLI, etc.)
- AWS CLI configurado (para `terraform plan`)
- (Opcional) Learner Lab AWS Academy ativo — para `terraform apply`

## Arquitetura Alvo
Criar a estrutura base do projeto Eco-Ops com estes arquivos:

```
eco-ops/
├── provider.tf       # Provider AWS v5.x
├── variables.tf      # Variáveis do projeto
└── s3_eco_ops.tf     # Bucket S3 com segurança
```

## Tarefa (30 min, solo)

### Passo 1: Crie o diretório do projeto
```bash
mkdir -p eco-ops && cd eco-ops
```

### Passo 2: Gere o provider.tf
Use o prompt abaixo com seu coding agent:

> "Atue como um Engenheiro DevOps Sênior.
> Tarefa: Gere um arquivo provider.tf para o Terraform com o provider AWS versão 5.x, região us-east-1.
> Restrições: Retorne APENAS o código HCL puro, sem blocos de markdown ou explicações."

Redirecione a saída para o arquivo:
- **CLI:** `gemini "prompt acima" > provider.tf`
- **Claude Code:** `claude "prompt acima" > provider.tf`
- **IDE:** Cole o conteúdo gerado em `provider.tf`

### Passo 3: Gere o variables.tf
> "Atue como um Engenheiro DevOps Sênior.
> Tarefa: Gere um arquivo variables.tf com as variáveis: region (default us-east-1), environment (default production), project_name (default eco-ops).
> Restrições: Retorne APENAS o código HCL puro."

### Passo 4: Gere o s3_eco_ops.tf
> "Atue como um Engenheiro DevOps Sênior.
> Tarefa: Gere um recurso Terraform para um bucket S3 chamado eco-ops-state-$\{var.environment\}.
> Contexto: Ambiente de produção.
> Restrições:
> - Block Public Access deve estar ativado (block_public_acls, block_public_policy, ignore_public_acls, restrict_public_buckets = true)
> - Habilite versionamento (versioning = true)
> - Retorne APENAS o código HCL puro."

### Passo 5: Valide
```bash
terraform init
terraform plan
```

### Passo 6: (Se Learner Lab ativo) Apply + Console
```bash
terraform apply -auto-approve
```
Acesse o console AWS → S3 → confirme que o bucket foi criado com versionamento ativo e Block Public Access configurado.

### Passo 7: Commit
```bash
git add eco-ops/
git commit -m "feat: add project skeleton and S3 bucket"
```

### Verificação
- [ ] `terraform init` executa sem erros
- [ ] `terraform plan` mostra criação dos 3 recursos (provider, variáveis, bucket)
- [ ] (Se LL) Bucket visível no console AWS com versionamento = ativado

### Dicas
- Se o `plan` falhar por parâmetro descontinuado, use o erro como prompt: "Corrija este erro para o provider AWS v5.x"
- A instrução "Retorne APENAS o código" é crucial para evitar textos extras no arquivo .tf
