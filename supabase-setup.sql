-- Chạy 1 lần trong Supabase Dashboard > SQL Editor > New query > Run
create table if not exists public.tasks (
  id          text primary key,
  seq         bigserial,
  title       text not null,
  category    text not null,
  status      text not null,
  priority    text not null default 'medium',
  owner       text default '',
  due         text default '',
  description text default '',
  created     text,
  updated_at  timestamptz default now()
);

-- Không dùng đăng nhập: cho phép ai có link app đều đọc/ghi
alter table public.tasks enable row level security;
drop policy if exists "team full access" on public.tasks;
create policy "team full access" on public.tasks
  for all to anon using (true) with check (true);

grant select, insert, update, delete on public.tasks to anon;
grant usage, select on sequence public.tasks_seq_seq to anon;
