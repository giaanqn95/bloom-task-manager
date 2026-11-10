-- CHẠY SAU KHI cả team đã nhận lời mời và đăng nhập được (xem hướng dẫn).
-- Từ lúc chạy, chỉ người ĐÃ ĐĂNG NHẬP mới đọc/ghi được dữ liệu. Người lạ (anon) bị chặn hoàn toàn.
-- Chạy trong Supabase Dashboard > SQL Editor > New query > Run

-- tasks
drop policy if exists "team full access" on public.tasks;
drop policy if exists "members only" on public.tasks;
create policy "members only" on public.tasks
  for all to authenticated using (true) with check (true);
revoke all on public.tasks from anon;
grant select, insert, update, delete on public.tasks to authenticated;
grant usage, select on sequence public.tasks_seq_seq to authenticated;

-- task_comments
drop policy if exists "team comments" on public.task_comments;
drop policy if exists "members only" on public.task_comments;
create policy "members only" on public.task_comments
  for all to authenticated using (true) with check (true);
revoke all on public.task_comments from anon;
grant select, insert, update, delete on public.task_comments to authenticated;
grant usage, select on sequence public.task_comments_id_seq to authenticated;

-- file đính kèm (upload/xóa chỉ cho người đã đăng nhập)
drop policy if exists "task-outputs insert" on storage.objects;
drop policy if exists "task-outputs delete" on storage.objects;
create policy "task-outputs insert" on storage.objects
  for insert to authenticated with check (bucket_id = 'task-outputs');
create policy "task-outputs delete" on storage.objects
  for delete to authenticated using (bucket_id = 'task-outputs');
