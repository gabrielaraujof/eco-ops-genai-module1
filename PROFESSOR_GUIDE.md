# Professor Guide — Module 1 Answer Keys

> Para o professor: este documento contém gabaritos, traps esperadas e critérios de avaliação.

## Visão Geral

Cada lab tem critérios comportamentais (o aluno demonstrou X habilidade com IA?) e não apenas critérios técnicos (o Terraform passou?).

---

## Lab 1 — Setup & S3

### Gabarito Técnico (saída esperada)

**provider.tf:**
```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}
```

**variables.tf:**
```hcl
variable "region" {
  description = "AWS region"
  type        = string
  default     = "us-east-1"
}

variable "environment" {
  description = "Environment name"
  type        = string
  default     = "production"
}

variable "project_name" {
  description = "Project name"
  type        = string
  default     = "eco-ops"
}
```

**s3_eco_ops.tf:**
```hcl
resource "aws_s3_bucket" "main" {
  bucket = "eco-ops-state-${var.environment}"
}

resource "aws_s3_bucket_versioning" "main" {
  bucket = aws_s3_bucket.main.id
  versioning_configuration {
    status = "Enabled"
  }
}

resource "aws_s3_bucket_public_access_block" "main" {
  bucket = aws_s3_bucket.main.id

  block_public_acls       = true
  block_public_policy      = true
  ignore_public_acls       = true
  restrict_public_buckets  = true
}
```

### Traps Comuns (o que pode dar errado)
| Problema | Sintoma | Como ajudar |
|----------|---------|-------------|
| IA retorna markdown ```hcl ``` | Arquivo .tf inválido | Mostrar como limpar ou pedir "retorne APENAS código puro" |
| Provider version errada | plan usa sintaxe antiga | Pedir: "Corrija para AWS provider v5.x" |
| Bucket name sem ${var.environment} | Bucket com nome fixo | Prompt não especificou o nome dinâmico |

### Critérios de Avaliação (comportamentais)
- [ ] Aluno adaptou o prompt template, não copiou cegamente
- [ ] Aluno usou redirect `>` ou colou manualmente o output
- [ ] Aluno leu o `terraform plan` antes de prosseguir
- [ ] Aluno iterou com erro do plan quando necessário

---

## Lab 2 — IAM & Auditoria

### Gabarito Técnico (saída esperada)

**iam.tf (mínimo):**
```hcl
resource "aws_iam_policy" "developer" {
  name        = "eco-ops-developer-policy"
  description = "Least privilege policy for developers"

  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "s3:ListBucket",
          "s3:GetObject",
          "s3:PutObject"
        ]
        Effect   = "Allow"
        Resource = [
          "arn:aws:s3:::eco-ops-state-production",
          "arn:aws:s3:::eco-ops-state-production/*"
        ]
      },
      {
        Action = [
          "ec2:DescribeInstances",
          "ec2:DescribeVpcs",
          "ec2:DescribeSubnets"
        ]
        Effect   = "Allow"
        Resource = "*"
      }
    ]
  })
}
```

### Traps e Alucinações Esperadas
| Trap | O que acontece | Como detectar |
|------|----------------|---------------|
| Action: "*" | IA gera permissão total por preguiça | Olhar o JSON da policy |
| s3:* | Escopo muito amplo | Pedir Least Privilege novamente com exemplos |
| Parâmetro fictício | Ex: server_side_encryption_configuration ao invés do recurso separado | `terraform plan` vai quebrar |
| Falso positivo na auditoria | IA aponta "risco" onde não há | Discutir em pares se a crítica faz sentido |

### Critérios de Avaliação (comportamentais)
- [ ] Aluno usou o pipe (`cat iam.tf | agent`) para auditoria
- [ ] Aluno identificou ao menos 1 alucinação (própria ou da auditoria)
- [ ] Aluno refinou o prompt baseado na auditoria
- [ ] Aluno NÃO aceitou Action: "*" sem questionar

---

## Lab 3 — VPC & Modularização

### Gabarito Técnico (estrutura esperada)

**vpc.tf:**
```hcl
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name        = "${var.project_name}-vpc"
    Environment = var.environment
  }
}
```

**subnets.tf:**
```hcl
resource "aws_subnet" "public" {
  count             = 2
  vpc_id            = aws_vpc.main.id
  cidr_block        = "10.0.${count.index}.0/24"
  availability_zone = data.aws_availability_zones.available.names[count.index]

  map_public_ip_on_launch = true

  tags = {
    Name        = "${var.project_name}-public-${count.index}"
    Environment = var.environment
  }
}
```

(Seguem privadas sem map_public_ip_on_launch, com NAT configurado)

**gateways.tf:**
```hcl
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.main.id
}

resource "aws_eip" "nat" {
  domain = "vpc"
}

resource "aws_nat_gateway" "main" {
  allocation_id = aws_eip.nat.id
  subnet_id     = aws_subnet.public[0].id
}
```

**outputs.tf:**
```hcl
output "vpc_id" {
  value = aws_vpc.main.id
}

output "public_subnet_ids" {
  value = aws_subnet.public[*].id
}

output "private_subnet_ids" {
  value = aws_subnet.private[*].id
}
```

### Traps Comuns
| Problema | Sintoma | Ajuda |
|----------|---------|-------|
| IA gera tudo em 1 arquivo | Monólito. Prompt não especificou separação | Re-prompt com "arquivos separados para cada recurso" |
| Subnet pública sem map_public_ip | Instâncias não ganham IP público | Verificar no plan |
| NAT Gateway em subnet privada | Subnet privada não tem rota pra internet | NAT deve estar na pública |
| Falta Elastic IP no NAT | `terraform plan` mostra erro de alocation_id | Adicionar resource "aws_eip" |

### Critérios de Avaliação (comportamentais)
- [ ] Aluno usou chain-of-prompts (não 1 prompt só)
- [ ] Aluno criou arquivos separados (modularização)
- [ ] Aluno fez validação cruzada com Prompt 3
- [ ] Aluno leu o plan antes de qualquer apply

---

## Fallback sem Learner Lab

Sem Learner Lab, o `terraform plan` substitui o `apply` como validação. Os critérios comportamentais permanecem os mesmos. No Lab 2, a detecção de alucinação ganha ainda mais importância.

## Checklist Geral da Aula

- [ ] Alunos fizeram `git commit` após cada lab
- [ ] Código do Lab 3 está commitado (ponto de partida do Módulo 2)
- [ ] `terraform destroy` foi executado (se Learner Lab usado)
