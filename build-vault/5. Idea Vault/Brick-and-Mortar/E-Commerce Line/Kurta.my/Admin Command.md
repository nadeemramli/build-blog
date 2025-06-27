---
draft: true
title: "Admin Command"
date: "2025-03-07"
tags: 
---
-- Set up a user as admin with owner role

SELECT setup_admin_user('d5461824-e24b-4886-8d55-ddbe19259e1f'::uuid, 'owner'::admin_role);

  

-- Verify the user's admin status and role

SELECT

    email,

    raw_user_meta_data->>'isAdmin' as is_admin,

    raw_user_meta_data->>'role' as role,

    raw_user_meta_data->>'updatedAt' as last_updated

FROM auth.users

WHERE id = 'd5461824-e24b-4886-8d55-ddbe19259e1f'::uuid;



![[Pasted image 20250307052604.png]]