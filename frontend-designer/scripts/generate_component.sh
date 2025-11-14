#!/bin/bash

# Frontend Designer - Component Generator
# Generates accessible, responsive components with design tokens

set -e

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

# Helper functions
print_success() {
    echo -e "${GREEN}✓ $1${NC}"
}

print_error() {
    echo -e "${RED}✗ $1${NC}"
}

print_info() {
    echo -e "${BLUE}ℹ $1${NC}"
}

print_warning() {
    echo -e "${YELLOW}⚠ $1${NC}"
}

prompt_input() {
    local prompt="$1"
    local var_name="$2"
    local required="${3:-false}"

    while true; do
        echo -e "${BLUE}${prompt}${NC}"
        read -r input

        if [ -z "$input" ] && [ "$required" = true ]; then
            print_error "This field is required."
            continue
        fi

        eval "$var_name='$input'"
        break
    done
}

prompt_select() {
    local prompt="$1"
    local var_name="$2"
    shift 2
    local options=("$@")

    echo -e "${BLUE}${prompt}${NC}"
    PS3="Select (1-${#options[@]}): "
    select opt in "${options[@]}"; do
        if [ -n "$opt" ]; then
            eval "$var_name='$opt'"
            break
        else
            print_error "Invalid selection. Try again."
        fi
    done
}

# Banner
echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                                                            ║"
echo "║          Frontend Designer - Component Generator          ║"
echo "║                                                            ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""

# Step 1: Component Type
print_info "Step 1/6: Component Type"
prompt_select "What type of component?" COMPONENT_TYPE \
    "Button" \
    "Input" \
    "Card" \
    "Modal" \
    "Dropdown" \
    "Navigation" \
    "Form" \
    "List" \
    "Custom"

# Step 2: Component Name
print_info "Step 2/6: Component Name"
prompt_input "Component name (PascalCase, e.g., UserProfile):" COMPONENT_NAME true

# Step 3: Framework
print_info "Step 3/6: Framework"
prompt_select "Which framework?" FRAMEWORK \
    "React" \
    "Vue" \
    "Vanilla JS" \
    "Web Components"

# Step 4: Features
print_info "Step 4/6: Features (comma-separated)"
echo -e "${BLUE}Select features to include (e.g., variants,loading,disabled):${NC}"
echo "  - variants (different visual styles)"
echo "  - sizes (sm, md, lg)"
echo "  - loading (loading state)"
echo "  - disabled (disabled state)"
echo "  - icons (icon support)"
echo "  - responsive (responsive behavior)"
read -r FEATURES

# Step 5: Accessibility
print_info "Step 5/6: Accessibility Requirements"
prompt_select "WCAG compliance level?" A11Y_LEVEL \
    "AA (recommended)" \
    "AAA (strict)" \
    "Basic"

# Step 6: Output Directory
print_info "Step 6/6: Output Location"
prompt_input "Output directory (default: ./components):" OUTPUT_DIR
OUTPUT_DIR=${OUTPUT_DIR:-"./components"}

# Create output directory
mkdir -p "$OUTPUT_DIR"

# Generate based on framework
case $FRAMEWORK in
    "React")
        generate_react_component
        ;;
    "Vue")
        generate_vue_component
        ;;
    "Vanilla JS")
        generate_vanilla_component
        ;;
    "Web Components")
        generate_web_component
        ;;
esac

# Generate component based on selected framework
generate_react_component() {
    local file_path="$OUTPUT_DIR/$COMPONENT_NAME.tsx"

    cat > "$file_path" << 'EOF'
import React from 'react';
import './COMPONENT_NAME.css';

interface COMPONENT_NAMEProps {
  children?: React.ReactNode;
  className?: string;
  VARIANT_PROP
  SIZE_PROP
  DISABLED_PROP
  LOADING_PROP
  onClick?: () => void;
}

export const COMPONENT_NAME: React.FC<COMPONENT_NAMEProps> = ({
  children,
  className = '',
  VARIANT_DEFAULT
  SIZE_DEFAULT
  DISABLED_DEFAULT
  LOADING_DEFAULT
  onClick,
}) => {
  const baseClass = 'COMPONENT_CLASS';
  const variantClass = `${baseClass}--${variant}`;
  const sizeClass = `${baseClass}--${size}`;
  const classes = `${baseClass} ${variantClass} ${sizeClass} ${className}`;

  return (
    <COMPONENT_ELEMENT
      className={classes}
      onClick={onClick}
      disabled={disabled || loading}
      aria-busy={loading}
      ARIA_ATTRIBUTES
    >
      LOADING_SPINNER
      {children}
    </COMPONENT_ELEMENT>
  );
};
EOF

    # Replace placeholders based on features
    sed -i "s/COMPONENT_NAME/$COMPONENT_NAME/g" "$file_path"
    sed -i "s/COMPONENT_CLASS/$(echo "$COMPONENT_NAME" | sed 's/\([A-Z]\)/-\L\1/g' | sed 's/^-//')/g" "$file_path"

    if [[ $FEATURES == *"variants"* ]]; then
        sed -i "s/VARIANT_PROP/variant?: 'primary' | 'secondary' | 'ghost';/" "$file_path"
        sed -i "s/VARIANT_DEFAULT/variant = 'primary',/" "$file_path"
    else
        sed -i "/VARIANT_PROP/d" "$file_path"
        sed -i "/VARIANT_DEFAULT/d" "$file_path"
    fi

    if [[ $FEATURES == *"sizes"* ]]; then
        sed -i "s/SIZE_PROP/size?: 'sm' | 'md' | 'lg';/" "$file_path"
        sed -i "s/SIZE_DEFAULT/size = 'md',/" "$file_path"
    else
        sed -i "/SIZE_PROP/d" "$file_path"
        sed -i "/SIZE_DEFAULT/d" "$file_path"
    fi

    if [[ $FEATURES == *"disabled"* ]]; then
        sed -i "s/DISABLED_PROP/disabled?: boolean;/" "$file_path"
        sed -i "s/DISABLED_DEFAULT/disabled = false,/" "$file_path"
    else
        sed -i "/DISABLED_PROP/d" "$file_path"
        sed -i "/DISABLED_DEFAULT/d" "$file_path"
    fi

    if [[ $FEATURES == *"loading"* ]]; then
        sed -i "s/LOADING_PROP/loading?: boolean;/" "$file_path"
        sed -i "s/LOADING_DEFAULT/loading = false,/" "$file_path"
        sed -i "s|LOADING_SPINNER|{loading \&\& <span className=\"spinner\" aria-hidden=\"true\" />}|" "$file_path"
    else
        sed -i "/LOADING_PROP/d" "$file_path"
        sed -i "/LOADING_DEFAULT/d" "$file_path"
        sed -i "/LOADING_SPINNER/d" "$file_path"
    fi

    # Determine element type
    case $COMPONENT_TYPE in
        "Button")
            sed -i "s/COMPONENT_ELEMENT/button/" "$file_path"
            sed -i "s/ARIA_ATTRIBUTES//" "$file_path"
            ;;
        "Input")
            sed -i "s/COMPONENT_ELEMENT/input/" "$file_path"
            sed -i "s/ARIA_ATTRIBUTES/aria-label=\"\" aria-describedby=\"\"/" "$file_path"
            ;;
        "Card")
            sed -i "s/COMPONENT_ELEMENT/div/" "$file_path"
            sed -i "s/ARIA_ATTRIBUTES/role=\"article\"/" "$file_path"
            ;;
        *)
            sed -i "s/COMPONENT_ELEMENT/div/" "$file_path"
            sed -i "s/ARIA_ATTRIBUTES//" "$file_path"
            ;;
    esac

    print_success "Created React component: $file_path"
    generate_css
    generate_test_file
}

generate_vue_component() {
    local file_path="$OUTPUT_DIR/$COMPONENT_NAME.vue"

    cat > "$file_path" << 'EOF'
<template>
  <COMPONENT_ELEMENT
    :class="classes"
    @click="onClick"
    :disabled="disabled || loading"
    :aria-busy="loading"
  >
    <span v-if="loading" class="spinner" aria-hidden="true"></span>
    <slot></slot>
  </COMPONENT_ELEMENT>
</template>

<script setup lang="ts">
import { computed } from 'vue';

interface Props {
  variant?: 'primary' | 'secondary' | 'ghost';
  size?: 'sm' | 'md' | 'lg';
  disabled?: boolean;
  loading?: boolean;
}

const props = withDefaults(defineProps<Props>(), {
  variant: 'primary',
  size: 'md',
  disabled: false,
  loading: false,
});

const emit = defineEmits<{
  click: [];
}>();

const baseClass = 'COMPONENT_CLASS';

const classes = computed(() => [
  baseClass,
  `${baseClass}--${props.variant}`,
  `${baseClass}--${props.size}`,
]);

const onClick = () => {
  if (!props.disabled && !props.loading) {
    emit('click');
  }
};
</script>

<style scoped>
@import './COMPONENT_NAME.css';
</style>
EOF

    sed -i "s/COMPONENT_NAME/$COMPONENT_NAME/g" "$file_path"
    sed -i "s/COMPONENT_CLASS/$(echo "$COMPONENT_NAME" | sed 's/\([A-Z]\)/-\L\1/g' | sed 's/^-//')/g" "$file_path"

    case $COMPONENT_TYPE in
        "Button")
            sed -i "s/COMPONENT_ELEMENT/button/" "$file_path"
            ;;
        "Input")
            sed -i "s/COMPONENT_ELEMENT/input/" "$file_path"
            ;;
        *)
            sed -i "s/COMPONENT_ELEMENT/div/" "$file_path"
            ;;
    esac

    print_success "Created Vue component: $file_path"
    generate_css
}

generate_css() {
    local css_file="$OUTPUT_DIR/$COMPONENT_NAME.css"
    local class_name=$(echo "$COMPONENT_NAME" | sed 's/\([A-Z]\)/-\L\1/g' | sed 's/^-//')

    cat > "$css_file" << EOF
/* $COMPONENT_NAME Component Styles */

.$class_name {
  /* Design Tokens */
  --component-bg: var(--color-surface);
  --component-text: var(--color-text);
  --component-border: var(--color-border);
  --component-radius: var(--radius-md);
  --component-shadow: var(--shadow-sm);

  /* Base Styles */
  display: inline-flex;
  align-items: center;
  justify-content: center;
  gap: var(--space-2);

  padding: var(--space-3) var(--space-4);

  background-color: var(--component-bg);
  color: var(--component-text);
  border: 1px solid var(--component-border);
  border-radius: var(--component-radius);

  font-family: var(--font-base);
  font-size: var(--text-base);
  font-weight: 500;
  line-height: 1.5;

  cursor: pointer;
  user-select: none;

  transition: all 0.2s ease;

  /* Accessibility */
  min-height: 44px; /* WCAG touch target */
  min-width: 44px;
}

/* Variants */
.$class_name--primary {
  --component-bg: var(--color-primary);
  --component-text: var(--color-white);
  --component-border: var(--color-primary);
}

.$class_name--primary:hover:not(:disabled) {
  --component-bg: var(--color-primary-hover);
  --component-border: var(--color-primary-hover);
  box-shadow: var(--shadow-md);
}

.$class_name--secondary {
  --component-bg: transparent;
  --component-text: var(--color-primary);
  --component-border: var(--color-primary);
}

.$class_name--secondary:hover:not(:disabled) {
  --component-bg: var(--color-primary-subtle);
}

.$class_name--ghost {
  --component-bg: transparent;
  --component-text: var(--color-text);
  --component-border: transparent;
}

.$class_name--ghost:hover:not(:disabled) {
  --component-bg: var(--color-surface-hover);
}

/* Sizes */
.$class_name--sm {
  padding: var(--space-2) var(--space-3);
  font-size: var(--text-sm);
  min-height: 36px;
}

.$class_name--md {
  padding: var(--space-3) var(--space-4);
  font-size: var(--text-base);
  min-height: 44px;
}

.$class_name--lg {
  padding: var(--space-4) var(--space-6);
  font-size: var(--text-lg);
  min-height: 52px;
}

/* States */
.$class_name:focus-visible {
  outline: 2px solid var(--color-focus);
  outline-offset: 2px;
}

.$class_name:active:not(:disabled) {
  transform: scale(0.98);
}

.$class_name:disabled {
  opacity: 0.5;
  cursor: not-allowed;
}

.$class_name[aria-busy="true"] {
  cursor: wait;
}

/* Loading Spinner */
.spinner {
  display: inline-block;
  width: 1em;
  height: 1em;
  border: 2px solid currentColor;
  border-right-color: transparent;
  border-radius: 50%;
  animation: spin 0.6s linear infinite;
}

@keyframes spin {
  to {
    transform: rotate(360deg);
  }
}

/* Responsive */
@media (max-width: 768px) {
  .$class_name {
    width: 100%;
  }
}

/* Dark Mode */
@media (prefers-color-scheme: dark) {
  .$class_name {
    --component-bg: var(--color-surface-dark);
    --component-text: var(--color-text-dark);
    --component-border: var(--color-border-dark);
  }
}

/* High Contrast Mode */
@media (prefers-contrast: high) {
  .$class_name {
    border-width: 2px;
  }

  .$class_name:focus-visible {
    outline-width: 3px;
  }
}

/* Reduced Motion */
@media (prefers-reduced-motion: reduce) {
  .$class_name,
  .spinner {
    animation: none;
    transition: none;
  }
}
EOF

    print_success "Created CSS file: $css_file"
}

generate_test_file() {
    if [ "$FRAMEWORK" != "React" ]; then
        return
    fi

    local test_file="$OUTPUT_DIR/$COMPONENT_NAME.test.tsx"

    cat > "$test_file" << 'EOF'
import { render, screen, fireEvent } from '@testing-library/react';
import { COMPONENT_NAME } from './COMPONENT_NAME';

describe('COMPONENT_NAME', () => {
  it('renders children correctly', () => {
    render(<COMPONENT_NAME>Click me</COMPONENT_NAME>);
    expect(screen.getByText('Click me')).toBeInTheDocument();
  });

  it('handles click events', () => {
    const handleClick = jest.fn();
    render(<COMPONENT_NAME onClick={handleClick}>Click me</COMPONENT_NAME>);

    fireEvent.click(screen.getByText('Click me'));
    expect(handleClick).toHaveBeenCalledTimes(1);
  });

  it('renders with different variants', () => {
    const { rerender } = render(<COMPONENT_NAME variant="primary">Primary</COMPONENT_NAME>);
    expect(screen.getByText('Primary')).toHaveClass('COMPONENT_CLASS--primary');

    rerender(<COMPONENT_NAME variant="secondary">Secondary</COMPONENT_NAME>);
    expect(screen.getByText('Secondary')).toHaveClass('COMPONENT_CLASS--secondary');
  });

  it('renders with different sizes', () => {
    const { rerender } = render(<COMPONENT_NAME size="sm">Small</COMPONENT_NAME>);
    expect(screen.getByText('Small')).toHaveClass('COMPONENT_CLASS--sm');

    rerender(<COMPONENT_NAME size="lg">Large</COMPONENT_NAME>);
    expect(screen.getByText('Large')).toHaveClass('COMPONENT_CLASS--lg');
  });

  it('disables interaction when disabled', () => {
    const handleClick = jest.fn();
    render(<COMPONENT_NAME disabled onClick={handleClick}>Disabled</COMPONENT_NAME>);

    const element = screen.getByText('Disabled');
    expect(element).toBeDisabled();

    fireEvent.click(element);
    expect(handleClick).not.toHaveBeenCalled();
  });

  it('shows loading state', () => {
    render(<COMPONENT_NAME loading>Loading</COMPONENT_NAME>);

    const element = screen.getByText('Loading');
    expect(element).toHaveAttribute('aria-busy', 'true');
    expect(element).toBeDisabled();
  });

  it('is keyboard accessible', () => {
    const handleClick = jest.fn();
    render(<COMPONENT_NAME onClick={handleClick}>Accessible</COMPONENT_NAME>);

    const element = screen.getByText('Accessible');
    element.focus();
    expect(element).toHaveFocus();
  });

  it('has proper ARIA attributes', () => {
    render(<COMPONENT_NAME loading>ARIA Test</COMPONENT_NAME>);
    const element = screen.getByText('ARIA Test');
    expect(element).toHaveAttribute('aria-busy', 'true');
  });
});
EOF

    sed -i "s/COMPONENT_NAME/$COMPONENT_NAME/g" "$test_file"
    sed -i "s/COMPONENT_CLASS/$(echo "$COMPONENT_NAME" | sed 's/\([A-Z]\)/-\L\1/g' | sed 's/^-//')/g" "$test_file"

    print_success "Created test file: $test_file"
}

# Summary
echo ""
echo "╔════════════════════════════════════════════════════════════╗"
echo "║                    Generation Complete                     ║"
echo "╚════════════════════════════════════════════════════════════╝"
echo ""
print_success "Component: $COMPONENT_NAME"
print_success "Type: $COMPONENT_TYPE"
print_success "Framework: $FRAMEWORK"
print_success "Location: $OUTPUT_DIR"
echo ""
print_info "Files created:"
case $FRAMEWORK in
    "React")
        echo "  - $COMPONENT_NAME.tsx (component)"
        echo "  - $COMPONENT_NAME.css (styles)"
        echo "  - $COMPONENT_NAME.test.tsx (tests)"
        ;;
    "Vue")
        echo "  - $COMPONENT_NAME.vue (component)"
        echo "  - $COMPONENT_NAME.css (styles)"
        ;;
    *)
        echo "  - $COMPONENT_NAME.js (component)"
        echo "  - $COMPONENT_NAME.css (styles)"
        ;;
esac
echo ""
print_info "Next steps:"
echo "  1. Review generated files"
echo "  2. Customize component logic"
echo "  3. Add to your component library"
echo "  4. Run tests (npm test)"
echo "  5. Test accessibility (npm run a11y)"
echo ""
