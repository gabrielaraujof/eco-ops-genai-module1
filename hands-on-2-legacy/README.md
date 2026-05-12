# Hands-on 2: Auditoria SecOps

## Missão
Auditar o código legado do projeto Eco-Ops e aplicar correções baseadas no princípio de Menor Privilégio (Least Privilege).

## Tarefa
1. Analise os arquivos `security_group.tf` e `iam_policy.tf` usando seu coding agent como auditor.
2. Envie o conteúdo dos arquivos para o agente com os prompts sugeridos abaixo.
   - **Prompt para security_group.tf:** `"Atue como auditor SecOps. Liste falhas críticas neste SG e sugira a correção em HCL."`
   - **Prompt para iam_policy.tf:** `"Reescreva esta IAM policy removendo wildcards (*) e restringindo as permissões ao mínimo necessário para um desenvolvedor de S3 e EC2."`
3. Compare o código original com o sugerido pelo agente.

> **Transposição (CLI):** `cat security_group.tf | claude "Atue como auditor..."` (Claude Code),
> `cat security_group.tf | gemini "Atue como auditor..."` (Gemini CLI).
> Repita o mesmo padrão para `iam_policy.tf` com o prompt correspondente.
> Em IDEs, cole o conteúdo diretamente.

## Objetivos de Aprendizado
- Identificar configurações permissivas (SSH aberto, IAM Full Access).
- Usar a IA para acelerar o processo de "Shift-left" de segurança.
- Validar se a IA alucinou em algum parâmetro de segurança.
