# Hands-on 3: O Esqueleto da Rede (Projeto Eco-Ops)

## Missão
Erguer a VPC base do Projeto Eco-Ops usando GenAI de ponta a ponta.

## Arquitetura Alvo
- **1 VPC**
- **2 Subnets Públicas** (com Internet Gateway)
- **2 Subnets Privadas** (com NAT Gateway)
- **Região:** us-east-1 (ou sua preferência)

## Regras do Jogo
1. **Modularização:** O código NÃO pode ser um monólito. Peça ao Gemini para gerar arquivos separados para `vpc.tf`, `subnets.tf`, `gateways.tf` e `variables.tf`.
2. **Contexto:** Informe à IA que o ambiente é de **Produção** e exige Alta Disponibilidade.
3. **Validação:** Após gerar os arquivos, execute `terraform init` e `terraform plan`.

## Desafio
Tente gerar o prompt mais curto possível que resulte na arquitetura correta seguindo todas as regras de modularização.

**💡 Dica de Fluxo:** Como a IA irá gerar o conteúdo de múltiplos arquivos em uma única resposta, você terá que criar a estrutura de pastas e arquivos manualmente (ex: `mkdir -p modules/vpc`) e colar o conteúdo correspondente gerado pelo Gemini em cada arquivo (`main.tf`, `variables.tf`, etc).

---
*Dica: Sem o NAT Gateway, seus microsserviços em subnets privadas não terão acesso à internet para baixar dependências ou atualizações.*
