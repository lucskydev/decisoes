# Sistema auxiliar de tomada de decisões

Compare opções com critérios e pesos personalizados, em quantas análises quiser.
Página estática (um único `index.html`) publicada no **GitHub Pages**, com dados salvos no **Supabase**.

## Como funciona

- **Sem login**: tudo fica salvo só no navegador (localStorage) — o app já funciona assim.
- **Com login**: o estado completo vai para a tabela `decisoes_estado` (uma linha por usuário) e as fotos para o bucket `decisoes-imagens`. Uma cópia local continua sendo mantida como segurança.
- Os dados são protegidos por **RLS**: cada usuário só enxerga e altera a própria linha.
- **Exportar/Importar** JSON continua disponível como backup manual.

## Configuração (uma vez)

1. **Supabase → SQL Editor**: cole e execute `supabase-setup.sql`.
2. **Supabase → Authentication → Users → Add user**: crie seu usuário (e-mail + senha, marcando "Auto Confirm User").
3. **Supabase → Authentication → Sign In / Providers**: desative "Allow new users to sign up" (uso pessoal).
4. **Supabase → Project Settings → API**: copie a *Project URL* e a chave *anon public*, e cole em `config.js`.
5. **GitHub → Settings → Pages**: Source = *Deploy from a branch*, branch `main`, pasta `/ (root)`.
6. Abra `https://SEU-USUARIO.github.io/NOME-DO-REPOSITORIO/` e entre com o usuário criado.

> A chave *anon* é pública por design. Nunca use a `service_role` neste projeto.

## Observações

- Edição simultânea em dois aparelhos: vale a última gravação (não há mesclagem).
- Fotos enviadas logado ficam em bucket de leitura por link: o endereço é aleatório, mas quem tiver o link consegue ver a imagem.
