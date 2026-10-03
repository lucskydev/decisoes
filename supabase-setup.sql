-- Execute no Supabase: SQL Editor > New query > cole tudo > Run.
-- Pode ser executado mais de uma vez sem problema.

-- 1) Tabela com o estado completo do app (uma linha por usuário)
create table if not exists public.decisoes_estado (
  user_id       uuid primary key references auth.users(id) on delete cascade,
  dados         jsonb       not null,
  atualizado_em timestamptz not null default now()
);

alter table public.decisoes_estado enable row level security;

drop policy if exists "decisoes_select_proprio" on public.decisoes_estado;
drop policy if exists "decisoes_insert_proprio" on public.decisoes_estado;
drop policy if exists "decisoes_update_proprio" on public.decisoes_estado;
drop policy if exists "decisoes_delete_proprio" on public.decisoes_estado;

create policy "decisoes_select_proprio" on public.decisoes_estado
  for select to authenticated using (auth.uid() = user_id);
create policy "decisoes_insert_proprio" on public.decisoes_estado
  for insert to authenticated with check (auth.uid() = user_id);
create policy "decisoes_update_proprio" on public.decisoes_estado
  for update to authenticated using (auth.uid() = user_id) with check (auth.uid() = user_id);
create policy "decisoes_delete_proprio" on public.decisoes_estado
  for delete to authenticated using (auth.uid() = user_id);

-- 2) Bucket das fotos (leitura por link; só o dono envia/apaga na própria pasta)
insert into storage.buckets (id, name, public)
values ('decisoes-imagens', 'decisoes-imagens', true)
on conflict (id) do nothing;

drop policy if exists "decisoes_img_insert_proprio" on storage.objects;
drop policy if exists "decisoes_img_delete_proprio" on storage.objects;

create policy "decisoes_img_insert_proprio" on storage.objects
  for insert to authenticated
  with check (bucket_id = 'decisoes-imagens' and (storage.foldername(name))[1] = auth.uid()::text);
create policy "decisoes_img_delete_proprio" on storage.objects
  for delete to authenticated
  using (bucket_id = 'decisoes-imagens' and (storage.foldername(name))[1] = auth.uid()::text);
