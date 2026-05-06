# Hands-on 1: Primeiros Passos no CLI

## Missão
Gerar e validar um recurso simples na AWS via Gemini CLI.

## Tarefa
1. Use o Gemini CLI para gerar um arquivo `dynamodb.tf`.
2. **Restrições Obrigatórias:**
   - Use o provider AWS versão 5.0 ou superior.
   - Force a encriptação em repouso (Encryption at rest).
   - O prompt deve solicitar que o Gemini retorne **apenas** o código HCL.
3. Redirecione a saída para o arquivo: `gemini "seu prompt aqui" > dynamodb.tf`.
4. Execute `terraform init` e `terraform plan` para validar a sintaxe e as restrições.

## Dica de Prompt
> "Atue como um engenheiro DevOps. Gere um arquivo Terraform para uma tabela DynamoDB chamada 'eco-ops-events'. Use o provider AWS v5.x. Ative server-side encryption. Retorne apenas o código, sem explicações."
