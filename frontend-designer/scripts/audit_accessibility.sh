#!/bin/bash

# Frontend Designer - Accessibility Audit
# Comprehensive WCAG 2.1 AA compliance checker

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

# Counters
PASS_COUNT=0
FAIL_COUNT=0
WARNING_COUNT=0

# Helper functions
print_success() {
    echo -e "${GREEN}✓ PASS${NC} $1"
    ((PASS_COUNT++))
}

print_error() {
    echo -e "${RED}✗ FAIL${NC} $1"
    ((FAIL_COUNT++))
}

print_warning() {
    echo -e "${YELLOW}⚠ WARN${NC} $1"
    ((WARNING_COUNT++))
}

print_info() {
    echo -e "${BLUE}ℹ INFO${NC} $1"
}

print_section() {
    echo ""
    echo -e "${MAGENTA}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
    echo -e "${MAGENTA}$1${NC}"
    echo -e "${MAGENTA}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
}

# Banner
echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                                                            ║"
echo "║         Frontend Designer - Accessibility Audit           ║"
echo "║                   WCAG 2.1 AA Compliance                   ║"
echo "║                                                            ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Get target
if [ -z "$1" ]; then
    print_info "Usage: $0 <file.html|directory>"
    print_info "Example: $0 index.html"
    print_info "Example: $0 src/components/"
    exit 1
fi

TARGET="$1"

# Check if target exists
if [ ! -e "$TARGET" ]; then
    print_error "Target not found: $TARGET"
    exit 1
fi

# Section 1: HTML Structure
print_section "1. HTML STRUCTURE & SEMANTICS"

check_html_lang() {
    if grep -q '<html[^>]*\slang=' "$1"; then
        print_success "HTML lang attribute present"
    else
        print_error "Missing lang attribute on <html>"
        echo "         Fix: <html lang=\"en\">"
    fi
}

check_page_title() {
    if grep -q '<title>' "$1"; then
        print_success "Page title present"
    else
        print_error "Missing <title> element"
        echo "         Fix: Add <title>Page Title</title>"
    fi
}

check_main_landmark() {
    if grep -q '<main' "$1" || grep -q 'role="main"' "$1"; then
        print_success "Main landmark present"
    else
        print_warning "No <main> landmark found"
        echo "         Tip: Use <main> for primary content"
    fi
}

check_heading_structure() {
    if grep -q '<h1' "$1"; then
        print_success "H1 heading found"

        # Check for heading hierarchy
        local h1_count=$(grep -o '<h1' "$1" | wc -l)
        if [ "$h1_count" -eq 1 ]; then
            print_success "Single H1 (recommended)"
        else
            print_warning "Multiple H1 headings found ($h1_count)"
            echo "         Tip: Use single H1 per page"
        fi
    else
        print_error "No H1 heading found"
        echo "         Fix: Add <h1> for main page heading"
    fi
}

check_semantic_html() {
    local semantic_tags=("nav" "header" "footer" "article" "section" "aside")
    local found=false

    for tag in "${semantic_tags[@]}"; do
        if grep -q "<$tag" "$1"; then
            found=true
            break
        fi
    done

    if [ "$found" = true ]; then
        print_success "Semantic HTML elements used"
    else
        print_warning "Consider using semantic HTML (nav, header, footer, etc.)"
    fi
}

# Section 2: Images & Media
print_section "2. IMAGES & MEDIA"

check_img_alt() {
    local img_count=$(grep -o '<img' "$1" | wc -l)

    if [ "$img_count" -eq 0 ]; then
        print_info "No images found"
    else
        local alt_count=$(grep '<img' "$1" | grep -c 'alt=')

        if [ "$alt_count" -eq "$img_count" ]; then
            print_success "All images have alt attributes ($img_count/$img_count)"
        else
            print_error "Images missing alt attributes ($alt_count/$img_count)"
            echo "         Fix: Add alt=\"description\" to all images"
            echo "         For decorative images use alt=\"\""
        fi
    fi
}

check_video_captions() {
    if grep -q '<video' "$1"; then
        if grep -q '<track' "$1"; then
            print_success "Video has captions/subtitles"
        else
            print_error "Video missing captions"
            echo "         Fix: Add <track kind=\"captions\" src=\"captions.vtt\">"
        fi
    fi
}

# Section 3: Forms
print_section "3. FORMS & INPUTS"

check_form_labels() {
    local input_count=$(grep -o '<input' "$1" | wc -l)

    if [ "$input_count" -eq 0 ]; then
        print_info "No form inputs found"
    else
        # Check for labels
        local label_count=$(grep -o '<label' "$1" | wc -l)
        local aria_label_count=$(grep '<input' "$1" | grep -c 'aria-label')
        local aria_labelledby_count=$(grep '<input' "$1" | grep -c 'aria-labelledby')

        local labeled_count=$((label_count + aria_label_count + aria_labelledby_count))

        if [ "$labeled_count" -ge "$input_count" ]; then
            print_success "All inputs have labels"
        else
            print_error "Some inputs missing labels"
            echo "         Fix: Use <label for=\"id\"> or aria-label"
        fi

        # Check for required fields
        if grep -q 'required' "$1"; then
            if grep -q 'aria-required="true"' "$1"; then
                print_success "Required fields marked with aria-required"
            else
                print_warning "Consider adding aria-required=\"true\" to required fields"
            fi
        fi
    fi
}

check_error_messages() {
    if grep -q 'aria-describedby' "$1"; then
        print_success "Error messages linked with aria-describedby"
    elif grep -q 'error' "$1"; then
        print_warning "Error handling present, verify aria-describedby usage"
    fi
}

# Section 4: Interactive Elements
print_section "4. INTERACTIVE ELEMENTS"

check_button_text() {
    # Check for empty buttons
    if grep -q '<button[^>]*></button>' "$1"; then
        print_error "Empty button found"
        echo "         Fix: Add text or aria-label to button"
    else
        print_success "No empty buttons found"
    fi
}

check_link_text() {
    # Check for generic link text
    if grep -qi 'click here\|read more\|more' "$1"; then
        print_warning "Generic link text found (click here, read more)"
        echo "         Tip: Use descriptive link text"
    else
        print_success "No generic link text detected"
    fi
}

check_skip_links() {
    if grep -q 'skip.*content\|skip.*navigation' "$1"; then
        print_success "Skip navigation link present"
    else
        print_warning "No skip navigation link found"
        echo "         Tip: Add skip link for keyboard users"
        echo "         <a href=\"#main\" class=\"skip-link\">Skip to content</a>"
    fi
}

# Section 5: ARIA
print_section "5. ARIA ATTRIBUTES"

check_aria_roles() {
    if grep -q 'role=' "$1"; then
        print_success "ARIA roles found"

        # Check for button roles on non-button elements
        if grep -q '<div[^>]*role="button"' "$1" || grep -q '<span[^>]*role="button"' "$1"; then
            if grep -q 'tabindex=' "$1"; then
                print_success "Custom buttons have tabindex"
            else
                print_error "role=\"button\" without tabindex"
                echo "         Fix: Add tabindex=\"0\" to custom buttons"
            fi
        fi
    fi
}

check_aria_labels() {
    if grep -q 'aria-label=' "$1"; then
        print_success "ARIA labels used for context"
    fi

    # Check for redundant aria-label
    if grep -q '<button[^>]*aria-label.*>[^<]*</button>' "$1"; then
        print_warning "Possible redundant aria-label on button with text"
        echo "         Tip: Use aria-label when button has no visible text"
    fi
}

check_aria_live() {
    if grep -q 'aria-live' "$1"; then
        print_success "Live regions defined"
    fi
}

# Section 6: Keyboard Navigation
print_section "6. KEYBOARD NAVIGATION"

check_tabindex() {
    # Check for positive tabindex
    if grep -q 'tabindex="[1-9]' "$1"; then
        print_error "Positive tabindex values found"
        echo "         Fix: Use tabindex=\"0\" or \"-1\" only"
        echo "         Positive values disrupt natural tab order"
    else
        print_success "No positive tabindex values (good)"
    fi
}

check_focus_indicators() {
    # This would need CSS analysis
    print_info "Manual check: Verify focus indicators are visible"
    echo "         Test: Tab through page, ensure focus is visible"
    echo "         CSS: :focus-visible { outline: 2px solid; }"
}

# Section 7: Color & Contrast
print_section "7. COLOR & CONTRAST"

print_info "Manual checks required for color/contrast:"
echo ""
echo "  Required contrast ratios (WCAG AA):"
echo "  ✓ Normal text: 4.5:1"
echo "  ✓ Large text (18pt+): 3:1"
echo "  ✓ UI components: 3:1"
echo ""
echo "  Tools for testing:"
echo "  - Chrome DevTools (Lighthouse)"
echo "  - WebAIM Contrast Checker"
echo "  - axe DevTools"
echo ""

check_color_only() {
    if grep -qi 'color:.*red\|color:.*green' "$1"; then
        print_warning "Color usage detected - ensure not used as only indicator"
        echo "         Tip: Don't rely on color alone (add icons, text, patterns)"
    fi
}

# Section 8: Responsive & Mobile
print_section "8. RESPONSIVE & MOBILE"

check_viewport() {
    if grep -q 'viewport' "$1"; then
        print_success "Viewport meta tag present"
    else
        print_error "Missing viewport meta tag"
        echo "         Fix: <meta name=\"viewport\" content=\"width=device-width, initial-scale=1\">"
    fi
}

check_touch_targets() {
    print_info "Manual check: Touch targets minimum 44x44px"
    echo "         Test: Verify buttons/links meet minimum size"
    echo "         CSS: min-height: 44px; min-width: 44px;"
}

# Section 9: Content
print_section "9. CONTENT & READABILITY"

check_lang_changes() {
    if grep -q '\slang=' "$1"; then
        local lang_count=$(grep -o '\slang=' "$1" | wc -l)
        if [ "$lang_count" -gt 1 ]; then
            print_success "Language changes marked ($lang_count instances)"
        fi
    fi
}

check_abbreviations() {
    if grep -q '<abbr' "$1"; then
        print_success "Abbreviations use <abbr> element"
    fi
}

# Section 10: Motion & Animation
print_section "10. MOTION & ANIMATIONS"

print_info "Manual check: Respect prefers-reduced-motion"
echo ""
echo "  CSS:"
echo "  @media (prefers-reduced-motion: reduce) {"
echo "    * { animation: none !important; }"
echo "  }"
echo ""

# Run checks on files
if [ -f "$TARGET" ]; then
    # Single file
    check_html_lang "$TARGET"
    check_page_title "$TARGET"
    check_main_landmark "$TARGET"
    check_heading_structure "$TARGET"
    check_semantic_html "$TARGET"
    check_img_alt "$TARGET"
    check_video_captions "$TARGET"
    check_form_labels "$TARGET"
    check_error_messages "$TARGET"
    check_button_text "$TARGET"
    check_link_text "$TARGET"
    check_skip_links "$TARGET"
    check_aria_roles "$TARGET"
    check_aria_labels "$TARGET"
    check_aria_live "$TARGET"
    check_tabindex "$TARGET"
    check_focus_indicators "$TARGET"
    check_color_only "$TARGET"
    check_viewport "$TARGET"
    check_touch_targets "$TARGET"
    check_lang_changes "$TARGET"
    check_abbreviations "$TARGET"
elif [ -d "$TARGET" ]; then
    # Directory - find HTML files
    html_files=$(find "$TARGET" -name "*.html" -o -name "*.htm")

    if [ -z "$html_files" ]; then
        print_error "No HTML files found in $TARGET"
        exit 1
    fi

    for file in $html_files; do
        print_info "Checking: $file"
        check_html_lang "$file"
        check_page_title "$file"
        check_main_landmark "$file"
        check_heading_structure "$file"
        check_img_alt "$file"
        check_form_labels "$file"
        echo ""
    done
fi

# Summary
echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                      Audit Summary                         ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
echo -e "${GREEN}✓ Passed:  $PASS_COUNT${NC}"
echo -e "${RED}✗ Failed:  $FAIL_COUNT${NC}"
echo -e "${YELLOW}⚠ Warnings: $WARNING_COUNT${NC}"
echo ""

# Calculate score
TOTAL=$((PASS_COUNT + FAIL_COUNT))
if [ $TOTAL -gt 0 ]; then
    SCORE=$(( (PASS_COUNT * 100) / TOTAL ))
    echo "Score: $SCORE%"
    echo ""

    if [ $SCORE -ge 90 ]; then
        echo -e "${GREEN}Excellent! Your site is highly accessible.${NC}"
    elif [ $SCORE -ge 70 ]; then
        echo -e "${YELLOW}Good, but needs improvements.${NC}"
    else
        echo -e "${RED}Needs significant accessibility improvements.${NC}"
    fi
fi

echo ""
print_info "Additional Testing Recommended:"
echo "  1. Screen reader testing (NVDA, JAWS, VoiceOver)"
echo "  2. Keyboard-only navigation"
echo "  3. Automated tools (axe, Lighthouse, WAVE)"
echo "  4. Color contrast analyzer"
echo "  5. Real user testing with assistive technologies"
echo ""
print_info "Resources:"
echo "  - WCAG 2.1: https://www.w3.org/WAI/WCAG21/quickref/"
echo "  - WebAIM: https://webaim.org/"
echo "  - a11y Project: https://www.a11yproject.com/"
echo ""

# Exit code based on failures
if [ $FAIL_COUNT -gt 0 ]; then
    exit 1
else
    exit 0
fi
