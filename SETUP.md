# THE 1BHK CHRONICLES — Supabase frontend integration

This is the updated static frontend built from your supplied `index.html`. It preserves the original pixel-art visuals and uses Supabase for shared records.

## Important: preserve your API configuration
- You already created `supabase-config.js` in your local project and entered the publishable key. **Keep that file.**
- This bundle intentionally does not include/overwrite `supabase-config.js`. It includes `supabase-config.example.js` only as a template.
- The frontend expects `window.SUPABASE_CONFIG` with `SUPABASE_URL` and `SUPABASE_ANON_KEY`.
- Use only the publishable/legacy anon key, never a service-role or secret key.

## Included behavior
- Public visitors can read meal records, weight values, weekly summary and public meal photos.
- Public visitors cannot create, edit or delete records.
- The two users allow-listed in `public.profiles` can sign in using email magic links and edit records.
- Meal photos upload to the public `meal-photos` bucket; upload/update/delete remain restricted by Storage policies.
- Meals and weights load from Supabase and refresh through Realtime.
- No sample meal/weight data or shared-record `localStorage` persistence is used.

## Before deploying
1. Keep your existing `supabase-config.js` in the same folder as `index.html`.
2. Confirm it contains the correct project URL and publishable key.
3. Confirm the SQL migrations and the public-column grants have run successfully.
4. Confirm the `meal-photos` bucket is public and the four authenticated allow-list Storage policies exist.
5. Confirm `meals` and `weights` are in `supabase_realtime`.

## Local test
Run from this folder:

```bash
python -m http.server 5500
```

Open `http://localhost:5500`. That URL must be allowed in Supabase Authentication → URL Configuration.

## Vercel
Use Framework Preset **Other**, no build command, output directory `.`. Keep `index.html`, `supabase-config.js`, `apple-touch-icon.png`, `favicon.ico`, `favicon-32.png`, and `og.png` in the deployment root.

## Test checklist
- In a signed-out/incognito browser, verify public reads and hidden edit controls.
- Sign in with each of the two allow-listed email accounts.
- Create/edit/delete a meal and upload a photo.
- Create/edit/delete a weight entry.
- Confirm a second browser sees changes without refreshing.
- Check browser console and Supabase Logs for errors.
