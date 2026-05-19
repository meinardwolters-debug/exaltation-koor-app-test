-- Muziekbibliotheek voor Exaltation
-- Uitvoeren in Supabase SQL Editor op de TESTOMGEVING.

create table if not exists public.music_library (
  id bigint generated always as identity primary key,
  title text not null,
  category text default 'Algemeen',
  pdf_url text,
  soprano_url text,
  alto_url text,
  tenor_url text,
  bass_url text,
  notes text,
  active boolean default true,
  created_at timestamptz default now()
);

grant usage on schema public to anon;
grant select, insert, update on public.music_library to anon;
grant usage, select on all sequences in schema public to anon;

alter table public.music_library enable row level security;

drop policy if exists "music_library_select" on public.music_library;
drop policy if exists "music_library_insert" on public.music_library;
drop policy if exists "music_library_update" on public.music_library;

create policy "music_library_select" on public.music_library for select to anon using (true);
create policy "music_library_insert" on public.music_library for insert to anon with check (true);
create policy "music_library_update" on public.music_library for update to anon using (true) with check (true);

insert into public.music_library (title, category, notes, active)
select 'Voorbeeldlied', 'Algemeen', 'Vervang dit voorbeeld door echte bladmuziek en audio-links.', true
where not exists (select 1 from public.music_library);


alter table public.music_library
add column if not exists choir_url text;
