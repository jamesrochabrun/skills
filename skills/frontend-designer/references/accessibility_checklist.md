# WCAG 2.1 AA Accessibility Checklist

Comprehensive checklist for ensuring your frontend meets WCAG 2.1 Level AA compliance.

## Perceivable

Information and user interface components must be presentable to users in ways they can perceive.

### 1.1 Text Alternatives

**1.1.1 Non-text Content (Level A)**
- [ ] All images have appropriate alt text
- [ ] Decorative images use empty alt (`alt=""`)
- [ ] Complex images have detailed descriptions
- [ ] Icons have text alternatives or aria-label
- [ ] Charts/graphs have text descriptions
- [ ] CAPTCHAs have alternative forms

```html
<!-- Good examples -->
<img src="logo.png" alt="Company Name">
<img src="decorative.png" alt="" role="presentation">
<button aria-label="Close dialog"><span aria-hidden="true">×</span></button>
```

### 1.2 Time-based Media

**1.2.1 Audio-only and Video-only (Level A)**
- [ ] Audio-only content has transcripts
- [ ] Video-only content has transcripts or audio description

**1.2.2 Captions (Level A)**
- [ ] All pre-recorded videos have captions
- [ ] Captions are synchronized and accurate

**1.2.3 Audio Description or Media Alternative (Level A)**
- [ ] Videos have audio descriptions or text alternative

**1.2.4 Captions (Live) (Level AA)**
- [ ] Live videos have captions

**1.2.5 Audio Description (Level AA)**
- [ ] All pre-recorded videos have audio descriptions

```html
<video controls>
  <source src="video.mp4" type="video/mp4">
  <track kind="captions" src="captions.vtt" srclang="en" label="English">
  <track kind="descriptions" src="descriptions.vtt" srclang="en" label="English descriptions">
</video>
```

### 1.3 Adaptable

**1.3.1 Info and Relationships (Level A)**
- [ ] Semantic HTML used correctly (headings, lists, tables)
- [ ] Form labels properly associated with inputs
- [ ] Related form controls are grouped
- [ ] Visual presentation matches code structure
- [ ] ARIA roles used when needed

```html
<!-- Semantic structure -->
<main>
  <h1>Main Heading</h1>
  <section>
    <h2>Section Heading</h2>
    <p>Content</p>
  </section>
</main>

<!-- Proper form labels -->
<label for="email">Email address</label>
<input type="email" id="email" name="email">

<!-- Grouped controls -->
<fieldset>
  <legend>Contact preferences</legend>
  <label><input type="checkbox" name="email"> Email</label>
  <label><input type="checkbox" name="phone"> Phone</label>
</fieldset>
```

**1.3.2 Meaningful Sequence (Level A)**
- [ ] Reading order is logical
- [ ] Tab order follows visual flow
- [ ] CSS positioning doesn't disrupt reading order

**1.3.3 Sensory Characteristics (Level A)**
- [ ] Instructions don't rely solely on shape
- [ ] Instructions don't rely solely on size
- [ ] Instructions don't rely solely on location
- [ ] Instructions don't rely solely on sound

```html
<!-- ❌ Bad -->
<p>Click the blue button on the right</p>

<!-- ✅ Good -->
<p>Click the "Submit" button to continue</p>
```

**1.3.4 Orientation (Level AA)**
- [ ] Content works in portrait and landscape
- [ ] No orientation restrictions unless essential

**1.3.5 Identify Input Purpose (Level AA)**
- [ ] Input fields use autocomplete attribute when appropriate

```html
<input type="email" name="email" autocomplete="email">
<input type="tel" name="phone" autocomplete="tel">
<input type="text" name="address" autocomplete="street-address">
```

### 1.4 Distinguishable

**1.4.1 Use of Color (Level A)**
- [ ] Color not used as only visual means of conveying information
- [ ] Color not used as only way to distinguish interactive elements
- [ ] Links are distinguishable without color alone

```css
/* ✅ Good - underline + color */
a {
  color: blue;
  text-decoration: underline;
}

/* Or use icons, borders, etc. */
.error {
  color: red;
  border-left: 4px solid red;
  padding-left: 12px;
}
.error::before {
  content: "⚠ ";
}
```

**1.4.2 Audio Control (Level A)**
- [ ] Auto-playing audio can be paused
- [ ] Auto-playing audio stops after 3 seconds
- [ ] Volume controls available

**1.4.3 Contrast (Minimum) (Level AA)**
- [ ] Normal text: 4.5:1 contrast ratio
- [ ] Large text (18pt+): 3:1 contrast ratio
- [ ] UI components: 3:1 contrast ratio
- [ ] Graphical objects: 3:1 contrast ratio

```css
/* Check with contrast checkers */
.text {
  color: #595959; /* 7:1 on white ✅ */
  background: #FFFFFF;
}

.button {
  color: #FFFFFF;
  background: #0066FF; /* 4.6:1 ✅ */
  border: 2px solid #0052CC; /* 3:1 ✅ */
}
```

**1.4.4 Resize Text (Level AA)**
- [ ] Text can be resized to 200% without loss of content
- [ ] No horizontal scrolling at 200% zoom
- [ ] Use relative units (rem, em)

```css
/* ✅ Good */
body {
  font-size: 1rem; /* Respects user preferences */
}

h1 {
  font-size: 2.5rem; /* Scales with body */
}

/* ❌ Avoid */
.text {
  font-size: 14px; /* Fixed size */
}
```

**1.4.5 Images of Text (Level AA)**
- [ ] Text is text, not images
- [ ] Exception: logos, essential presentations

**1.4.10 Reflow (Level AA)**
- [ ] Content reflows at 320px viewport width
- [ ] No horizontal scrolling (except tables, diagrams)
- [ ] Responsive design implemented

```css
/* Mobile-first responsive */
.container {
  width: 100%;
  max-width: 1200px;
  padding: 1rem;
}

@media (min-width: 768px) {
  .container {
    padding: 2rem;
  }
}
```

**1.4.11 Non-text Contrast (Level AA)**
- [ ] UI components: 3:1 contrast against background
- [ ] Graphical objects: 3:1 contrast
- [ ] Focus indicators: 3:1 contrast

**1.4.12 Text Spacing (Level AA)**
- [ ] Content adapts to increased text spacing
- [ ] Line height: at least 1.5x font size
- [ ] Paragraph spacing: at least 2x font size
- [ ] Letter spacing: at least 0.12x font size
- [ ] Word spacing: at least 0.16x font size

```css
/* Ensure content doesn't break */
body {
  line-height: 1.5;
}

p {
  margin-bottom: 2em;
}
```

**1.4.13 Content on Hover or Focus (Level AA)**
- [ ] Additional content (tooltips, dropdowns) is dismissible
- [ ] Hoverable content stays visible when hovering over it
- [ ] Content remains visible until dismissed or no longer relevant

```css
/* Tooltip stays visible when hovering over it */
.tooltip:hover .tooltip-content,
.tooltip .tooltip-content:hover {
  display: block;
}
```

## Operable

User interface components and navigation must be operable.

### 2.1 Keyboard Accessible

**2.1.1 Keyboard (Level A)**
- [ ] All functionality available via keyboard
- [ ] No keyboard traps
- [ ] Logical tab order
- [ ] Custom controls are keyboard accessible

```html
<!-- Custom button needs tabindex and keyboard handlers -->
<div role="button" tabindex="0"
     onclick="handleClick()"
     onkeydown="if(event.key==='Enter'||event.key===' ') handleClick()">
  Click me
</div>
```

**2.1.2 No Keyboard Trap (Level A)**
- [ ] Focus can move away from all components
- [ ] Instructions provided if non-standard exit method

**2.1.4 Character Key Shortcuts (Level A)**
- [ ] Single-key shortcuts can be turned off
- [ ] Or remapped by user
- [ ] Or only active when component has focus

### 2.2 Enough Time

**2.2.1 Timing Adjustable (Level A)**
- [ ] Time limits can be turned off, adjusted, or extended
- [ ] User warned before time expires
- [ ] At least 20 seconds to extend

**2.2.2 Pause, Stop, Hide (Level A)**
- [ ] Moving content can be paused
- [ ] Auto-updating content can be paused/stopped
- [ ] Blinking content can be stopped

```html
<!-- Provide controls -->
<div class="carousel">
  <button aria-label="Pause carousel">⏸</button>
  <button aria-label="Play carousel">▶</button>
</div>
```

### 2.3 Seizures and Physical Reactions

**2.3.1 Three Flashes or Below Threshold (Level A)**
- [ ] No content flashes more than 3 times per second
- [ ] Or flashes are below general flash/red flash thresholds

### 2.4 Navigable

**2.4.1 Bypass Blocks (Level A)**
- [ ] Skip navigation link provided
- [ ] Landmark regions defined
- [ ] Headings structure content

```html
<!-- Skip link (visually hidden until focused) -->
<a href="#main" class="skip-link">Skip to main content</a>

<header>
  <nav aria-label="Main navigation">...</nav>
</header>

<main id="main">
  <h1>Page Title</h1>
</main>
```

```css
.skip-link {
  position: absolute;
  top: -40px;
  left: 0;
  background: #000;
  color: #fff;
  padding: 8px;
  z-index: 100;
}

.skip-link:focus {
  top: 0;
}
```

**2.4.2 Page Titled (Level A)**
- [ ] Page has descriptive title
- [ ] Title identifies page content

```html
<title>Contact Us - Company Name</title>
```

**2.4.3 Focus Order (Level A)**
- [ ] Focus order is logical and intuitive
- [ ] Matches visual order
- [ ] No positive tabindex values

```css
/* ❌ Avoid */
.element { tabindex: 5; }

/* ✅ Use */
.element { tabindex: 0; }  /* In natural order */
.element { tabindex: -1; } /* Programmatic focus only */
```

**2.4.4 Link Purpose (Level A)**
- [ ] Link text describes destination
- [ ] Context is clear
- [ ] Avoid "click here" or "read more"

```html
<!-- ❌ Bad -->
<a href="/report.pdf">Click here</a>

<!-- ✅ Good -->
<a href="/report.pdf">Download 2024 Annual Report (PDF, 2MB)</a>
```

**2.4.5 Multiple Ways (Level AA)**
- [ ] Multiple ways to find pages (menu, search, sitemap)
- [ ] Exception: pages that are steps in a process

**2.4.6 Headings and Labels (Level AA)**
- [ ] Headings describe content
- [ ] Labels describe purpose
- [ ] Headings and labels are clear

**2.4.7 Focus Visible (Level AA)**
- [ ] Keyboard focus indicator is visible
- [ ] Sufficient contrast (3:1)
- [ ] Clearly indicates focused element

```css
/* ✅ Strong focus indicator */
*:focus-visible {
  outline: 2px solid #0066FF;
  outline-offset: 2px;
}

/* Or custom focus styles */
button:focus-visible {
  box-shadow: 0 0 0 3px rgba(0, 102, 255, 0.5);
}
```

### 2.5 Input Modalities

**2.5.1 Pointer Gestures (Level A)**
- [ ] Complex gestures have single-pointer alternative
- [ ] Path-based gestures have simple alternative

**2.5.2 Pointer Cancellation (Level A)**
- [ ] Actions triggered on up-event (not down)
- [ ] Or can be aborted/undone

**2.5.3 Label in Name (Level A)**
- [ ] Visible label matches accessible name
- [ ] Accessible name starts with visible text

```html
<!-- ✅ Good - matches -->
<button aria-label="Submit form">Submit</button>

<!-- ❌ Bad - doesn't match -->
<button aria-label="Send">Submit</button>
```

**2.5.4 Motion Actuation (Level A)**
- [ ] Device motion triggers have UI alternative
- [ ] Can disable motion actuation

## Understandable

Information and user interface operation must be understandable.

### 3.1 Readable

**3.1.1 Language of Page (Level A)**
- [ ] Page language is identified

```html
<html lang="en">
```

**3.1.2 Language of Parts (Level AA)**
- [ ] Language changes are marked

```html
<p>The French phrase <span lang="fr">c'est la vie</span> means "that's life".</p>
```

### 3.2 Predictable

**3.2.1 On Focus (Level A)**
- [ ] Focusing an element doesn't trigger context change
- [ ] No automatic form submission on focus

**3.2.2 On Input (Level A)**
- [ ] Changing settings doesn't automatically cause context change
- [ ] User is warned of automatic changes

**3.2.3 Consistent Navigation (Level AA)**
- [ ] Navigation order is consistent across pages
- [ ] Repeated navigation in same order

**3.2.4 Consistent Identification (Level AA)**
- [ ] Components with same functionality are identified consistently
- [ ] Icons mean the same thing throughout

### 3.3 Input Assistance

**3.3.1 Error Identification (Level A)**
- [ ] Errors are identified in text
- [ ] Error is described to user

```html
<input type="email" aria-invalid="true" aria-describedby="email-error">
<span id="email-error" role="alert">Please enter a valid email address</span>
```

**3.3.2 Labels or Instructions (Level A)**
- [ ] Labels provided for input
- [ ] Instructions provided when needed

```html
<label for="password">
  Password (must be at least 8 characters)
</label>
<input type="password" id="password" required minlength="8">
```

**3.3.3 Error Suggestion (Level AA)**
- [ ] Errors suggest how to fix
- [ ] Specific, actionable feedback

```html
<span role="alert">
  Password must contain at least one uppercase letter,
  one number, and be at least 8 characters long.
</span>
```

**3.3.4 Error Prevention (Level AA)**
- [ ] Legal/financial transactions are reversible
- [ ] Data is checked and confirmed before submission
- [ ] User can review and correct before submitting

```html
<!-- Confirmation step -->
<div role="region" aria-labelledby="review-heading">
  <h2 id="review-heading">Review Your Order</h2>
  <!-- Show all details -->
  <button>Edit Order</button>
  <button>Confirm Purchase</button>
</div>
```

## Robust

Content must be robust enough to be interpreted by a wide variety of user agents, including assistive technologies.

### 4.1 Compatible

**4.1.1 Parsing (Level A)** *[Obsolete in WCAG 2.2]*
- [ ] Valid HTML (no duplicate IDs, proper nesting)

**4.1.2 Name, Role, Value (Level A)**
- [ ] All UI components have accessible name
- [ ] Roles are appropriate
- [ ] States communicated to assistive tech

```html
<!-- Custom checkbox -->
<div role="checkbox"
     aria-checked="false"
     aria-labelledby="label-id"
     tabindex="0">
</div>
<span id="label-id">Accept terms</span>

<!-- Button states -->
<button aria-pressed="false" aria-label="Mute">🔊</button>
<button aria-pressed="true" aria-label="Mute">🔇</button>
```

**4.1.3 Status Messages (Level AA)**
- [ ] Status messages can be perceived by assistive tech
- [ ] Use aria-live, role="status", role="alert"

```html
<!-- Success message -->
<div role="status" aria-live="polite">
  Form submitted successfully!
</div>

<!-- Error message -->
<div role="alert" aria-live="assertive">
  Error: Connection lost. Please try again.
</div>

<!-- Loading state -->
<div aria-live="polite" aria-busy="true">
  Loading content...
</div>
```

## Testing Checklist

### Automated Testing
- [ ] Run axe DevTools
- [ ] Run Lighthouse accessibility audit
- [ ] Run WAVE browser extension
- [ ] HTML validator (W3C)
- [ ] Color contrast checker

### Manual Testing
- [ ] Keyboard-only navigation
- [ ] Screen reader testing (NVDA, JAWS, VoiceOver)
- [ ] Zoom to 200% (text resize)
- [ ] Test with browser zoom (page zoom)
- [ ] Test in high contrast mode
- [ ] Test with dark mode
- [ ] Test responsive breakpoints

### Screen Reader Testing
- [ ] NVDA (Windows, free)
- [ ] JAWS (Windows, paid)
- [ ] VoiceOver (Mac/iOS, built-in)
- [ ] TalkBack (Android, built-in)
- [ ] ORCA (Linux, free)

### Browser Testing
- [ ] Chrome + screen reader
- [ ] Firefox + screen reader
- [ ] Safari + VoiceOver
- [ ] Edge + screen reader

## Quick Reference

### Critical Items (Must Fix)
1. ✅ Images have alt text
2. ✅ Form inputs have labels
3. ✅ Sufficient color contrast (4.5:1 text, 3:1 UI)
4. ✅ Keyboard accessible (all functionality)
5. ✅ Focus indicators visible
6. ✅ No keyboard traps
7. ✅ Semantic HTML (headings, landmarks)
8. ✅ ARIA used correctly
9. ✅ Page has title
10. ✅ Language identified

### Tools
- [axe DevTools](https://www.deque.com/axe/devtools/)
- [Lighthouse](https://developers.google.com/web/tools/lighthouse)
- [WAVE](https://wave.webaim.org/)
- [Color Contrast Analyzer](https://www.tpgi.com/color-contrast-checker/)
- [NVDA Screen Reader](https://www.nvaccess.org/)

### Resources
- [WCAG 2.1 Quick Reference](https://www.w3.org/WAI/WCAG21/quickref/)
- [WebAIM](https://webaim.org/)
- [The A11Y Project](https://www.a11yproject.com/)
- [MDN Accessibility](https://developer.mozilla.org/en-US/docs/Web/Accessibility)

---

**"Accessibility is not a feature, it's a fundamental right."**
