# Deployment and Supabase checklist

## 1. Add the public client key
- Supabase Dashboard → Project Settings → API Keys.
- Copy the **publishable key** (or legacy `anon` public key).
- Paste it into `supabase-config.js` as `SUPABASE_ANON_KEY`.
- Never use the `service_role` key or a secret key in browser code.

## 2. Authentication
- Email provider enabled.
- New user signups disabled.
- Both existing Auth users are registered in `public.profiles`.
- Site URL: `https://mathes-was-not-ready.vercel.app`.
- Redirect allow-list includes the production origin and local development URLs.
- Editor sign-in uses email magic links; only allow-listed profiles receive editor permissions.

## 3. Database assumptions
- Run `public-column-grants.sql` in SQL Editor to keep anonymous reads limited to the public columns used by the page.
The frontend expects these existing columns:
- `meals`: `id`, `category`, `food_name`, `cook`, `status`, `meal_date`, `meal_time`, `note`, `image_path`, `created_at`.
- `weights`: `id`, `weigh_date`, `kg`, `created_at`.
- `profiles`: `id`, `display_name`.

Public SELECT is expected for meal/weight columns used by the page; INSERT/UPDATE/DELETE remain restricted to authenticated users for whom `public.is_authorized_user()` is true. `supabase_realtime` should include `meals` and `weights`.

## 4. Storage
- Bucket: `meal-photos`.
- Public bucket: enabled (anyone with an image URL can view files).
- Upload/update/delete policies: authenticated + `public.is_authorized_user()`.
- Max file size shown in the current bucket: 10 MB.
- Allowed types: JPEG, PNG, WebP.

## 5. Local testing
From the folder root: `python -m http.server 5500`, then open `http://localhost:5500`.

Test: public anonymous read, magic-link editor login for both accounts, meal create/edit/delete, image upload and display, weight create/edit/delete, and two-browser Realtime sync.

## 6. Vercel
Static deployment: Framework preset `Other`, no build command, output directory `.`. Deploy `index.html`, `supabase-config.js`, and all four image/icon assets from the project root.
