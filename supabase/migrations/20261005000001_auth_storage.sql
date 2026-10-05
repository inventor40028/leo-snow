-- Storage bucket for images (public read, admin write)
insert into storage.buckets (id, name, public) values ('media', 'media', true) on conflict (id) do nothing;

drop policy if exists "public read media" on storage.objects;
create policy "public read media" on storage.objects for select using (bucket_id = 'media');
drop policy if exists "admin upload media" on storage.objects;
create policy "admin upload media" on storage.objects for insert to authenticated with check (bucket_id = 'media');
drop policy if exists "admin update media" on storage.objects;
create policy "admin update media" on storage.objects for update to authenticated using (bucket_id = 'media');
drop policy if exists "admin delete media" on storage.objects;
create policy "admin delete media" on storage.objects for delete to authenticated using (bucket_id = 'media');

-- Tighten RLS: editing content and reading the inbox require a logged-in admin
drop policy if exists "public update content" on site_content;
create policy "admin update content" on site_content for update to authenticated using (true) with check (true);
drop policy if exists "public read messages" on messages;
create policy "admin read messages" on messages for select to authenticated using (true);
drop policy if exists "admin delete messages" on messages;
create policy "admin delete messages" on messages for delete to authenticated using (true);
