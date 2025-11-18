# Responsive Design Patterns

Modern responsive design patterns and techniques for creating flexible, accessible layouts that work across all devices.

## Mobile-First Approach

Start with mobile design and enhance for larger screens.

### Why Mobile-First?

**Benefits:**
- Forces focus on essential content
- Better performance (smaller base CSS)
- Progressive enhancement mindset
- Easier to add features than remove them

**Basic Pattern:**
```css
/* Base (mobile) styles - no media query */
.container {
  width: 100%;
  padding: 1rem;
}

/* Tablet and up */
@media (min-width: 768px) {
  .container {
    padding: 2rem;
  }
}

/* Desktop and up */
@media (min-width: 1024px) {
  .container {
    max-width: 1200px;
    margin: 0 auto;
    padding: 3rem;
  }
}
```

## Breakpoints

### Standard Breakpoints

```css
:root {
  /* Mobile first - these are MIN widths */
  --breakpoint-sm: 640px;   /* Small tablets, large phones */
  --breakpoint-md: 768px;   /* Tablets */
  --breakpoint-lg: 1024px;  /* Laptops, desktops */
  --breakpoint-xl: 1280px;  /* Large desktops */
  --breakpoint-2xl: 1536px; /* Extra large screens */
}

/* Usage */
@media (min-width: 768px) {
  /* Tablet and up */
}

@media (min-width: 1024px) {
  /* Desktop and up */
}
```

### Custom Breakpoints

```css
/* Content-based breakpoints */
@media (min-width: 400px) {
  /* When content needs it, not arbitrary device size */
}

/* Prefer rem-based breakpoints for accessibility */
@media (min-width: 48rem) { /* 768px at 16px base */
  /* Scales with user's font size preferences */
}
```

### Container Queries (Modern)

```css
/* Respond to container size, not viewport */
.card-container {
  container-type: inline-size;
  container-name: card;
}

@container card (min-width: 400px) {
  .card {
    display: grid;
    grid-template-columns: 200px 1fr;
  }
}
```

## Responsive Typography

### Fluid Typography

```css
/* Scales smoothly between min and max */
h1 {
  font-size: clamp(2rem, 5vw + 1rem, 4rem);
  /* Min: 2rem (32px) */
  /* Preferred: 5vw + 1rem */
  /* Max: 4rem (64px) */
}

/* More examples */
.text-sm {
  font-size: clamp(0.875rem, 0.85rem + 0.125vw, 1rem);
}

.text-base {
  font-size: clamp(1rem, 0.95rem + 0.25vw, 1.125rem);
}

.text-lg {
  font-size: clamp(1.125rem, 1.05rem + 0.375vw, 1.25rem);
}
```

### Responsive Line Height

```css
body {
  /* Tighter on mobile, looser on desktop */
  line-height: 1.5;
}

@media (min-width: 768px) {
  body {
    line-height: 1.6;
  }
}
```

## Layout Patterns

### 1. Stack Layout

**Everything stacks vertically on mobile, side-by-side on larger screens.**

```css
.stack {
  display: flex;
  flex-direction: column;
  gap: 1rem;
}

@media (min-width: 768px) {
  .stack {
    flex-direction: row;
  }
}
```

### 2. Sidebar Layout

**Sidebar stacks on mobile, side-by-side on desktop.**

```css
.sidebar-layout {
  display: grid;
  gap: 2rem;
}

@media (min-width: 768px) {
  .sidebar-layout {
    grid-template-columns: 250px 1fr;
  }
}

/* Flexible sidebar */
@media (min-width: 768px) {
  .sidebar-layout--flexible {
    grid-template-columns: minmax(200px, 300px) 1fr;
  }
}
```

### 3. Grid Layout

**Responsive column count.**

```css
.grid {
  display: grid;
  gap: 1rem;

  /* Mobile: 1 column */
  grid-template-columns: 1fr;
}

@media (min-width: 640px) {
  .grid {
    /* Tablet: 2 columns */
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (min-width: 1024px) {
  .grid {
    /* Desktop: 3-4 columns */
    grid-template-columns: repeat(4, 1fr);
  }
}

/* Auto-responsive grid (no media queries!) */
.grid-auto {
  display: grid;
  gap: 1rem;
  grid-template-columns: repeat(auto-fit, minmax(250px, 1fr));
  /* Creates as many columns as fit, minimum 250px each */
}
```

### 4. Holy Grail Layout

**Classic three-column layout that adapts to mobile.**

```css
.holy-grail {
  display: grid;
  gap: 1rem;
  min-height: 100vh;

  /* Mobile: stack everything */
  grid-template:
    "header" auto
    "main" 1fr
    "sidebar1" auto
    "sidebar2" auto
    "footer" auto
    / 1fr;
}

@media (min-width: 768px) {
  .holy-grail {
    /* Desktop: traditional layout */
    grid-template:
      "header header header" auto
      "sidebar1 main sidebar2" 1fr
      "footer footer footer" auto
      / 200px 1fr 200px;
  }
}

.header { grid-area: header; }
.sidebar-1 { grid-area: sidebar1; }
.main { grid-area: main; }
.sidebar-2 { grid-area: sidebar2; }
.footer { grid-area: footer; }
```

### 5. Card Layout

**Responsive cards that adapt their internal layout.**

```css
.card {
  display: grid;
  gap: 1rem;

  /* Mobile: stack image and content */
  grid-template:
    "image" auto
    "content" 1fr
    / 1fr;
}

@media (min-width: 640px) {
  .card {
    /* Tablet+: side-by-side */
    grid-template:
      "image content" 1fr
      / 200px 1fr;
  }
}

.card__image { grid-area: image; }
.card__content { grid-area: content; }
```

### 6. Switcher Pattern

**Switch between horizontal and vertical based on available space.**

```css
.switcher {
  display: flex;
  flex-wrap: wrap;
  gap: 1rem;
}

.switcher > * {
  /* Grow to fill, but switch to vertical when < 400px */
  flex-grow: 1;
  flex-basis: calc((400px - 100%) * 999);
  /* Clever calc that breaks at threshold */
}
```

### 7. Pancake Stack

**Header, main, footer layout that adapts height.**

```css
.pancake {
  display: grid;
  grid-template-rows: auto 1fr auto;
  min-height: 100vh;
}

.header { /* auto height */ }
.main { /* fills available space */ }
.footer { /* auto height */ }
```

## Responsive Images

### 1. Flexible Images

```css
img {
  max-width: 100%;
  height: auto;
  display: block;
}
```

### 2. Art Direction (Different Images per Breakpoint)

```html
<picture>
  <source media="(min-width: 1024px)" srcset="large.jpg">
  <source media="(min-width: 768px)" srcset="medium.jpg">
  <img src="small.jpg" alt="Description">
</picture>
```

### 3. Resolution Switching (Same Image, Different Sizes)

```html
<img
  srcset="
    small.jpg 400w,
    medium.jpg 800w,
    large.jpg 1200w
  "
  sizes="
    (min-width: 1024px) 800px,
    (min-width: 768px) 600px,
    100vw
  "
  src="medium.jpg"
  alt="Description"
>
```

### 4. Background Images

```css
.hero {
  background-image: url('small.jpg');
  background-size: cover;
  background-position: center;
}

@media (min-width: 768px) {
  .hero {
    background-image: url('medium.jpg');
  }
}

@media (min-width: 1024px) {
  .hero {
    background-image: url('large.jpg');
  }
}

@media (min-width: 1024px) and (-webkit-min-device-pixel-ratio: 2) {
  .hero {
    background-image: url('large@2x.jpg');
  }
}
```

### 5. Aspect Ratio

```css
/* Modern aspect ratio */
.image-container {
  aspect-ratio: 16 / 9;
  overflow: hidden;
}

.image-container img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

/* Fallback for older browsers */
.image-container-fallback {
  position: relative;
  padding-bottom: 56.25%; /* 16:9 aspect ratio */
}

.image-container-fallback img {
  position: absolute;
  top: 0;
  left: 0;
  width: 100%;
  height: 100%;
  object-fit: cover;
}
```

## Responsive Navigation

### 1. Mobile Menu (Hamburger)

```html
<nav class="nav">
  <div class="nav__brand">Logo</div>

  <button class="nav__toggle" aria-expanded="false" aria-controls="nav-menu">
    <span class="sr-only">Menu</span>
    <span class="hamburger"></span>
  </button>

  <ul class="nav__menu" id="nav-menu">
    <li><a href="/">Home</a></li>
    <li><a href="/about">About</a></li>
    <li><a href="/contact">Contact</a></li>
  </ul>
</nav>
```

```css
.nav {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 1rem;
}

/* Mobile: hidden menu */
.nav__menu {
  display: none;
  position: absolute;
  top: 100%;
  left: 0;
  right: 0;
  background: white;
  flex-direction: column;
  padding: 1rem;
}

.nav__menu[aria-expanded="true"] {
  display: flex;
}

.nav__toggle {
  display: block;
}

/* Desktop: visible menu */
@media (min-width: 768px) {
  .nav__menu {
    display: flex;
    position: static;
    flex-direction: row;
    gap: 2rem;
  }

  .nav__toggle {
    display: none;
  }
}
```

### 2. Priority+ Navigation

**Show important items, collapse others into "More" menu.**

```css
.priority-nav {
  display: flex;
  gap: 1rem;
}

.priority-nav__item {
  flex-shrink: 0; /* Don't shrink */
}

.priority-nav__more {
  margin-left: auto; /* Push to end */
}

/* Hide items that don't fit */
@media (max-width: 768px) {
  .priority-nav__item:nth-child(n+4) {
    display: none; /* Hide items 4+ */
  }
}
```

## Responsive Tables

### 1. Horizontal Scroll

```css
.table-container {
  overflow-x: auto;
  -webkit-overflow-scrolling: touch; /* Smooth scrolling on iOS */
}

table {
  min-width: 600px;
  width: 100%;
}
```

### 2. Stacked Table (Card View)

```html
<table class="responsive-table">
  <thead>
    <tr>
      <th>Name</th>
      <th>Email</th>
      <th>Role</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <td data-label="Name">John Doe</td>
      <td data-label="Email">john@example.com</td>
      <td data-label="Role">Developer</td>
    </tr>
  </tbody>
</table>
```

```css
/* Desktop: normal table */
@media (min-width: 768px) {
  .responsive-table {
    display: table;
  }
}

/* Mobile: stacked cards */
@media (max-width: 767px) {
  .responsive-table,
  .responsive-table thead,
  .responsive-table tbody,
  .responsive-table tr,
  .responsive-table th,
  .responsive-table td {
    display: block;
  }

  .responsive-table thead {
    display: none; /* Hide table header */
  }

  .responsive-table tr {
    margin-bottom: 1rem;
    border: 1px solid #ddd;
    border-radius: 0.5rem;
    padding: 1rem;
  }

  .responsive-table td {
    display: flex;
    justify-content: space-between;
    padding: 0.5rem 0;
    border-bottom: 1px solid #eee;
  }

  .responsive-table td:last-child {
    border-bottom: none;
  }

  .responsive-table td::before {
    content: attr(data-label);
    font-weight: bold;
    margin-right: 1rem;
  }
}
```

## Responsive Forms

### 1. Single Column to Multi-Column

```css
.form {
  display: grid;
  gap: 1rem;

  /* Mobile: single column */
  grid-template-columns: 1fr;
}

@media (min-width: 768px) {
  .form {
    /* Desktop: two columns */
    grid-template-columns: repeat(2, 1fr);
  }

  .form__field--full {
    /* Some fields span both columns */
    grid-column: 1 / -1;
  }
}
```

### 2. Touch-Friendly Inputs

```css
input,
button,
select,
textarea {
  /* Minimum 44x44px touch target */
  min-height: 44px;
  padding: 0.75rem 1rem;
  font-size: 1rem; /* Prevents zoom on iOS */
}

@media (min-width: 768px) {
  input,
  button,
  select,
  textarea {
    /* Can be smaller on desktop */
    min-height: 40px;
    font-size: 0.875rem;
  }
}
```

## Responsive Utilities

### Show/Hide at Breakpoints

```css
/* Hide on mobile */
.hidden-mobile {
  display: none;
}

@media (min-width: 768px) {
  .hidden-mobile {
    display: block;
  }
}

/* Show only on mobile */
.visible-mobile {
  display: block;
}

@media (min-width: 768px) {
  .visible-mobile {
    display: none;
  }
}

/* Hide on desktop */
@media (min-width: 1024px) {
  .hidden-desktop {
    display: none;
  }
}
```

### Responsive Spacing

```css
.section {
  /* Mobile: smaller padding */
  padding: 2rem 1rem;
}

@media (min-width: 768px) {
  .section {
    /* Tablet: medium padding */
    padding: 4rem 2rem;
  }
}

@media (min-width: 1024px) {
  .section {
    /* Desktop: larger padding */
    padding: 6rem 3rem;
  }
}

/* Or use fluid spacing */
.section-fluid {
  padding: clamp(2rem, 5vw, 6rem) clamp(1rem, 3vw, 3rem);
}
```

## Testing Responsive Design

### Browser DevTools

```javascript
// Common viewport sizes to test
const viewports = [
  { width: 375, height: 667, name: 'iPhone SE' },
  { width: 390, height: 844, name: 'iPhone 12 Pro' },
  { width: 428, height: 926, name: 'iPhone 14 Pro Max' },
  { width: 768, height: 1024, name: 'iPad' },
  { width: 1024, height: 768, name: 'iPad Landscape' },
  { width: 1280, height: 720, name: 'Desktop' },
  { width: 1920, height: 1080, name: 'Full HD' },
];
```

### Responsive Testing Checklist

- [ ] Test all breakpoints
- [ ] Test between breakpoints (awkward sizes)
- [ ] Test portrait and landscape
- [ ] Test zoom levels (100%, 200%, 400%)
- [ ] Test with real devices when possible
- [ ] Test touch interactions on mobile
- [ ] Test with different font sizes
- [ ] Test with slow network (images, fonts)

## Performance Considerations

### Lazy Loading

```html
<!-- Lazy load images below the fold -->
<img src="image.jpg" loading="lazy" alt="Description">

<!-- Eager load above-the-fold images -->
<img src="hero.jpg" loading="eager" alt="Hero image">
```

### Conditional Loading

```javascript
// Load component only on larger screens
if (window.matchMedia('(min-width: 768px)').matches) {
  import('./DesktopComponent.js').then(module => {
    // Initialize desktop component
  });
}
```

### Font Loading

```css
@font-face {
  font-family: 'CustomFont';
  src: url('font.woff2') format('woff2');
  font-display: swap; /* Show fallback while loading */
}
```

## Modern CSS Features

### 1. CSS Grid Auto-Fill

```css
.grid {
  display: grid;
  gap: 1rem;
  grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
  /* Automatically creates columns, minimum 250px */
}
```

### 2. Flexbox Gap

```css
.flex-container {
  display: flex;
  flex-wrap: wrap;
  gap: 1rem; /* No more margin hacks! */
}
```

### 3. Container Queries

```css
.card {
  container-type: inline-size;
}

@container (min-width: 400px) {
  .card__title {
    font-size: 1.5rem;
  }
}
```

### 4. Aspect Ratio

```css
.video-container {
  aspect-ratio: 16 / 9;
}
```

### 5. Logical Properties

```css
/* Better for RTL/LTR support */
.element {
  margin-block-start: 1rem; /* margin-top */
  margin-block-end: 1rem; /* margin-bottom */
  margin-inline-start: 1rem; /* margin-left in LTR, margin-right in RTL */
  margin-inline-end: 1rem; /* margin-right in LTR, margin-left in RTL */
}
```

## Resources

- [MDN: Responsive Design](https://developer.mozilla.org/en-US/docs/Learn/CSS/CSS_layout/Responsive_Design)
- [This is Responsive](https://bradfrost.github.io/this-is-responsive/)
- [Responsive Design Patterns](https://responsivedesign.is/patterns/)
- [CSS-Tricks: Complete Guide to Grid](https://css-tricks.com/snippets/css/complete-guide-grid/)
- [CSS-Tricks: Complete Guide to Flexbox](https://css-tricks.com/snippets/css/a-guide-to-flexbox/)

---

**"The best design is the one that works everywhere, for everyone."**
