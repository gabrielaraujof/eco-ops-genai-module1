# Hands-on 2: Auditoria SecOps

## Missão
Auditar o código legado do projeto Eco-Ops e aplicar correções baseadas no princípio de Menor Privilégio (Least Privilege).

## Tarefa
1. Analise os arquivos `security_group.tf` e `iam_policy.tf` usando o Gemini CLI como auditor.
2. Use o comando `cat` e o `pipe` para enviar o conteúdo para a IA.
   - **Exemplo:** `cat security_group.tf | gemini "Atue como auditor SecOps. Liste falhas críticas neste SG e sugira a correção em HCL."`
3. Peça para a IA reescrever a `iam_policy.tf` removendo os wildcards (`*`) e restringindo as permissões ao mínimo necessário para um desenvolvedor de S3 e EC2.
4. Compare o código original com o sugerido.

## Objetivos de Aprendizado
- Identificar configurações permissivas (SSH aberto, IAM Full Access).
- Usar a IA para acelerar o processo de "Shift-left" de segurança.
- Validar se a IA alucinou em algum parâmetro de segurança.
