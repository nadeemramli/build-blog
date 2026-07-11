---
name: vitest-unit-tests-dont-run
description: npm run test only runs Storybook browser tests; plain *.test.ts files are silently skipped
metadata: 
  node_type: memory
  type: project
  originSessionId: 4acf6cca-ea6d-4342-91f6-be01eb6c413d
---

The `vitest` config in `vite.config.ts` defines a `projects:` array containing **only** a Storybook browser project (`include: src/**/*.stories.*`). Because `projects` is set, plain unit tests (`src/**/*.test.ts`, e.g. `sourceBinding.test.ts`, `autoLayout.test.ts`, `worker.test.ts`) are **silently not run** by `npm run test` / `npx vitest run` — output says "No test files found."

**How to apply:** to actually run a unit test, use a standalone in-repo config (env `node`/`jsdom`, `resolve.alias` `@`→`src`, `include` your test) and `npx vitest run --config <file>`. The config must live inside the repo so `vitest/config` resolves. Real fix worth doing: add a second `unit` project to the `projects` array. Flagged in [data-source-architecture.md build log].
