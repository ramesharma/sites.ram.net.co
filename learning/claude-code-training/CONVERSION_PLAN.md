# Conversion Plan: claude-code-training.html → /learning/claude-code-training/

## Source Analysis
- **Format**: Single-file slide deck (6466 lines, 320KB)
- **Theme**: Electric Studio (dark, Manrope + JetBrains Mono, accent #3B6FE8)
- **Structure**: 21 modules + 2 bonus modules, 10 labs, 155 slides
- **Features**: Full navigation, fragments, speaker notes, Motion One animations, diagrams

## Target Requirements
- **Format**: Static guide page(s) for `sites.ram.net.co/learning/claude-code-training/`
- **Design System**: Shared design system (light, Inter + JetBrains Mono, accent #0070f3)
- **Structure**: Article/guide format (not slide deck)
- **Quality**: No AI slop, high editorial standards, diagrams + animations where useful

## Conversion Strategy

### Option A: Single long guide page (recommended)
- One page at `learning/claude-code-training/index.html`
- Table of contents with anchor links
- Each module = one major section
- Labs called out in callout boxes
- Diagrams converted to inline SVG with design system colors
- Code blocks with proper syntax highlighting classes

### Option B: Multi-page (one per module)
- `learning/claude-code-training/` = index with TOC
- `learning/claude-code-training/module-01/` through `module-21/`
- More complex listing integration

**Decision: Option A** — simpler, better for reading, matches "guide" format on /learning/

## Content Restructuring

| Source Element | Target Treatment |
|----------------|------------------|
| Title slide | Hero section |
| Module dividers | Section headers with eyebrow |
| Slides with content | Prose paragraphs + code blocks + callouts |
| Fragment animations | Removed (static guide) |
| Speaker notes | Moved to "Facilitator notes" callout boxes |
| Checkpoint slides | "Key takeaways" summary boxes |
| Lab slides | Dedicated "Lab" callout sections with success criteria |
| Diagrams (SVG) | Inline SVG, recolored to design system palette |
| Terminal demos | Code blocks with terminal styling |
| Tables | Markdown tables with design system styling |
| Navigation/JS | Removed (static HTML) |

## Visual Enhancements (beyond direct conversion)

1. **Syntax highlighting** for code blocks (add Prism.js or similar lightweight)
2. **Diagram animations** - subtle scroll-triggered reveals for key diagrams
3. **Interactive TOC** - sticky sidebar on desktop
4. **Copy-to-clipboard** buttons on code blocks
5. **Progress indicator** - reading progress bar
6. **Print stylesheet** - clean PDF export

## File Structure

```
learning/claude-code-training/
├── index.html          # Main guide (only file needed)
└── (no assets needed - diagrams inline, fonts from design system)
```

## Design System Compliance

- Use only classes from `/design-system/main.css`
- No inline CSS beyond minimal overrides
- Colors: design system tokens only (--accent, --text, --muted, etc.)
- Typography: Inter for prose, JetBrains Mono for code/meta
- Spacing: design system spacing scale

## Quality Gates

- [ ] No AI clichés ("In today's rapidly evolving landscape", "game-changer", etc.)
- [ ] Every code block is real, runnable, from source
- [ ] Every diagram recolored to design system palette
- [ ] No slide-deck language ("In this slide we'll cover...")
- [ ] Human voice throughout (article-writing skill)
- [ ] Renders standalone (no server needed)
- [ ] Lists in /learning/ index via GitHub Action

## Timeline

1. **Extract & restructure content** (modules → sections)
2. **Rewrite in guide voice** (article-writing skill)
3. **Convert diagrams to design system colors**
4. **Build index.html with design system**
5. **Add subtle enhancements (TOC, copy buttons, scroll reveals)**
6. **Test locally → review → push**

---

**Next step**: I'll start the conversion. This will take several iterations. I'll produce the guide in chunks and show you progress for review before final push.