# Design Tokens Reference

Complete guide to implementing and using design tokens in your design system.

## What Are Design Tokens?

Design tokens are the visual design atoms of your design system — specifically, they are named entities that store visual design attributes. They're used in place of hard-coded values to maintain a scalable and consistent visual system.

## Benefits

**Consistency**
- Single source of truth for design values
- Ensures brand consistency across platforms
- Easy to maintain and update

**Scalability**
- Change values in one place, update everywhere
- Support multiple themes (light/dark)
- Platform-agnostic (web, iOS, Android)

**Developer-Designer Communication**
- Shared vocabulary between teams
- Design decisions are codified
- Reduces ambiguity

## Token Categories

### 1. Color Tokens

```css
:root {
  /* Brand Colors */
  --color-primary: #0066FF;
  --color-primary-hover: #0052CC;
  --color-primary-active: #003D99;
  --color-primary-subtle: #E6F0FF;

  --color-secondary: #6B7280;
  --color-secondary-hover: #4B5563;

  /* Semantic Colors */
  --color-success: #10B981;
  --color-warning: #F59E0B;
  --color-error: #EF4444;
  --color-info: #3B82F6;

  /* Neutral Palette */
  --color-white: #FFFFFF;
  --color-black: #000000;
  --color-gray-50: #F9FAFB;
  --color-gray-100: #F3F4F6;
  /* ... through gray-900 */

  /* Surface Colors */
  --color-surface: var(--color-white);
  --color-background: var(--color-white);

  /* Text Colors */
  --color-text: var(--color-gray-900);
  --color-text-secondary: var(--color-gray-600);
  --color-text-tertiary: var(--color-gray-400);

  /* Border Colors */
  --color-border: var(--color-gray-200);
  --color-border-hover: var(--color-gray-300);

  /* Focus */
  --color-focus: var(--color-primary);
}
```

**Naming Convention:**
```
--color-{category}-{variant}-{state}

Examples:
--color-primary              (base brand color)
--color-primary-hover        (interactive state)
--color-success-subtle       (background usage)
--color-text-secondary       (content hierarchy)
```

### 2. Typography Tokens

```css
:root {
  /* Font Families */
  --font-base: -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif;
  --font-heading: var(--font-base);
  --font-mono: "SF Mono", Monaco, "Cascadia Code", monospace;

  /* Font Sizes - Fluid Typography */
  --text-xs: clamp(0.75rem, 0.7rem + 0.25vw, 0.875rem);
  --text-sm: clamp(0.875rem, 0.825rem + 0.25vw, 1rem);
  --text-base: clamp(1rem, 0.95rem + 0.25vw, 1.125rem);
  --text-lg: clamp(1.125rem, 1.05rem + 0.375vw, 1.25rem);
  --text-xl: clamp(1.25rem, 1.15rem + 0.5vw, 1.5rem);
  --text-2xl: clamp(1.5rem, 1.35rem + 0.75vw, 1.875rem);
  --text-3xl: clamp(1.875rem, 1.65rem + 1.125vw, 2.25rem);
  --text-4xl: clamp(2.25rem, 1.95rem + 1.5vw, 3rem);
  --text-5xl: clamp(3rem, 2.55rem + 2.25vw, 3.75rem);

  /* Font Weights */
  --font-light: 300;
  --font-normal: 400;
  --font-medium: 500;
  --font-semibold: 600;
  --font-bold: 700;

  /* Line Heights */
  --leading-tight: 1.25;
  --leading-normal: 1.5;
  --leading-relaxed: 1.625;
  --leading-loose: 2;

  /* Letter Spacing */
  --tracking-tight: -0.025em;
  --tracking-normal: 0;
  --tracking-wide: 0.025em;
}
```

**Usage:**
```css
.heading-1 {
  font-family: var(--font-heading);
  font-size: var(--text-4xl);
  font-weight: var(--font-bold);
  line-height: var(--leading-tight);
  letter-spacing: var(--tracking-tight);
}

.body-text {
  font-family: var(--font-base);
  font-size: var(--text-base);
  font-weight: var(--font-normal);
  line-height: var(--leading-normal);
}
```

### 3. Spacing Tokens

```css
:root {
  /* Spacing Scale (4px base) */
  --space-0: 0;
  --space-1: 0.25rem;    /* 4px */
  --space-2: 0.5rem;     /* 8px */
  --space-3: 0.75rem;    /* 12px */
  --space-4: 1rem;       /* 16px */
  --space-5: 1.25rem;    /* 20px */
  --space-6: 1.5rem;     /* 24px */
  --space-8: 2rem;       /* 32px */
  --space-10: 2.5rem;    /* 40px */
  --space-12: 3rem;      /* 48px */
  --space-16: 4rem;      /* 64px */
  --space-20: 5rem;      /* 80px */
  --space-24: 6rem;      /* 96px */
}
```

**Usage:**
```css
.card {
  padding: var(--space-4);
  margin-bottom: var(--space-6);
  gap: var(--space-3);
}

.section {
  padding-block: var(--space-12);
}
```

### 4. Shadow Tokens

```css
:root {
  --shadow-xs: 0 1px 2px 0 rgba(0, 0, 0, 0.05);
  --shadow-sm: 0 1px 3px 0 rgba(0, 0, 0, 0.1);
  --shadow-md: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
  --shadow-lg: 0 10px 15px -3px rgba(0, 0, 0, 0.1);
  --shadow-xl: 0 20px 25px -5px rgba(0, 0, 0, 0.1);
  --shadow-2xl: 0 25px 50px -12px rgba(0, 0, 0, 0.25);

  /* Special Shadows */
  --shadow-inner: inset 0 2px 4px 0 rgba(0, 0, 0, 0.06);
  --shadow-focus: 0 0 0 3px rgba(0, 102, 255, 0.5);
}
```

**Usage:**
```css
.card {
  box-shadow: var(--shadow-md);
}

.card:hover {
  box-shadow: var(--shadow-lg);
}

button:focus-visible {
  box-shadow: var(--shadow-focus);
}
```

### 5. Border Tokens

```css
:root {
  /* Border Radius */
  --radius-sm: 0.125rem;   /* 2px */
  --radius-md: 0.375rem;   /* 6px */
  --radius-lg: 0.5rem;     /* 8px */
  --radius-xl: 0.75rem;    /* 12px */
  --radius-2xl: 1rem;      /* 16px */
  --radius-full: 9999px;   /* Pills/circles */

  /* Border Widths */
  --border-1: 1px;
  --border-2: 2px;
  --border-4: 4px;
}
```

**Usage:**
```css
.button {
  border-radius: var(--radius-md);
  border: var(--border-1) solid var(--color-border);
}

.avatar {
  border-radius: var(--radius-full);
}
```

### 6. Z-Index Tokens

```css
:root {
  /* Layer Management */
  --z-dropdown: 1000;
  --z-sticky: 1020;
  --z-fixed: 1030;
  --z-modal-backdrop: 1040;
  --z-modal: 1050;
  --z-popover: 1060;
  --z-tooltip: 1070;
}
```

**Usage:**
```css
.modal-backdrop {
  z-index: var(--z-modal-backdrop);
}

.modal {
  z-index: var(--z-modal);
}
```

### 7. Animation/Transition Tokens

```css
:root {
  /* Duration */
  --duration-instant: 0ms;
  --duration-fast: 150ms;
  --duration-base: 250ms;
  --duration-slow: 350ms;
  --duration-slower: 500ms;

  /* Easing */
  --ease-linear: linear;
  --ease-in: cubic-bezier(0.4, 0, 1, 1);
  --ease-out: cubic-bezier(0, 0, 0.2, 1);
  --ease-in-out: cubic-bezier(0.4, 0, 0.2, 1);
  --ease-bounce: cubic-bezier(0.68, -0.55, 0.265, 1.55);
}
```

**Usage:**
```css
.button {
  transition: all var(--duration-base) var(--ease-out);
}

.modal {
  animation: slideIn var(--duration-slow) var(--ease-out);
}
```

## Semantic vs Reference Tokens

### Reference Tokens (Raw Values)
```css
:root {
  --blue-500: #0066FF;
  --gray-100: #F3F4F6;
  --spacing-4: 1rem;
}
```

### Semantic Tokens (Meaningful Names)
```css
:root {
  --color-primary: var(--blue-500);
  --color-surface: var(--gray-100);
  --button-padding: var(--spacing-4);
}
```

**Always use semantic tokens in components:**
```css
/* ❌ Don't */
.button {
  background: var(--blue-500);
  padding: var(--spacing-4);
}

/* ✅ Do */
.button {
  background: var(--color-primary);
  padding: var(--button-padding);
}
```

## Theming with Tokens

### Light/Dark Mode

```css
:root {
  /* Light theme (default) */
  --color-surface: #FFFFFF;
  --color-text: #111827;
  --color-border: #E5E7EB;
}

@media (prefers-color-scheme: dark) {
  :root {
    --color-surface: #1F2937;
    --color-text: #F9FAFB;
    --color-border: #4B5563;
  }
}

/* Or class-based theming */
[data-theme="dark"] {
  --color-surface: #1F2937;
  --color-text: #F9FAFB;
  --color-border: #4B5563;
}
```

### Brand Theming

```css
:root {
  --color-primary: var(--brand-blue);
}

[data-brand="tech"] {
  --brand-blue: #0066FF;
}

[data-brand="health"] {
  --brand-blue: #10B981;
}

[data-brand="finance"] {
  --brand-blue: #6366F1;
}
```

## Component-Specific Tokens

```css
:root {
  /* Button */
  --button-padding-sm: var(--space-2) var(--space-3);
  --button-padding-md: var(--space-3) var(--space-4);
  --button-padding-lg: var(--space-4) var(--space-6);
  --button-radius: var(--radius-md);
  --button-font-weight: var(--font-medium);

  /* Input */
  --input-height-sm: 36px;
  --input-height-md: 44px;
  --input-height-lg: 52px;
  --input-border-color: var(--color-border);
  --input-focus-color: var(--color-primary);

  /* Card */
  --card-padding: var(--space-6);
  --card-radius: var(--radius-lg);
  --card-shadow: var(--shadow-md);
}
```

## Platform-Specific Tokens

### CSS Custom Properties (Web)
```css
:root {
  --color-primary: #0066FF;
}

.button {
  background: var(--color-primary);
}
```

### JSON (React Native, iOS, Android)
```json
{
  "color": {
    "primary": "#0066FF",
    "surface": "#FFFFFF",
    "text": "#111827"
  },
  "spacing": {
    "4": 16,
    "6": 24,
    "8": 32
  }
}
```

### JavaScript/TypeScript
```typescript
export const tokens = {
  color: {
    primary: '#0066FF',
    surface: '#FFFFFF',
    text: '#111827',
  },
  spacing: {
    4: '1rem',
    6: '1.5rem',
    8: '2rem',
  },
} as const;

// Usage
const Button = styled.button`
  background: ${tokens.color.primary};
  padding: ${tokens.spacing.4};
`;
```

## Best Practices

### Naming Conventions

**Do:**
- Use descriptive, semantic names
- Follow consistent patterns
- Group related tokens

```css
/* ✅ Good */
--color-primary
--color-primary-hover
--color-primary-subtle
--button-padding-md
--shadow-card
```

**Don't:**
- Use arbitrary or cryptic names
- Mix naming conventions
- Use values in names

```css
/* ❌ Bad */
--blue
--primary-color-hover-state
--padding16px
--btn-pad
```

### Organization

Group tokens by category:
```
tokens/
├── colors.css
├── typography.css
├── spacing.css
├── shadows.css
├── borders.css
├── zindex.css
└── index.css (imports all)
```

### Documentation

Document token usage:
```css
/**
 * Primary brand color
 * Used for: primary buttons, links, focus states
 * Contrast ratio: 4.6:1 (WCAG AA compliant)
 */
--color-primary: #0066FF;
```

### Accessibility

Ensure proper contrast:
```css
:root {
  --color-primary: #0066FF;
  --color-text-on-primary: #FFFFFF;
  /* Contrast ratio: 4.5:1 ✅ */
}
```

### Performance

Use CSS variables efficiently:
```css
/* ✅ Define once, use everywhere */
:root {
  --color-primary: #0066FF;
}

/* ❌ Don't redefine in every selector */
.button { --color-primary: #0066FF; }
.link { --color-primary: #0066FF; }
```

## Migration Strategy

### Step 1: Audit Current Values
```bash
# Find all color values
grep -r "#[0-9A-Fa-f]\{6\}" src/

# Find all spacing values
grep -r "padding:\|margin:" src/
```

### Step 2: Create Token Definitions
```css
:root {
  /* Extract unique values */
  --color-primary: #0066FF;
  --space-4: 1rem;
}
```

### Step 3: Replace Hard-Coded Values
```css
/* Before */
.button {
  background: #0066FF;
  padding: 1rem;
}

/* After */
.button {
  background: var(--color-primary);
  padding: var(--space-4);
}
```

### Step 4: Test & Validate
- Visual regression testing
- Accessibility testing
- Cross-browser testing
- Dark mode verification

## Tools

**Design Token Tools:**
- Style Dictionary (transforms tokens to multiple formats)
- Theo (Salesforce's token transformer)
- Design Tokens CLI

**Browser DevTools:**
- Chrome: Inspect computed custom properties
- Firefox: CSS Variables viewer

**Example Script:**
```javascript
// Extract all CSS custom properties
const properties = Array.from(document.styleSheets)
  .flatMap(sheet => Array.from(sheet.cssRules))
  .filter(rule => rule.style)
  .flatMap(rule => Array.from(rule.style))
  .filter(prop => prop.startsWith('--'));

console.log([...new Set(properties)]);
```

## Resources

- [Design Tokens W3C Spec](https://design-tokens.github.io/community-group/format/)
- [Style Dictionary](https://amzn.github.io/style-dictionary/)
- [Design Tokens in Figma](https://www.figma.com/community/plugin/888356646278934516/Design-Tokens)

---

**"Design tokens are the translation layer between design decisions and code."**
