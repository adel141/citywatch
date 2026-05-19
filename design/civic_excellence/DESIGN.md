---
name: Civic Excellence
colors:
  surface: '#f7f9fc'
  surface-dim: '#d8dadd'
  surface-bright: '#f7f9fc'
  surface-container-lowest: '#ffffff'
  surface-container-low: '#f2f4f7'
  surface-container: '#eceef1'
  surface-container-high: '#e6e8eb'
  surface-container-highest: '#e0e3e6'
  on-surface: '#191c1e'
  on-surface-variant: '#5c403d'
  inverse-surface: '#2d3133'
  inverse-on-surface: '#eff1f4'
  outline: '#906f6b'
  outline-variant: '#e5bdb9'
  surface-tint: '#bd1119'
  primary: '#b20112'
  on-primary: '#ffffff'
  primary-container: '#d62828'
  on-primary-container: '#fff1ef'
  inverse-primary: '#ffb4ab'
  secondary: '#4d5f7d'
  on-secondary: '#ffffff'
  secondary-container: '#c8dbfe'
  on-secondary-container: '#4e607e'
  tertiary: '#004cca'
  on-tertiary: '#ffffff'
  tertiary-container: '#2865ed'
  on-tertiary-container: '#f2f3ff'
  error: '#ba1a1a'
  on-error: '#ffffff'
  error-container: '#ffdad6'
  on-error-container: '#93000a'
  primary-fixed: '#ffdad6'
  primary-fixed-dim: '#ffb4ab'
  on-primary-fixed: '#410002'
  on-primary-fixed-variant: '#93000d'
  secondary-fixed: '#d6e3ff'
  secondary-fixed-dim: '#b5c7ea'
  on-secondary-fixed: '#071c36'
  on-secondary-fixed-variant: '#364764'
  tertiary-fixed: '#dbe1ff'
  tertiary-fixed-dim: '#b4c5ff'
  on-tertiary-fixed: '#00174b'
  on-tertiary-fixed-variant: '#003ea8'
  background: '#f7f9fc'
  on-background: '#191c1e'
  surface-variant: '#e0e3e6'
typography:
  display-lg:
    fontFamily: Inter
    fontSize: 32px
    fontWeight: '700'
    lineHeight: 40px
    letterSpacing: -0.02em
  display-lg-mobile:
    fontFamily: Inter
    fontSize: 28px
    fontWeight: '700'
    lineHeight: 36px
    letterSpacing: -0.02em
  headline-md:
    fontFamily: Inter
    fontSize: 24px
    fontWeight: '600'
    lineHeight: 32px
  headline-sm:
    fontFamily: Inter
    fontSize: 20px
    fontWeight: '600'
    lineHeight: 28px
  body-lg:
    fontFamily: Inter
    fontSize: 18px
    fontWeight: '400'
    lineHeight: 28px
  body-md:
    fontFamily: Inter
    fontSize: 16px
    fontWeight: '400'
    lineHeight: 24px
  body-sm:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '400'
    lineHeight: 20px
  label-md:
    fontFamily: Inter
    fontSize: 14px
    fontWeight: '600'
    lineHeight: 16px
    letterSpacing: 0.01em
  label-sm:
    fontFamily: Inter
    fontSize: 12px
    fontWeight: '500'
    lineHeight: 16px
rounded:
  sm: 0.25rem
  DEFAULT: 0.5rem
  md: 0.75rem
  lg: 1rem
  xl: 1.5rem
  full: 9999px
spacing:
  base: 4px
  xs: 4px
  sm: 8px
  md: 16px
  lg: 24px
  xl: 32px
  container-margin: 20px
  gutter: 12px
---

## Brand & Style

The design system is engineered for **CityWatch Canada**, a civic-tech platform that bridges the gap between residents and municipal governance. The brand personality is rooted in **trustworthy professionalism** and **modern accessibility**. It avoids the bureaucratic coldness of traditional government software, instead opting for a "startup-refined" aesthetic that feels responsive and high-utility.

The visual style follows a **Modern Corporate** direction with subtle **Minimalist** influences. It prioritizes clarity and high legibility to ensure users of all technological proficiencies can report issues effectively. Key visual signatures include:
- **Clarity over Ornamentation:** Functional white space and clear grouping.
- **Soft Geometry:** A balance of structured layouts with approachable rounded corners.
- **Civic Pride:** Subtle integration of Canadian motifs (maple leaf iconography, city-specific color accents) used sparingly to maintain premium status.
- **High-Velocity Utility:** Large touch targets and intuitive navigation patterns designed for "on-the-go" usage.

## Colors

The palette is anchored by **Primary Maple Red**, used strictly for brand moments, primary calls-to-action, and critical alerts to maintain its impact. **Deep Navy** provides the structural foundation, used for persistent navigation and high-level typography to evoke stability.

**Color Application Rules:**
- **The 60-30-10 Rule:** 60% Neutral/Background, 30% Deep Navy (Text/UI accents), 10% Primary Red or Civic Blue.
- **Semantic Clarity:** Status colors are non-negotiable. "Resolved" issues must always use the Success Green, while "Under Review" leverages Civic Blue to signal active processing.
- **Dark Mode:** Transition surfaces from light grays to deep slate blues (`#0F172A`) rather than pure black to maintain depth and reduce eye strain during nighttime reporting.

## Typography

This design system utilizes **Inter** for its exceptional legibility and neutral, modern character. The hierarchy is "top-heavy," using large bold headlines to give users immediate context upon landing on a screen.

**Usage Guidelines:**
- **Headlines:** Use Deep Navy for all headlines. Display-lg is reserved for main dashboard welcomes or empty-state titles.
- **Body Text:** Use a slightly reduced contrast (Slate 700) for body-md to keep the interface feeling light and airy.
- **Labels:** Label-sm (uppercase) is specifically for small metadata, like timestamps on reports or category tags.
- **Accessibility:** Ensure a minimum contrast ratio of 4.5:1 for all body text against its respective background.

## Layout & Spacing

The layout utilizes a **Fluid Grid** model optimized for mobile-first interaction. 

- **Mobile (Default):** A 4-column grid with 20px outside margins and 12px gutters.
- **Vertical Rhythm:** Use an 8px base unit (e.g., 8, 16, 24, 32) for all padding and margins to ensure a consistent visual cadence.
- **Safe Areas:** All critical actions (like the Floating Action Button) must respect a 24px bottom safe-area margin to avoid interference with OS-level home indicators.
- **Touch Targets:** No interactive element (links, buttons, icons) should be smaller than 44x44px.

## Elevation & Depth

This design system uses **Tonal Layers** combined with **Ambient Shadows** to create a sense of organized hierarchy.

- **Level 0 (Base):** The background color (`#F7F9FC`).
- **Level 1 (Cards):** White background with a soft, diffused shadow (Y: 2px, Blur: 8px, Opacity: 4% Black). Used for secondary information.
- **Level 2 (Active/Floating):** White background with a more pronounced shadow (Y: 4px, Blur: 12px, Opacity: 8% Navy). Used for the bottom navigation bar and primary action cards.
- **Interactive States:** On press, elements should visually "sink" (reduce elevation) to provide tactile feedback.

## Shapes

The shape language is **Rounded**, conveying friendliness and modern tech sensibilities.

- **Standard Elements:** Buttons, input fields, and small cards use a **0.5rem (8px)** radius.
- **Large Containers:** Dashboard summaries and image cards use a **1rem (16px)** radius to create a soft, approachable framing.
- **Action Pills:** The "Report" button and status badges use a full **Pill (999px)** radius to distinguish them as high-priority interactive or status-indicating elements.

## Components

### Buttons
- **Primary:** Maple Red background, white text. Bold weight. 
- **Secondary:** Transparent background, Navy border (1px), Navy text.
- **Report FAB:** A large, central pill in the bottom navigation. Uses Maple Red with a white "+" icon. It should sit slightly higher than the other nav items (optical protrusion).

### Status Badges
- Small pill-shaped tags. 
- **Style:** Light tinted background (10% opacity of the semantic color) with high-contrast text of the same hue (e.g., Light Green bg with Dark Green text).

### Form Fields
- 56px height for touch-friendliness.
- 1px border (`#E2E8F0`). On focus, the border transitions to Civic Blue with a 2px stroke.
- Labels are always visible (not floating) using `label-md`.

### Cards
- Used for issue listings. Includes a 1:1 aspect ratio thumbnail on the left, title and status in the center, and a chevron on the right.
- Padding should be a consistent 16px (`md`).

### Bottom Navigation
- Fixed height of 64px + safe area.
- Deep Navy icons for inactive states; Civic Blue or Maple Red for active.
- Labels are required below icons for accessibility (`label-sm`).