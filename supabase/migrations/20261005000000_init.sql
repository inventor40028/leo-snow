create table if not exists site_content (id int primary key, data jsonb);
insert into site_content (id, data) values (1, '{}') on conflict (id) do nothing;

create table if not exists messages (
  id bigint generated always as identity primary key,
  name text,
  email text,
  message text,
  created_at timestamptz default now()
);

alter table site_content enable row level security;
alter table messages enable row level security;

drop policy if exists "public read content" on site_content;
create policy "public read content" on site_content for select using (true);
drop policy if exists "public update content" on site_content;
create policy "public update content" on site_content for update using (true) with check (true);

drop policy if exists "public read messages" on messages;
create policy "public read messages" on messages for select using (true);
drop policy if exists "public insert messages" on messages;
create policy "public insert messages" on messages for insert with check (true);
