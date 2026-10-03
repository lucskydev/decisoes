# Sistema auxiliar de tomada de decisões

Compare opções com critérios e pesos personalizados, em quantas análises quiser.
Página estática (um único `index.html`) publicada no **GitHub Pages**, com dados salvos no **Supabase**.

## Como funciona

- **Sem login**: tudo fica salvo só no navegador (localStorage) — o app já funciona assim.
- **Com login**: o estado completo vai para a tabela `decisoes_estado` (uma linha por usuário) e as fotos para o bucket `decisoes-imagens`. Uma cópia local continua sendo mantida como segurança.
- Os dados são protegidos por **RLS**: cada usuário só enxerga e altera a própria linha.
- **Exportar/Importar** JSON continua disponível como backup manual.

## Configuração

Já feita neste repositório (projeto Supabase "sistemas"):

- `supabase-setup.sql` aplicado: tabela `decisoes_estado`, regras RLS e bucket `decisoes-imagens`.
- `config.js` preenchido com a URL e a chave *anon* do projeto.

Falta apenas:

1. **GitHub → Settings → Pages**: Source = *Deploy from a branch*, branch `main`, pasta `/ (root)`.
2. Abrir `https://lucskydev.github.io/decisoes/` e entrar com um usuário criado em **Supabase → Authentication → Users → Add user** (marcando "Auto Confirm User"). O projeto "sistemas" começa sem usuários.
3. Opcional, para uso pessoal: em **Authentication → Sign In / Providers**, desativar "Allow new users to sign up".

> A chave *anon* é pública por design. Nunca use a `service_role` neste projeto.

## Observações

- Edição simultânea em dois aparelhos: vale a última gravação (não há mesclagem).
- Fotos enviadas logado ficam em bucket de leitura por link: o endereço é aleatório, mas quem tiver o link consegue ver a imagem.
