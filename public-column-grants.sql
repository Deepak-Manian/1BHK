-- THE 1BHK CHRONICLES — anonymous column-level read permissions
-- Run after the public-read/restricted-write RLS migration.
-- Anonymous visitors can read public meal fields and weight values, but not internal IDs or weight notes.
-- Authenticated users retain their existing full meal/weight permissions, still restricted by RLS.

begin;

-- Remove table-wide anonymous SELECT, then grant only fields used by the public site.
revoke select on table public.meals from anon;
grant select (id, category, food_name, cook, status, meal_date, meal_time, note, image_path, created_at)
  on table public.meals to anon;

revoke select on table public.weights from anon;
grant select (id, weigh_date, kg, created_at)
  on table public.weights to anon;

-- security_invoker=true means the weekly view also needs access to its source columns.
-- The view uses meal_date and status for weekly aggregates.
grant select on table public.weekly_summary to anon;

commit;

-- Verify: expected true, false, true, false.
select
  has_column_privilege('anon', 'public.meals', 'food_name', 'SELECT') as public_can_read_meal_name,
  has_column_privilege('anon', 'public.meals', 'created_by', 'SELECT') as public_can_read_meal_creator,
  has_column_privilege('anon', 'public.weights', 'kg', 'SELECT') as public_can_read_weight,
  has_column_privilege('anon', 'public.weights', 'note', 'SELECT') as public_can_read_weight_note;
