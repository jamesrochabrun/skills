# Component Library Architecture

Complete guide to building, organizing, and maintaining a scalable component library.

## Component Architecture Principles

### 1. Atomic Design

Organize components hierarchically from smallest to largest.

**Hierarchy:**
```
Atoms → Molecules → Organisms → Templates → Pages
```

**Example Structure:**
```
components/
├── atoms/
│   ├── Button/
│   ├── Input/
│   ├── Icon/
│   └── Label/
├── molecules/
│   ├── FormField/
│   ├── SearchBar/
│   └── Card/
├── organisms/
│   ├── Header/
│   ├── LoginForm/
│   └── ProductCard/
├── templates/
│   ├── DashboardLayout/
│   └── AuthLayout/
└── pages/
    ├── HomePage/
    └── ProfilePage/
```

### 2. Component Types

**Presentational (Dumb) Components:**
- Focus on how things look
- No state management
- Receive data via props
- Highly reusable

```tsx
// Presentational Button
interface ButtonProps {
  variant?: 'primary' | 'secondary';
  size?: 'sm' | 'md' | 'lg';
  children: React.ReactNode;
  onClick?: () => void;
}

export const Button: React.FC<ButtonProps> = ({
  variant = 'primary',
  size = 'md',
  children,
  onClick,
}) => {
  return (
    <button
      className={`btn btn--${variant} btn--${size}`}
      onClick={onClick}
    >
      {children}
    </button>
  );
};
```

**Container (Smart) Components:**
- Focus on how things work
- Manage state
- Connect to data sources
- Use presentational components

```tsx
// Container Component
export const UserProfileContainer: React.FC = () => {
  const [user, setUser] = useState<User | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetchUser().then(data => {
      setUser(data);
      setLoading(false);
    });
  }, []);

  if (loading) return <LoadingSpinner />;
  if (!user) return <ErrorMessage />;

  return <UserProfile user={user} />;
};
```

### 3. Component Composition

**Build complex components from simple ones.**

```tsx
// Atoms
const Avatar: React.FC<AvatarProps> = ({ src, alt }) => (
  <img className="avatar" src={src} alt={alt} />
);

const Badge: React.FC<BadgeProps> = ({ children }) => (
  <span className="badge">{children}</span>
);

// Molecule (composed of atoms)
const UserBadge: React.FC<UserBadgeProps> = ({ user }) => (
  <div className="user-badge">
    <Avatar src={user.avatar} alt={user.name} />
    <span className="user-badge__name">{user.name}</span>
    <Badge>{user.role}</Badge>
  </div>
);

// Organism (composed of molecules)
const UserList: React.FC<UserListProps> = ({ users }) => (
  <ul className="user-list">
    {users.map(user => (
      <li key={user.id}>
        <UserBadge user={user} />
      </li>
    ))}
  </ul>
);
```

## File Structure

### Standard Component Structure

```
Button/
├── Button.tsx          # Main component
├── Button.test.tsx     # Tests
├── Button.stories.tsx  # Storybook stories
├── Button.module.css   # Styles (CSS Modules)
├── Button.types.ts     # TypeScript types
└── index.ts            # Barrel export
```

### Example Files

**Button/Button.tsx**
```tsx
import React from 'react';
import styles from './Button.module.css';
import { ButtonProps } from './Button.types';

export const Button: React.FC<ButtonProps> = ({
  variant = 'primary',
  size = 'md',
  disabled = false,
  loading = false,
  children,
  onClick,
  ...props
}) => {
  const className = [
    styles.button,
    styles[`button--${variant}`],
    styles[`button--${size}`],
    disabled && styles['button--disabled'],
    loading && styles['button--loading'],
  ].filter(Boolean).join(' ');

  return (
    <button
      className={className}
      disabled={disabled || loading}
      onClick={onClick}
      aria-busy={loading}
      {...props}
    >
      {loading && <span className={styles.spinner} />}
      {children}
    </button>
  );
};
```

**Button/Button.types.ts**
```tsx
export interface ButtonProps
  extends React.ButtonHTMLAttributes<HTMLButtonElement> {
  /** Visual style variant */
  variant?: 'primary' | 'secondary' | 'ghost' | 'danger';

  /** Size variant */
  size?: 'sm' | 'md' | 'lg';

  /** Disabled state */
  disabled?: boolean;

  /** Loading state */
  loading?: boolean;

  /** Button content */
  children: React.ReactNode;

  /** Click handler */
  onClick?: (event: React.MouseEvent<HTMLButtonElement>) => void;
}
```

**Button/Button.test.tsx**
```tsx
import { render, screen, fireEvent } from '@testing-library/react';
import { Button } from './Button';

describe('Button', () => {
  it('renders children correctly', () => {
    render(<Button>Click me</Button>);
    expect(screen.getByText('Click me')).toBeInTheDocument();
  });

  it('handles click events', () => {
    const handleClick = jest.fn();
    render(<Button onClick={handleClick}>Click me</Button>);

    fireEvent.click(screen.getByText('Click me'));
    expect(handleClick).toHaveBeenCalledTimes(1);
  });

  it('applies variant classes', () => {
    render(<Button variant="secondary">Click me</Button>);
    const button = screen.getByText('Click me');
    expect(button).toHaveClass('button--secondary');
  });

  it('disables interaction when loading', () => {
    const handleClick = jest.fn();
    render(<Button loading onClick={handleClick}>Click me</Button>);

    const button = screen.getByText('Click me');
    expect(button).toBeDisabled();
    expect(button).toHaveAttribute('aria-busy', 'true');
  });
});
```

**Button/Button.stories.tsx**
```tsx
import type { Meta, StoryObj } from '@storybook/react';
import { Button } from './Button';

const meta: Meta<typeof Button> = {
  title: 'Components/Button',
  component: Button,
  argTypes: {
    variant: {
      control: 'select',
      options: ['primary', 'secondary', 'ghost', 'danger'],
    },
    size: {
      control: 'select',
      options: ['sm', 'md', 'lg'],
    },
  },
};

export default meta;
type Story = StoryObj<typeof Button>;

export const Primary: Story = {
  args: {
    variant: 'primary',
    children: 'Primary Button',
  },
};

export const Secondary: Story = {
  args: {
    variant: 'secondary',
    children: 'Secondary Button',
  },
};

export const Loading: Story = {
  args: {
    loading: true,
    children: 'Loading...',
  },
};

export const Disabled: Story = {
  args: {
    disabled: true,
    children: 'Disabled Button',
  },
};
```

**Button/index.ts**
```tsx
export { Button } from './Button';
export type { ButtonProps } from './Button.types';
```

## Common Components

### 1. Button Component

```tsx
interface ButtonProps {
  variant?: 'primary' | 'secondary' | 'ghost' | 'danger';
  size?: 'sm' | 'md' | 'lg';
  disabled?: boolean;
  loading?: boolean;
  icon?: React.ReactNode;
  iconPosition?: 'left' | 'right';
  children: React.ReactNode;
  onClick?: () => void;
}
```

### 2. Input Component

```tsx
interface InputProps {
  type?: 'text' | 'email' | 'password' | 'number' | 'tel';
  label?: string;
  placeholder?: string;
  value?: string;
  error?: string;
  helpText?: string;
  required?: boolean;
  disabled?: boolean;
  onChange?: (value: string) => void;
}

export const Input: React.FC<InputProps> = ({
  type = 'text',
  label,
  placeholder,
  value,
  error,
  helpText,
  required,
  disabled,
  onChange,
}) => {
  const id = useId();
  const errorId = `${id}-error`;
  const helpId = `${id}-help`;

  return (
    <div className="input-wrapper">
      {label && (
        <label htmlFor={id} className="input-label">
          {label}
          {required && <span aria-label="required">*</span>}
        </label>
      )}

      <input
        id={id}
        type={type}
        className={`input ${error ? 'input--error' : ''}`}
        placeholder={placeholder}
        value={value}
        disabled={disabled}
        required={required}
        aria-invalid={!!error}
        aria-describedby={error ? errorId : helpText ? helpId : undefined}
        onChange={(e) => onChange?.(e.target.value)}
      />

      {error && (
        <span id={errorId} className="input-error" role="alert">
          {error}
        </span>
      )}

      {helpText && !error && (
        <span id={helpId} className="input-help">
          {helpText}
        </span>
      )}
    </div>
  );
};
```

### 3. Card Component

```tsx
interface CardProps {
  variant?: 'default' | 'outlined' | 'elevated';
  padding?: 'none' | 'sm' | 'md' | 'lg';
  clickable?: boolean;
  children: React.ReactNode;
  onClick?: () => void;
}

export const Card: React.FC<CardProps> = ({
  variant = 'default',
  padding = 'md',
  clickable = false,
  children,
  onClick,
}) => {
  const Component = clickable ? 'button' : 'div';

  return (
    <Component
      className={`card card--${variant} card--padding-${padding}`}
      onClick={onClick}
      role={clickable ? 'button' : undefined}
      tabIndex={clickable ? 0 : undefined}
    >
      {children}
    </Component>
  );
};
```

### 4. Modal Component

```tsx
interface ModalProps {
  open: boolean;
  title?: string;
  size?: 'sm' | 'md' | 'lg' | 'full';
  children: React.ReactNode;
  onClose: () => void;
}

export const Modal: React.FC<ModalProps> = ({
  open,
  title,
  size = 'md',
  children,
  onClose,
}) => {
  useEffect(() => {
    if (open) {
      // Trap focus in modal
      document.body.style.overflow = 'hidden';
      return () => {
        document.body.style.overflow = '';
      };
    }
  }, [open]);

  if (!open) return null;

  return createPortal(
    <div className="modal-overlay" onClick={onClose}>
      <div
        className={`modal modal--${size}`}
        onClick={(e) => e.stopPropagation()}
        role="dialog"
        aria-modal="true"
        aria-labelledby={title ? 'modal-title' : undefined}
      >
        {title && (
          <div className="modal__header">
            <h2 id="modal-title">{title}</h2>
            <button
              className="modal__close"
              onClick={onClose}
              aria-label="Close dialog"
            >
              ×
            </button>
          </div>
        )}

        <div className="modal__body">{children}</div>
      </div>
    </div>,
    document.body
  );
};
```

### 5. Dropdown Component

```tsx
interface DropdownProps {
  trigger: React.ReactNode;
  children: React.ReactNode;
  align?: 'left' | 'right';
}

export const Dropdown: React.FC<DropdownProps> = ({
  trigger,
  children,
  align = 'left',
}) => {
  const [open, setOpen] = useState(false);
  const dropdownRef = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const handleClickOutside = (event: MouseEvent) => {
      if (
        dropdownRef.current &&
        !dropdownRef.current.contains(event.target as Node)
      ) {
        setOpen(false);
      }
    };

    document.addEventListener('mousedown', handleClickOutside);
    return () => document.removeEventListener('mousedown', handleClickOutside);
  }, []);

  return (
    <div className="dropdown" ref={dropdownRef}>
      <button
        className="dropdown__trigger"
        onClick={() => setOpen(!open)}
        aria-expanded={open}
        aria-haspopup="true"
      >
        {trigger}
      </button>

      {open && (
        <div className={`dropdown__menu dropdown__menu--${align}`} role="menu">
          {children}
        </div>
      )}
    </div>
  );
};
```

## Component Patterns

### 1. Compound Components

**Allow components to work together while sharing implicit state.**

```tsx
// Context for shared state
const AccordionContext = createContext<{
  activeIndex: number | null;
  setActiveIndex: (index: number | null) => void;
} | null>(null);

// Parent component
export const Accordion: React.FC<{ children: React.ReactNode }> = ({
  children,
}) => {
  const [activeIndex, setActiveIndex] = useState<number | null>(null);

  return (
    <AccordionContext.Provider value={{ activeIndex, setActiveIndex }}>
      <div className="accordion">{children}</div>
    </AccordionContext.Provider>
  );
};

// Child component
export const AccordionItem: React.FC<{
  index: number;
  title: string;
  children: React.ReactNode;
}> = ({ index, title, children }) => {
  const context = useContext(AccordionContext);
  if (!context) throw new Error('AccordionItem must be used within Accordion');

  const { activeIndex, setActiveIndex } = context;
  const isOpen = activeIndex === index;

  return (
    <div className="accordion-item">
      <button
        className="accordion-item__header"
        onClick={() => setActiveIndex(isOpen ? null : index)}
        aria-expanded={isOpen}
      >
        {title}
      </button>

      {isOpen && <div className="accordion-item__content">{children}</div>}
    </div>
  );
};

// Usage
<Accordion>
  <AccordionItem index={0} title="Section 1">Content 1</AccordionItem>
  <AccordionItem index={1} title="Section 2">Content 2</AccordionItem>
</Accordion>
```

### 2. Render Props

**Pass rendering logic as a prop.**

```tsx
interface DataFetcherProps<T> {
  url: string;
  children: (data: {
    data: T | null;
    loading: boolean;
    error: Error | null;
  }) => React.ReactNode;
}

export function DataFetcher<T>({ url, children }: DataFetcherProps<T>) {
  const [data, setData] = useState<T | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<Error | null>(null);

  useEffect(() => {
    fetch(url)
      .then(res => res.json())
      .then(setData)
      .catch(setError)
      .finally(() => setLoading(false));
  }, [url]);

  return <>{children({ data, loading, error })}</>;
}

// Usage
<DataFetcher<User> url="/api/user">
  {({ data, loading, error }) => {
    if (loading) return <LoadingSpinner />;
    if (error) return <ErrorMessage error={error} />;
    if (!data) return null;
    return <UserProfile user={data} />;
  }}
</DataFetcher>
```

### 3. Custom Hooks Pattern

**Extract reusable logic into custom hooks.**

```tsx
// useToggle hook
export function useToggle(initialValue = false) {
  const [value, setValue] = useState(initialValue);

  const toggle = useCallback(() => setValue(v => !v), []);
  const setTrue = useCallback(() => setValue(true), []);
  const setFalse = useCallback(() => setValue(false), []);

  return { value, toggle, setTrue, setFalse };
}

// Usage in component
export const Modal: React.FC<ModalProps> = ({ children }) => {
  const { value: isOpen, setTrue: open, setFalse: close } = useToggle();

  return (
    <>
      <button onClick={open}>Open Modal</button>
      {isOpen && (
        <div className="modal">
          {children}
          <button onClick={close}>Close</button>
        </div>
      )}
    </>
  );
};
```

## Styling Strategies

### 1. CSS Modules

```css
/* Button.module.css */
.button {
  display: inline-flex;
  align-items: center;
  padding: var(--space-3) var(--space-4);
  border-radius: var(--radius-md);
}

.button--primary {
  background: var(--color-primary);
  color: var(--color-white);
}

.button--secondary {
  background: transparent;
  color: var(--color-primary);
  border: 1px solid var(--color-primary);
}
```

```tsx
import styles from './Button.module.css';

export const Button = ({ variant }) => (
  <button className={`${styles.button} ${styles[`button--${variant}`]}`}>
    Click me
  </button>
);
```

### 2. CSS-in-JS (Styled Components)

```tsx
import styled from 'styled-components';

const StyledButton = styled.button<{ variant: string }>`
  display: inline-flex;
  align-items: center;
  padding: ${({ theme }) => theme.space[3]} ${({ theme }) => theme.space[4]};
  background: ${({ theme, variant }) =>
    variant === 'primary' ? theme.colors.primary : 'transparent'};
  color: ${({ theme, variant }) =>
    variant === 'primary' ? theme.colors.white : theme.colors.primary};
`;

export const Button = ({ variant, children }) => (
  <StyledButton variant={variant}>{children}</StyledButton>
);
```

### 3. Tailwind CSS

```tsx
import clsx from 'clsx';

export const Button: React.FC<ButtonProps> = ({ variant, size, children }) => {
  return (
    <button
      className={clsx(
        'inline-flex items-center rounded-md font-medium',
        {
          'bg-blue-600 text-white hover:bg-blue-700': variant === 'primary',
          'bg-transparent text-blue-600 border border-blue-600': variant === 'secondary',
        },
        {
          'px-3 py-2 text-sm': size === 'sm',
          'px-4 py-2 text-base': size === 'md',
          'px-6 py-3 text-lg': size === 'lg',
        }
      )}
    >
      {children}
    </button>
  );
};
```

## Documentation

### Component Documentation Template

```tsx
/**
 * Button component for triggering actions and navigation.
 *
 * @example
 * ```tsx
 * <Button variant="primary" onClick={handleClick}>
 *   Click me
 * </Button>
 * ```
 *
 * @see {@link https://design-system.example.com/button | Design System Docs}
 */
export const Button: React.FC<ButtonProps> = ({ ... }) => {
  // Implementation
};
```

### Storybook Documentation

```tsx
import type { Meta } from '@storybook/react';
import { Button } from './Button';

const meta: Meta<typeof Button> = {
  title: 'Components/Button',
  component: Button,
  parameters: {
    docs: {
      description: {
        component: `
          Button component for triggering actions.

          ## Usage

          \`\`\`tsx
          import { Button } from '@/components/Button';

          <Button variant="primary">Click me</Button>
          \`\`\`

          ## Accessibility

          - Keyboard accessible
          - Screen reader friendly
          - WCAG 2.1 AA compliant
        `,
      },
    },
  },
};
```

## Testing Strategies

### Unit Tests

```tsx
describe('Button', () => {
  it('renders with correct variant', () => {
    render(<Button variant="primary">Test</Button>);
    expect(screen.getByRole('button')).toHaveClass('button--primary');
  });

  it('calls onClick when clicked', () => {
    const handleClick = jest.fn();
    render(<Button onClick={handleClick}>Test</Button>);

    fireEvent.click(screen.getByRole('button'));
    expect(handleClick).toHaveBeenCalledTimes(1);
  });
});
```

### Accessibility Tests

```tsx
import { axe, toHaveNoViolations } from 'jest-axe';

expect.extend(toHaveNoViolations);

it('has no accessibility violations', async () => {
  const { container } = render(<Button>Test</Button>);
  const results = await axe(container);
  expect(results).toHaveNoViolations();
});
```

### Visual Regression Tests

```tsx
// Using Chromatic or Percy
it('matches snapshot', () => {
  const { container } = render(<Button variant="primary">Test</Button>);
  expect(container).toMatchSnapshot();
});
```

## Performance Optimization

### Code Splitting

```tsx
// Lazy load heavy components
const HeavyComponent = lazy(() => import('./HeavyComponent'));

export const App = () => (
  <Suspense fallback={<LoadingSpinner />}>
    <HeavyComponent />
  </Suspense>
);
```

### Memoization

```tsx
// Memoize expensive components
export const ExpensiveComponent = memo(({ data }) => {
  // Expensive rendering logic
  return <div>{processData(data)}</div>;
});

// Memoize callbacks
const handleClick = useCallback(() => {
  // Handle click
}, [dependencies]);

// Memoize values
const expensiveValue = useMemo(() => {
  return computeExpensiveValue(data);
}, [data]);
```

## Version Control

### Semantic Versioning

```
MAJOR.MINOR.PATCH

1.0.0 → Initial release
1.1.0 → New feature (backwards compatible)
1.1.1 → Bug fix (backwards compatible)
2.0.0 → Breaking change
```

### Changelog

```markdown
# Changelog

## [2.0.0] - 2024-01-15

### Breaking Changes
- Removed `type` prop from Button (use `variant` instead)

### Added
- New `loading` state for Button
- Icon support in Button component

### Fixed
- Button focus indicator contrast ratio

## [1.1.0] - 2024-01-01

### Added
- New Input component
- Card component variants
```

## Resources

- [React Component Patterns](https://kentcdodds.com/blog/compound-components-with-react-hooks)
- [Design Systems Handbook](https://www.designbetter.co/design-systems-handbook)
- [Atomic Design](https://bradfrost.com/blog/post/atomic-web-design/)
- [Storybook Best Practices](https://storybook.js.org/docs/react/writing-docs/introduction)

---

**"Good components are reusable, accessible, and well-documented."**
