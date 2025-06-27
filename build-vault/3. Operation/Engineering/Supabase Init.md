---
draft: false
title: Supabase Init
date: 2025-03-07
tags:
---
Supabase init


npx supabase init

npx supabase login

config.toml - our supabase setup (port etc)

npx supabase start (initiate local image)

npx supabase db reset (trying database schema at local)

npx supabase db push ()


Ensure cursor rules 
### Migration Rules

- Never edit existing migration files in `supabase/migrations`.

- Follow our migration sequence number (0001,0002,0003) to create new migrations for any changes.

- The pre-commit hook will block edits to old migrations.


have a schema.md for managing changelog in schema