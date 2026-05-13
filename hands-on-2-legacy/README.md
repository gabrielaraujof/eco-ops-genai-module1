# Lab 2: IAM & Auditoria — Segurança com IA

## Missão
Adicionar políticas IAM ao projeto Eco-Ops e usar a IA como auditora para detectar alucinações e falhas de segurança.

## Conexão com a Aula
Este lab usa os conceitos dos Slides 11-14: alucinação em código, armadilhas de segurança, IA como criadora vs auditora.

## Pré-requisitos
- Ter concluído o Lab 1 (diretório `eco-ops/` com provider.tf e variables.tf)
- Terraform CLI (v1.5+)
- Coding agent

## Arquitetura
Adicionar ao projeto existente:

```
eco-ops/
├── provider.tf       # (do Lab 1)
├── variables.tf      # (do Lab 1)
├── s3_eco_ops.tf     # (do Lab 1)
└── iam.tf            # IAM role + policy (NOVO)
```

## Tarefa (50 min, em pares)

### Passo 1: Gere o iam.tf (Modo Criador)
Crie um arquivo `iam.tf` com uma política IAM para desenvolvedores:

> "Atue como um Engenheiro DevOps Sênior.
> Tarefa: Crie uma IAM policy para um desenvolvedor que precisa de acesso apenas a S3 e EC2.
> Contexto: Ambiente de produção. Aplicar princípio de Least Privilege.
> Restrições:
> - Não use Action: '*' em nenhum statement
> - Limite os recursos (Resource) ao mínimo necessário
> - Retorne APENAS o código HCL puro."

```bash
coding-agent "prompt acima" > iam.tf
```

### Passo 2: Audite o código gerado (Modo Auditor)
**Antes de rodar o plan**, use a IA para auditar o que ela mesma produziu:

```bash
cat iam.tf | coding-agent "Atue como um Auditor SecOps Sênior.
Analise esta IAM policy e:
1. Liste falhas de segurança críticas
2. Identifique permissões excessivas (wildcards)
3. Aponte possíveis alucinações (parâmetros que não existem no provider AWS v5.x)
4. Sugira correções em HCL"
```

Anote: **a IA pode alucinar na auditoria também.** Ela pode apontar um falso positivo ou deixar passar um erro real. Discuta com seu par.

### Passo 3: Refine o prompt com base na auditoria
Caso a auditoria aponte problemas reais, refaça o prompt incorporando as correções.

### Passo 4: Valide
```bash
terraform init    # (se ainda não fez no Lab 1)
terraform plan
```

### Passo 5: (Se Learner Lab ativo) Apply incremental
```bash
terraform apply -auto-approve
```
Confirme no console IAM → Policies que a policy foi criada com as permissões corretas.

### Passo 6: Commit
```bash
git add eco-ops/iam.tf
git commit -m "feat: add IAM policy with least privilege"
```

### Arquivos Legados para Referência
Na pasta `hands-on-2-legacy/` você encontra exemplos de código com vulnerabilidades propositais:
- `iam_policy.tf` — Policy com wildcards (Action: "*")
- `security_group.tf` — SG com SSH aberto para 0.0.0.0/0

Use estes arquivos para praticar o Modo Auditor:
```bash
cat hands-on-2-legacy/security_group.tf | coding-agent "Audite este security group"
```

### Verificação
- [ ] `terraform plan` mostra criação de 1 recurso IAM
- [ ] A policy NÃO contém `Action: "*"`
- [ ] A auditoria identificou ao menos 1 ponto de atenção
- [ ] (Se LL) Policy visível no console IAM

### Alerta de Alucinação Comum
A IA frequentemente gera `Action = ["s3:*", "ec2:*"]` mesmo quando você pede Least Privilege. Isso é uma alucinação de permissividade — não aceite.
