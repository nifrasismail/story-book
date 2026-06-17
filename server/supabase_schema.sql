-- Run this in your Supabase project → SQL Editor

create table if not exists public.user_profiles (
  user_id     uuid primary key references auth.users(id) on delete cascade,
  email       text not null,
  display_name text,
  total_stars  int not null default 0,
  current_streak int not null default 0,
  longest_streak int not null default 0,
  last_read_date text,
  completed_story_ids text[] not null default '{}',
  favourite_story_ids text[] not null default '{}',
  unlocked_badge_ids  text[] not null default '{}',
  has_premium_pack    boolean not null default false,
  has_removed_ads     boolean not null default false,
  updated_at  timestamptz not null default now()
);

-- Auto-update updated_at on any row change
create or replace function public.set_updated_at()
returns trigger language plpgsql as $$
begin
  new.updated_at = now();
  return new;
end;
$$;

drop trigger if exists set_updated_at on public.user_profiles;
create trigger set_updated_at
  before update on public.user_profiles
  for each row execute function public.set_updated_at();

-- Row Level Security: users can only read/write their own row.
-- Our server uses service_role key so it bypasses RLS entirely.
alter table public.user_profiles enable row level security;

create policy "users read own profile"
  on public.user_profiles for select
  using (auth.uid() = user_id);

create policy "users update own profile"
  on public.user_profiles for update
  using (auth.uid() = user_id);

-- Remote config table (server-side only, no RLS needed — read via service_role)
create table if not exists public.app_config (
  key   text primary key,
  value text not null
);

-- Seed default values
insert into public.app_config (key, value) values ('ads_enabled', 'true')
  on conflict (key) do nothing;
