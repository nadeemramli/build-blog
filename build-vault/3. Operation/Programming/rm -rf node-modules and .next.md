---
draft: false
title: rm -rf node-modules and .next
date: 2025-03-07
tags:
---
```*
find . \( -name ".next" -o -name "node_modules" \) -type d -exec rm -rf {} \;
```