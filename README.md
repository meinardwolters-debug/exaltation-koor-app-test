# Exaltation Koor App - werkversie muziekbibliotheek v2

Deze werkversie sluit aan op de projectcontext uit `PROJECT_CONTEXT.md`.

Belangrijkste punten:
- React/Vite frontend met Supabase backend
- Muziekbibliotheek gebruikt `music_library_v2`
- Bestanden worden opgeslagen als pad vanaf `https://gospelkoorexaltation.nl/muziek/`
- Leden zien alleen hun eigen stemgroepaudio plus de volledige kooropname
- Dirigent ziet alle stemgroepen plus de volledige kooropname
- Secretaris kan liederen toevoegen, wijzigen en deactiveren

Eerst uitvoeren in Supabase SQL Editor op de testomgeving:

```sql
supabase-muziekbibliotheek.sql
```

Velden in `music_library_v2`:
- `title`
- `category`
- `pdf_path`
- `soprano_path`
- `alto_path`
- `tenor_path`
- `bass_path`
- `choir_path`
- `notes`
- `active`

Voorbeeldpaden:
- `bladmuziek/amazing-grace.pdf`
- `audio/amazing-grace-sopraan.mp3`
- `audio/amazing-grace-koor.mp3`
