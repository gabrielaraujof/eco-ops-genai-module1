# Lab 3: VPC & Modularização — A Fundação da Rede

## Missão
Completar a fundação de infraestrutura do Eco-Ops criando uma VPC com alta disponibilidade, usando um chain-of-prompts para decompor a tarefa.

## Conexão com a Aula
Este lab usa os conceitos do Slide 16-17: o projeto Eco-Ops como fio condutor, geração de código modular.

## Pré-requisitos
- Ter concluído os Labs 1 e 2 (diretório `eco-ops/` completo até iam.tf)
- Terraform CLI (v1.5+)
- Coding agent

## Arquitetura Alvo
Adicionar ao projeto existente:

```
eco-ops/
├── provider.tf       # (Lab 1)
├── variables.tf      # (Lab 1)
├── s3_eco_ops.tf     # (Lab 1)
├── iam.tf            # (Lab 2)
├── vpc.tf            # VPC + CIDR (NOVO)
├── subnets.tf        # 2 públicas, 2 privadas (NOVO)
├── gateways.tf       # Internet Gateway + NAT Gateway (NOVO)
└── outputs.tf        # Outputs (NOVO)
```

**Arquitetura:** 1 VPC (10.0.0.0/16), 2 subnets públicas (10.0.1.0/24, 10.0.2.0/24), 2 privadas (10.0.3.0/24, 10.0.4.0/24), Internet Gateway, NAT Gateway (elástico).

## Tarefa (42 min, grupos)

Este lab usa **Chain of Prompts** — 3 prompts encadeados onde cada um depende da saída do anterior.

### Prompt 1 — Arquitetura
> "Atue como Arquiteto de Nuvem Sênior.
> Tarefa: Projete uma VPC para ambiente de produção com alta disponibilidade.
> A arquitetura deve incluir: 1 VPC, 2 subnets públicas, 2 subnets privadas, Internet Gateway, NAT Gateway.
> Região: us-east-1.
> Retorne APENAS a descrição da arquitetura em texto, sem código."

### Prompt 2 — Geração de Código
Baseado na arquitetura retornada, use este segundo prompt:

> "Com base na arquitetura descrita acima, gere o código Terraform completo.
> Regras:
> - Crie arquivos separados: vpc.tf, subnets.tf, gateways.tf, outputs.tf
> - Use provider AWS v5.x
> - Use a VPC CIDR 10.0.0.0/16
> - Subnets públicas: 10.0.1.0/24, 10.0.2.0/24
> - Subnets privadas: 10.0.3.0/24, 10.0.4.0/24
> - Retorne APENAS o código HCL, com comentários indicando o nome de cada arquivo (ex: '# vpc.tf')"

Como a IA pode misturar tudo em uma resposta, crie cada arquivo manualmente separando o código:

```bash
# Crie cada arquivo com base no output da IA
echo "# Conteúdo do vpc.tf aqui" > eco-ops/vpc.tf
echo "# Conteúdo do subnets.tf aqui" > eco-ops/subnets.tf
echo "# Conteúdo do gateways.tf aqui" > eco-ops/gateways.tf
echo "# Conteúdo do outputs.tf aqui" > eco-ops/outputs.tf
```

### Prompt 3 — Validação Cruzada
> "Valide este conjunto de arquivos Terraform para uma VPC.
> Verifique:
> 1. Se as subnets públicas referenciam corretamente o Internet Gateway
> 2. Se as subnets privadas referenciam corretamente o NAT Gateway
> 3. Se os outputs exportam: vpc_id, public_subnet_ids, private_subnet_ids
> 4. Se há parâmetros que não existem no provider AWS v5.x (alucinações)"

### Validação Final
```bash
terraform init
terraform plan
```

### (Se Learner Lab ativo) Apply + Destroy
```bash
terraform apply -auto-approve
# Confirme no console VPC que todos os recursos foram criados
terraform destroy -auto-approve   # Limpeza!
```

### Commit Final
```bash
git add eco-ops/
git commit -m "feat: add VPC foundation with high availability"
```

### Verificação
- [ ] `terraform plan` executa sem erros
- [ ] 4 arquivos separados (vpc.tf, subnets.tf, gateways.tf, outputs.tf)
- [ ] Subnets públicas têm `map_public_ip_on_launch = true`
- [ ] NAT Gateway tem `allocation_id` referenciando Elastic IP
- [ ] (Se LL) Recursos criados no console e destruídos ao final

### Dica: Desafio do Prompt Mínimo
Tente encurtar o Prompt 2 ao máximo, mantendo todas as regras. Qual o menor prompt que produz código válido? Testem entre os grupos e comparem.

### Nota sobre o Módulo 2
O código desta VPC será o ponto de partida para o Módulo 2 (CI/CD com n8n). Certifiquem-se de que o `terraform plan` passa antes do commit.
