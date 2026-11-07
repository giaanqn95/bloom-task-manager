-- Chạy 1 lần trong Supabase SQL Editor: thêm Output + kho lưu file

alter table public.tasks add column if not exists output_text  text  default '';
alter table public.tasks add column if not exists output_files jsonb default '[]'::jsonb;

insert into storage.buckets (id, name, public, file_size_limit)
values ('task-outputs', 'task-outputs', true, 20971520)
on conflict (id) do update set public = true, file_size_limit = 20971520;

drop policy if exists "task-outputs insert" on storage.objects;
create policy "task-outputs insert" on storage.objects
  for insert to anon with check (bucket_id = 'task-outputs');

drop policy if exists "task-outputs delete" on storage.objects;
create policy "task-outputs delete" on storage.objects
  for delete to anon using (bucket_id = 'task-outputs');
