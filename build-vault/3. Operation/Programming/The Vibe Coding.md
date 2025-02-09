---
draft: true
title: "The Vibe Coding"
date: "2025-02-05"
tags: 
---
Leverage the Compose

The workflow goes like this

npm run dev,
see what's wrong and right, and fix.




Starting a new composer and warming up:
1. Put down the error
2. Ask the AI to read the README.md documentation

```
An Example of the Prompt

Skipping linting Checking validity of types .Failed to compile. ./lib/hooks/use-supabase.ts:3:26 Type error: 'PostgrestSingleResponse' is a type and must be imported using a type-only import when 'verbatimModuleSyntax' is enabled. 1 | import { useState, useCallback } from 'react'; 2 | import { createClient, handleSupabaseError } from '@/lib/supabase/client'; > 3 | import { PostgrestError, PostgrestSingleResponse } from '@supabase/supabase-js'; | ^ 4 | import type { PostgrestFilterBuilder } from '@supabase/postgrest-js'; 5 | import type { DatabaseWithRelations } from '@/types/database'; 6 |  
  
This is the latest error we received when we run the "npm run build", after all changes in the past that we've fixed, this is the new error. Let's fix this, and ensure the codebase don't have same issues like this. When approaching to fix the problem, let's approach it holistically.  
  
Implement these improvements to make the codebase more robust against similar type errors in the future. Please check aswell within the code/file whether there will be potential error, if there is, let's fix it too.  
  
Since this is a new composer, please understand the codebase, our recent progress, and file structure before working on changes. Ask me anything if it's required.

```

Leveraging Momentum and Continuation of Improvement

```
This is the latest error we received when we run the "npm run build", after all changes in the past that we've fixed, this is the new error. Let's fix this, and ensure the codebase don't have same issues like this. When approaching to fix the problem, let's approach it holistically. Implement these improvements to make the codebase more robust against similar type errors in the future. Please check aswell within the code/file whether there will be potential error, if there is, let's fix it too.

Once done proposing the solution, please execute the npm run build command inside the Composer, the verification and result of that will appear here in composer where we can troubleshoot it directly.

Please ensure follow our file structure, don't create files outside from the file structure that we have.
```




Finishing a long composer
2. Always ask them to update the whole changes into the README.md