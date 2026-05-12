# Hands-on 1: Primeiros Passos

## Missão
Gerar e validar um recurso simples na AWS via coding agent.

## Tarefa
1. Peça para seu coding agent gerar um arquivo `dynamodb.tf`.
2. **Restrições Obrigatórias:**
   - Use o provider AWS versão 5.0 ou superior.
   - Force a encriptação em repouso (Encryption at rest).
   - O prompt deve solicitar que o agente retorne **apenas** o código HCL.
3. Redirecione a saída para o arquivo.
4. Execute `terraform init` e `terraform plan` para validar a sintaxe e as restrições.

## Dica de Prompt
> "Atue como um engenheiro DevOps. Gere um arquivo Terraform para uma tabela DynamoDB chamada 'eco-ops-events'. Use o provider AWS v5.x. Ative server-side encryption. Retorne apenas o código HCL puro, sem blocos de markdown ou explicações."

> **Transposição (CLI):** `claude "prompt" > dynamodb.tf` (Claude Code),
> `gemini "prompt" > dynamodb.tf` (Gemini CLI), `copilot "prompt" > dynamodb.tf` (Copilot CLI),
> ou peça ao seu assistente de IDE (Cursor, Copilot) para criar o arquivo.

**Nota:** Se a IA retornar o código dentro de blocos de markdown (ex: `` ```hcl ... ``` ``), certifique-se de remover essas linhas antes de rodar o `terraform init`.
