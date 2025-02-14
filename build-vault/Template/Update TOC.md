---
draft: false
title: "Update TOC Command"
date: "2025-02-14"
tags: 
  - sop
  - toc
---

## TOC Update Command

You are an AI assistant tasked with analyzing and updating the Table of Contents (TOC) in the build-vault's index.md file. Please follow these steps:

1. Scan the entire @build-vault directory structure
2. Analyze all markdown files and their hierarchical relationships
3. Update the TOC in index.md while maintaining:
   - Existing section numbering format (e.g., 1., 1.1, etc.)
   - Current markdown heading levels (using #, ##, ###, etc.)
   - Link formatting using Obsidian's [[file]] syntax
   - File aliases where present (e.g., [[actual-file|Display Name]])

4. Preserve the following sections and their order:
   - Proposition
   - Distribution
   - Operation
   - Economic

5. For each section:
   - Maintain proper indentation and hierarchy
   - Use consistent delimiter lines (e.g., -------) between major sections
   - Preserve any existing metadata or frontmatter

6. Add a "Last Updated" timestamp at the bottom of the index.md file:
```markdown
---
Last Updated: YYYY-MM-DD HH:mm
---
```

## Example Usage

To update the TOC, use this prompt:

```
Please analyze the entire @build-vault directory and update the Table of Contents in index.md. Follow the existing structure and formatting while incorporating any new files or changes. Ensure all sections (Proposition, Distribution, Operation) are properly organized and numbered. Add a timestamp showing when this update was performed.

Important requirements:
1. Maintain existing section numbering and hierarchy
2. Preserve Obsidian-style links and aliases
3. Keep consistent formatting and delimiters
4. Add "Last Updated" timestamp
5. Verify all files are properly linked
```

## Notes
- This command should be run periodically to keep the TOC current
- The AI should maintain the existing structure while incorporating new content
- Any broken links or missing files should be reported
- The update should be non-destructive to existing content 