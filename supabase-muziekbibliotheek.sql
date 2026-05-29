-- Muziekbibliotheek v2 voor Exaltation
-- Uitvoeren in Supabase SQL Editor op de TESTOMGEVING.
--
-- Bestanden worden als pad opgeslagen vanaf:
-- https://gospelkoorexaltation.nl/muziek/
--
-- Voorbeelden:
-- bladmuziek/amazing-grace.pdf
-- audio/amazing-grace-sopraan.mp3

create table if not exists public.music_library_v2 (
  id bigint generated always as identity primary key,
  title text not null,
  category text default 'Algemeen',
  pdf_path text,
  soprano_path text,
  alto_path text,
  tenor_path text,
  bass_path text,
  choir_path text,
  notes text,
  active boolean default true,
  created_at timestamptz default now()
);

create index if not exists music_library_v2_active_title_idx
  on public.music_library_v2 (active, title);

grant usage on schema public to anon;
grant select, insert, update on public.music_library_v2 to anon;
grant usage, select on all sequences in schema public to anon;

alter table public.music_library_v2 enable row level security;

drop policy if exists "music_library_v2_select" on public.music_library_v2;
drop policy if exists "music_library_v2_insert" on public.music_library_v2;
drop policy if exists "music_library_v2_update" on public.music_library_v2;

create policy "music_library_v2_select"
  on public.music_library_v2 for select to anon
  using (true);

create policy "music_library_v2_insert"
  on public.music_library_v2 for insert to anon
  with check (true);

create policy "music_library_v2_update"
  on public.music_library_v2 for update to anon
  using (true)
  with check (true);

do $$
begin
  if to_regclass('public.music_library') is not null then
    insert into public.music_library_v2 (
      title,
      category,
      pdf_path,
      soprano_path,
      alto_path,
      tenor_path,
      bass_path,
      choir_path,
      notes,
      active,
      created_at
    )
    select
      title,
      coalesce(category, 'Algemeen'),
      regexp_replace(coalesce(pdf_url, ''), '^https?://gospelkoorexaltation\.nl/muziek/?', ''),
      regexp_replace(coalesce(soprano_url, ''), '^https?://gospelkoorexaltation\.nl/muziek/?', ''),
      regexp_replace(coalesce(alto_url, ''), '^https?://gospelkoorexaltation\.nl/muziek/?', ''),
      regexp_replace(coalesce(tenor_url, ''), '^https?://gospelkoorexaltation\.nl/muziek/?', ''),
      regexp_replace(coalesce(bass_url, ''), '^https?://gospelkoorexaltation\.nl/muziek/?', ''),
      regexp_replace(coalesce(choir_url, ''), '^https?://gospelkoorexaltation\.nl/muziek/?', ''),
      notes,
      coalesce(active, true),
      coalesce(created_at, now())
    from public.music_library old
    where not exists (
      select 1
      from public.music_library_v2 new
      where lower(new.title) = lower(old.title)
    );
  end if;
end $$;

insert into public.music_library_v2 (title, category, notes, active)
select 'Voorbeeldlied', 'Algemeen', 'Vervang dit voorbeeld door echte bladmuziek en audio-paden.', true
where not exists (select 1 from public.music_library_v2);
