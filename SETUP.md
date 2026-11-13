# Setup: Vercel + Supabase + monitoring

## 1. Deploy to Vercel (5 min)
1. Put this folder in a GitHub repo (index.html and the icons at the repo root).
2. vercel.com > Add New > Project > import the repo.
3. Framework preset: Other. Leave build command empty. Output directory: `.`
4. Deploy. Then open `index.html` and replace both `YOUR-DOMAIN.vercel.app` with your real domain, commit, and push.
5. Check the link preview with the Facebook Sharing Debugger or opengraph.xyz.

## 2. Database (Supabase)
1. supabase.com > New project (free tier is fine). Save the project URL and the `anon` public key (Settings > API).
2. SQL Editor: paste `supabase.sql` (edit the two emails) and run it.
3. Authentication > Providers: enable Email (magic link). Add your Vercel URL under URL Configuration > Site URL.
4. The anon key is meant to be public. Row Level Security in the SQL is what protects your data, so do not skip it.

## 3. Wiring the frontend (not done yet)
The site keeps meals and weights in `meals` / `wts` arrays and saves through `store` and `save()`.
Plan: load both tables on start, map fields, and make `save()` upsert changes and delete removed rows. Add a small login button so only you two can write. Field mapping:
meals: c=category, n=food_name, k=cook, s=status, d=meal_date, h=meal_time, x=note, i=image
weights: d=weigh_date, kg=kg
Load supabase-js from a pinned CDN version, for example `https://cdn.jsdelivr.net/npm/@supabase/supabase-js@2.45.4`.

## 4. Monitoring
- Visitors: Vercel project > Analytics > Enable (the script is already in index.html).
- Progress: Supabase > Table Editor for raw rows, and `select * from weekly_summary;` for eaten / skipped / ordered per week.
- Errors: Vercel project > Logs, and the browser console while testing.
- Backups: Supabase > Database > Backups (daily on paid plans). On free, export CSV from the Table Editor now and then.
