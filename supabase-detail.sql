-- Chạy 1 lần trong Supabase SQL Editor: bảng bình luận cho trang chi tiết task
create table if not exists public.task_comments (
  id         bigserial primary key,
  task_id    text not null references public.tasks(id) on delete cascade,
  author     text not null,
  body       text not null,
  created_at timestamptz default now()
);
create index if not exists task_comments_task_id_idx on public.task_comments(task_id);

alter table public.task_comments enable row level security;
drop policy if exists "team comments" on public.task_comments;
create policy "team comments" on public.task_comments
  for all to anon using (true) with check (true);

grant select, insert, update, delete on public.task_comments to anon;
grant usage, select on sequence public.task_comments_id_seq to anon;
