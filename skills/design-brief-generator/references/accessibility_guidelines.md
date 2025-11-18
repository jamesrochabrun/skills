# Accessibility Guidelines for Design Briefs

Comprehensive accessibility requirements and best practices for design projects.

---

## Why Accessibility Matters

**Legal:** ADA, Section 508, AODA compliance
**Business:** 15% of the world has a disability - that's your potential users
**Ethical:** Everyone deserves equal access to digital experiences
**Technical:** Accessible design is better design for everyone

---

## WCAG 2.1 Overview

### Compliance Levels

**Level A (Minimum):**
- Basic web accessibility features
- Legal requirement in many jurisdictions
- Addresses most critical barriers

**Level AA (Recommended):**
- Addresses most common barriers
- Gold standard for most organizations
- Required by many laws (EU, Canada, US Section 508)

**Level AAA (Enhanced):**
- Highest level of accessibility
- Not required for general compliance
- Often not feasible for all content

**Recommendation:** Target WCAG 2.1 Level AA for most projects.

---

## Four Principles (POUR)

### 1. Perceivable
Information and UI components must be presentable to users in ways they can perceive.

### 2. Operable
UI components and navigation must be operable by all users.

### 3. Understandable
Information and UI operation must be understandable.

### 4. Robust
Content must be robust enough to work with current and future technologies.

---

## Key Requirements by Category

### Visual Design

#### Color & Contrast
**Requirement:** Minimum contrast ratios
- **Normal text:** 4.5:1 (Level AA) or 7:1 (Level AAA)
- **Large text (18pt+):** 3:1 (Level AA) or 4.5:1 (Level AAA)
- **UI components:** 3:1 for active elements

**Best Practices:**
- Don't rely on color alone to convey information
- Use patterns, icons, or labels in addition to color
- Test in grayscale to verify information hierarchy
- Consider color blindness (8% of males, 0.5% of females)

**Tools:**
- [WebAIM Contrast Checker](https://webaim.org/resources/contrastchecker/)
- [Contrast Ratio](https://contrast-ratio.com/)
- Figma plugins: Stark, A11y - Color Contrast Checker

#### Typography
**Requirements:**
- Text must be resizable up to 200% without loss of content
- Line height at least 1.5x font size
- Paragraph spacing at least 2x font size
- Letter spacing at least 0.12x font size
- Word spacing at least 0.16x font size

**Best Practices:**
- Minimum body text size: 16px
- Use relative units (rem, em) not absolute (px)
- Avoid ALL CAPS for long text
- Left-align text (not justified)
- Break long content into shorter paragraphs
- Use clear, simple language

#### Focus Indicators
**Requirement:** Keyboard focus must be visible

**Best Practices:**
- Focus indicator contrast ratio: 3:1 minimum
- Don't remove default focus styles without replacement
- Use outline or border (not just background color change)
- Maintain focus order that follows visual layout
- Show focus on all interactive elements

---

### Interaction Design

#### Keyboard Navigation
**Requirements:**
- All functionality available via keyboard
- No keyboard traps
- Logical tab order
- Skip links for repetitive content

**Tab Order:**
1. Header navigation
2. Main content
3. Sidebar (if present)
4. Footer

**Keyboard Shortcuts:**
- `Tab` - Move forward through interactive elements
- `Shift + Tab` - Move backward
- `Enter` - Activate buttons/links
- `Space` - Activate buttons, toggle checkboxes
- `Arrow keys` - Navigate within components (menus, radio groups)
- `Esc` - Close modals/menus

**Best Practices:**
- Add "Skip to main content" link
- Ensure modals trap focus appropriately
- Return focus when closing overlays
- Document custom keyboard shortcuts

#### Touch Targets
**Requirements:**
- Minimum touch target size: 44×44px (Level AA)
- Adequate spacing between targets

**Best Practices:**
- 48×48px or larger for important actions
- At least 8px spacing between touch targets
- Enlarge hit areas beyond visible element
- Consider thumb reach zones on mobile

#### Time Limits
**Requirements:**
- Users can extend, adjust, or turn off time limits
- 20-hour minimum for inactive sessions
- Warning before timeout

**Best Practices:**
- Avoid auto-advancing carousels
- Pause auto-playing media
- Save user progress
- Warn 60+ seconds before timeout

#### Motion & Animation
**Requirements:**
- Respect `prefers-reduced-motion` setting
- No flashing content (> 3 flashes/second)
- Provide pause controls for moving content

**Best Practices:**
```css
@media (prefers-reduced-motion: reduce) {
  * {
    animation-duration: 0.01ms !important;
    transition-duration: 0.01ms !important;
  }
}
```

---

### Content & Information

#### Alternative Text
**Requirements:**
- All images have alt text
- Decorative images have empty alt (`alt=""`)
- Complex images have detailed descriptions

**Alt Text Guidelines:**
- Describe content and function, not appearance
- Keep under 150 characters
- Don't start with "Image of" or "Picture of"
- For decorative images: `alt=""`
- For complex diagrams: Use `aria-describedby` or long description

**Examples:**
- ❌ "Image of a dog"
- ✅ "Golden retriever playing fetch in a park"
- ❌ "Click here button"
- ✅ "Submit registration form"

#### Headings
**Requirements:**
- Logical heading structure (H1 → H2 → H3)
- Don't skip heading levels
- H1 used once per page

**Best Practices:**
```html
<h1>Page Title</h1>
  <h2>Section 1</h2>
    <h3>Subsection</h3>
  <h2>Section 2</h2>
    <h3>Subsection</h3>
```

#### Links
**Requirements:**
- Link text describes destination
- Links distinguishable from surrounding text

**Best Practices:**
- ❌ "Click here" or "Read more"
- ✅ "Read the design brief guidelines"
- ❌ URL as link text (https://example.com)
- ✅ Descriptive text with URL in title
- Indicate when links open in new windows
- Underline links in body text

#### Forms
**Requirements:**
- Labels for all inputs
- Error messages clearly identify problems
- Instructions provided where needed
- Group related form elements

**Best Practices:**
```html
<label for="email">Email Address</label>
<input id="email" type="email" required
       aria-describedby="email-hint">
<span id="email-hint">We'll never share your email</span>
```

- Place labels above or beside inputs (not inside)
- Use `<fieldset>` and `<legend>` for groups
- Provide inline validation
- Clear error messages with solutions
- Disable submit until required fields complete

#### Tables
**Requirements:**
- Use table headers (`<th>`)
- Associate headers with data cells
- Provide table caption or summary

**Best Practices:**
```html
<table>
  <caption>Project Timeline</caption>
  <thead>
    <tr>
      <th scope="col">Phase</th>
      <th scope="col">Duration</th>
    </tr>
  </thead>
  <tbody>
    <tr>
      <th scope="row">Discovery</th>
      <td>2 weeks</td>
    </tr>
  </tbody>
</table>
```

---

### Component-Specific Guidelines

#### Modals & Dialogs
- Focus first element when opened
- Trap focus within modal
- Close with Esc key
- Return focus when closed
- Use `role="dialog"` and `aria-modal="true"`
- Provide accessible close button

#### Carousels
- Pause on hover/focus
- Keyboard controls to navigate
- Don't auto-advance (or make stoppable)
- Indicate current slide
- All controls keyboard accessible

#### Navigation
- Skip to main content link
- Keyboard accessible dropdowns
- Clear current page indicator
- Breadcrumb trail when appropriate
- Mobile menu keyboard accessible

#### Forms with Multiple Steps
- Indicate current step and total steps
- Allow navigation between steps
- Save progress
- Review before submit
- Accessible progress indicator

#### Search
- Label search input clearly
- Announce results to screen readers
- Show result count
- Support keyboard navigation of results

---

## Screen Reader Considerations

### ARIA (Accessible Rich Internet Applications)

**Core Principles:**
1. **Use semantic HTML first** - ARIA should enhance, not replace
2. **Don't override native semantics**
3. **All interactive elements must be keyboard accessible**
4. **Don't use ARIA to make elements focusable**

**Common ARIA Attributes:**

```html
<!-- Landmarks -->
<nav aria-label="Main navigation">
<main aria-label="Main content">
<aside aria-label="Related articles">

<!-- Live regions -->
<div aria-live="polite">Status updated</div>
<div aria-live="assertive">Error: Invalid input</div>

<!-- Labels & descriptions -->
<button aria-label="Close dialog">×</button>
<input aria-describedby="password-requirements">

<!-- States -->
<button aria-pressed="true">Bold</button>
<div aria-expanded="false">Menu collapsed</div>
<input aria-invalid="true">
```

**Common Roles:**
- `role="button"` - For clickable non-button elements
- `role="navigation"` - Navigation landmarks
- `role="search"` - Search landmarks
- `role="alert"` - Important messages
- `role="dialog"` - Modal dialogs
- `role="tablist"`, `role="tab"`, `role="tabpanel"` - Tab components

### Screen Reader Testing

**Test with:**
- **NVDA** (Windows, free)
- **JAWS** (Windows, paid)
- **VoiceOver** (macOS/iOS, built-in)
- **TalkBack** (Android, built-in)

**Testing Checklist:**
- [ ] Can navigate entire page with keyboard alone
- [ ] All interactive elements announced correctly
- [ ] Heading structure makes sense
- [ ] Form labels associated properly
- [ ] Error messages announced
- [ ] Dynamic content updates announced
- [ ] Images have appropriate alt text

---

## Design Handoff Checklist

### For Designers to Specify

- [ ] **Color contrast ratios** for all text and UI elements
- [ ] **Focus indicator styles** for interactive elements
- [ ] **Touch target sizes** (minimum 44×44px)
- [ ] **Alt text** for all meaningful images
- [ ] **Heading hierarchy** clearly marked
- [ ] **Form labels** positioned and associated
- [ ] **Error states** designed and documented
- [ ] **Keyboard navigation** flow specified
- [ ] **Motion** alternatives for animations
- [ ] **Responsive text** sizing behavior

### Documentation to Provide

```markdown
## Accessibility Specifications

### Color Contrast
- Primary text on background: 8.2:1 (AAA)
- Button text on primary color: 5.1:1 (AA)
- All tested with [tool name]

### Interactive States
- Default: [specs]
- Hover: [specs]
- Focus: 2px solid blue outline, 3:1 contrast
- Active: [specs]
- Disabled: [specs]

### Keyboard Navigation
1. Tab order: Header → CTA → Form → Footer
2. Skip link to main content
3. Escape closes modal

### Screen Reader Content
- "Menu" button: aria-label="Open navigation menu"
- Close button: aria-label="Close dialog"
- Loading state: aria-live="polite" announcement
```

---

## Testing & Validation

### Automated Testing Tools

**Browser Extensions:**
- [axe DevTools](https://www.deque.com/axe/devtools/) - Free, comprehensive
- [WAVE](https://wave.webaim.org/) - Visual feedback
- [Lighthouse](https://developers.google.com/web/tools/lighthouse) - Built into Chrome

**Design Tools:**
- Figma: Stark, A11y - Focus Orderer
- Sketch: Stark
- Adobe XD: Accessibility features built-in

**Limitations:**
- Automated tools catch ~30-40% of issues
- Manual testing required for full compliance

### Manual Testing Checklist

- [ ] **Keyboard only** - Can you complete all tasks?
- [ ] **Screen reader** - Does it make sense?
- [ ] **Zoom to 200%** - Is content still readable?
- [ ] **Color blindness** - Information still conveyed?
- [ ] **Resize text** - Layout still works?
- [ ] **Disable CSS** - Content still logical?
- [ ] **Motion reduced** - Animations simplified?

### User Testing with People with Disabilities

**Include diverse participants:**
- Screen reader users (blind/low vision)
- Keyboard-only users (motor disabilities)
- Voice control users
- Cognitive disabilities
- Older adults
- Low bandwidth/assistive tech users

---

## Common Accessibility Mistakes

### ❌ Don't Do This

1. **Using placeholders as labels**
   ```html
   <!-- Bad -->
   <input placeholder="Email address">

   <!-- Good -->
   <label for="email">Email address</label>
   <input id="email" type="email">
   ```

2. **Icon-only buttons without labels**
   ```html
   <!-- Bad -->
   <button><svg>...</svg></button>

   <!-- Good -->
   <button aria-label="Close menu">
     <svg aria-hidden="true">...</svg>
   </button>
   ```

3. **Disabled buttons without explanation**
   ```html
   <!-- Bad -->
   <button disabled>Submit</button>

   <!-- Good -->
   <button disabled aria-describedby="submit-hint">Submit</button>
   <span id="submit-hint">Complete all required fields to submit</span>
   ```

4. **Auto-playing media**
   ```html
   <!-- Bad -->
   <video autoplay>

   <!-- Good -->
   <video controls>
     <track kind="captions" src="captions.vtt">
   </video>
   ```

5. **Removing focus indicators**
   ```css
   /* Bad */
   :focus { outline: none; }

   /* Good */
   :focus {
     outline: 2px solid blue;
     outline-offset: 2px;
   }
   ```

---

## Accessibility Statement Template

Include on your website:

```markdown
## Accessibility Statement

[Organization] is committed to ensuring digital accessibility for people with disabilities. We are continually improving the user experience for everyone and applying the relevant accessibility standards.

### Conformance Status
The Web Content Accessibility Guidelines (WCAG) defines requirements to improve accessibility. We aim for WCAG 2.1 Level AA conformance.

### Feedback
We welcome your feedback on the accessibility of [product name]. Please contact us:
- Email: [accessibility@example.com]
- Phone: [phone number]

### Technical Specifications
[Product] accessibility relies on the following technologies:
- HTML
- CSS
- JavaScript
- ARIA

### Assessment Approach
[Organization] assessed the accessibility of [product] by:
- Self-evaluation
- External evaluation by [company]
- User testing with people with disabilities

### Date
This statement was created on [date] and last reviewed on [date].
```

---

## Resources

### Guidelines & Standards
- [WCAG 2.1](https://www.w3.org/WAI/WCAG21/quickref/)
- [ARIA Authoring Practices](https://www.w3.org/WAI/ARIA/apg/)
- [Section 508](https://www.section508.gov/)
- [A11Y Project Checklist](https://www.a11yproject.com/checklist/)

### Testing Tools
- [axe DevTools](https://www.deque.com/axe/)
- [WAVE](https://wave.webaim.org/)
- [Color Contrast Analyzer](https://www.tpgi.com/color-contrast-checker/)
- [NVDA Screen Reader](https://www.nvaccess.org/)

### Learning
- [WebAIM](https://webaim.org/)
- [Deque University](https://dequeuniversity.com/)
- [Inclusive Components](https://inclusive-components.design/)
- [A11ycasts (YouTube)](https://www.youtube.com/playlist?list=PLNYkxOF6rcICWx0C9LVWWVqvHlYJyqw7g)

### Component Patterns
- [Inclusive Components](https://inclusive-components.design/)
- [A11Y Style Guide](https://a11y-style-guide.com/)
- [GOV.UK Design System](https://design-system.service.gov.uk/)

---

## Quick Reference

### Minimum Requirements (WCAG 2.1 AA)

| Category | Requirement |
|----------|-------------|
| **Color Contrast** | 4.5:1 (text), 3:1 (UI) |
| **Touch Targets** | 44×44px minimum |
| **Text Resize** | 200% without loss |
| **Keyboard** | Full functionality |
| **Focus Visible** | Clear indicators |
| **Alt Text** | All images |
| **Labels** | All form inputs |
| **Headings** | Logical structure |
| **Link Text** | Descriptive |
| **Time Limits** | User controllable |
| **Motion** | Reduced option |
| **Error Messages** | Clear & helpful |

### Priority Checklist for Design Briefs

- [ ] Target WCAG 2.1 Level AA
- [ ] Specify color contrast ratios
- [ ] Design clear focus indicators
- [ ] Ensure 44×44px touch targets
- [ ] Plan keyboard navigation flow
- [ ] Include motion alternatives
- [ ] Document ARIA requirements
- [ ] Design error states
- [ ] Consider screen reader experience
- [ ] Plan accessibility testing

---

Remember: **Accessibility is not a feature, it's a fundamental requirement.** Build it in from the start, not as an afterthought.
