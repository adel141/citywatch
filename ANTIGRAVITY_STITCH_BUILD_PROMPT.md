# ANTIGRAVITY_STITCH_BUILD_PROMPT.md

# CityWatch Canada — Antigravity IDE Agent Instructions

Use this Markdown file as the main instruction prompt for **Google Antigravity IDE** when building the app from your Google Stitch design export.

This file is for the Canada-based version of the civic reporting app.

---

## Project Name

**CityWatch Canada**

## Tagline

**Report local issues. Track city action.**

## Project Type

Mobile-first civic issue reporting app for Canadian cities.

The app is similar in concept to “নগর নজর”, but redesigned for a Canada-based city experience.

Sample city for design and mock data:

```text
Toronto, Ontario, Canada
```

---

## Main Goal for Antigravity Agent

Build a production-ready Flutter mobile app from Google Stitch design exports.

The design export contains many screen folders. Each screen folder contains:

```text
code.html
screen.png
```

There may also be both light mode and dark mode versions.

The agent must inspect all Stitch folders before coding.

Use:

```text
screen.png = main visual reference
code.html = layout, spacing, color, typography, label reference
```

Do **not** copy HTML directly into Flutter.

Do **not** create a WebView app.

Recreate the UI using clean native Flutter widgets.

---

## Expected Folder Structure

Recommended local project structure:

```text
citywatch-canada/
│
├── ANTIGRAVITY_STITCH_BUILD_PROMPT.md
│
├── design/
│   ├── light/
│   │   ├── splash/
│   │   │   ├── code.html
│   │   │   └── screen.png
│   │   ├── home/
│   │   │   ├── code.html
│   │   │   └── screen.png
│   │   └── ...
│   │
│   └── dark/
│       ├── splash/
│       │   ├── code.html
│       │   └── screen.png
│       ├── home/
│       │   ├── code.html
│       │   └── screen.png
│       └── ...
│
├── app/
│   └── Flutter app should be created here
│
├── PROGRESS.md
└── README.md
```

If the Stitch folders are named differently, inspect them and map them to the correct app screens.

Do not rename the design folders unless needed.

---

## Important Agent Rules

Before coding:

1. Read this Markdown file fully.
2. Inspect the `design/` folder.
3. List all available Stitch screen folders.
4. Identify light mode and dark mode designs.
5. Create a short implementation plan.
6. Check Git status.
7. Create a new branch for the current stage.
8. Build in small stages.
9. Run analysis/tests before committing.
10. Commit and push frequently.

---

## Safety and Secret Rules

Never commit secrets.

Do not commit:

```text
.env
.env.*
*.key
*.pem
google-services.json
GoogleService-Info.plist
firebase_options.dart
API keys
private credentials
service account files
```

If Firebase config files already exist, ask before committing them.

If terminal commands look destructive, risky, or unrelated to the app build, ask first.

Do not delete user files unless explicitly asked.

Do not force-push unless explicitly asked.

---

## Tech Stack

Use:

```text
Flutter
Dart
Firebase-ready architecture
Mock data first
Flutter Map / OpenStreetMap for maps
GoRouter for routing
Riverpod or simple repository pattern for state/data
```

Firebase will be integrated later.

First build should work with mock data.

---

## Recommended Flutter Dependencies

Add only when needed.

Suggested dependencies:

```bash
flutter pub add go_router
flutter pub add flutter_riverpod
flutter pub add image_picker
flutter pub add geolocator
flutter pub add permission_handler
flutter pub add flutter_map
flutter pub add latlong2
flutter pub add cached_network_image
flutter pub add intl
flutter pub add uuid
flutter pub add google_fonts
```

Firebase-ready dependencies for later:

```bash
flutter pub add firebase_core
flutter pub add firebase_auth
flutter pub add cloud_firestore
flutter pub add firebase_storage
flutter pub add firebase_messaging
```

Do not fully configure Firebase unless Firebase files are provided.

---

## Git Workflow

Use Git from the beginning.

### Check status first

```bash
git status
```

### Initialize Git if needed

```bash
git init
git add .
git commit -m "chore: add Stitch design and Antigravity instructions"
```

### Check remote

```bash
git remote -v
```

If remote exists, push branches.

If remote does not exist, commit locally and tell the user to add a GitHub remote.

---

## Branch Workflow

Do not work directly on `main`.

Use separate branches.

Recommended branches:

```text
setup/flutter-init
feature/design-system
feature/auth-screens
feature/home-and-categories
feature/report-submit-flow
feature/map-and-reports
feature/report-details-comments
feature/profile-alerts
feature/crew-panel
feature/admin-panel
feature/firebase-ready-architecture
fix/ui-polish
```

### Branch command example

```bash
git checkout main
git pull origin main
git checkout -b feature/design-system
```

If `origin` does not exist, skip pull/push but still commit locally.

---

## Commit Rules

Commit after every meaningful unit.

Examples:

```text
chore: initialize Flutter project
feat: add design system and themes
feat: build splash and welcome screens
feat: build auth screens
feat: build home and category screens
feat: build report submission flow
feat: add public map and reports list
feat: add report details and comments
feat: add profile and alerts screens
feat: add city crew screens
feat: add admin dashboard screens
fix: polish dark mode contrast
```

Before each commit:

```bash
flutter analyze
flutter test
```

Then:

```bash
git add .
git commit -m "feat: describe completed work"
git push
```

For a new branch:

```bash
git push -u origin branch-name
```

---

## Progress Tracking

Create and maintain:

```text
PROGRESS.md
```

Update it after each stage.

Include:

```text
Stage completed
Branch name
Commit hash
Files changed
Commands run
flutter analyze result
flutter test result
Known issues
Next stage
```

This helps continue work if Antigravity context becomes full.

---

## Environment Initialization

If no Flutter project exists yet, create it inside `app/`.

From the repository root:

```bash
mkdir -p app
cd app
flutter create . --project-name citywatch_canada --org com.citywatch.canada
flutter pub get
```

Then run:

```bash
flutter doctor
flutter analyze
flutter test
flutter run
```

If Flutter is missing or `flutter doctor` fails, stop and explain exactly what must be installed or fixed.

---

## App Branding

App name:

```text
CityWatch Canada
```

Tagline:

```text
Report local issues. Track city action.
```

Logo idea:

```text
Maple leaf + location pin + city skyline
```

Tone:

```text
Modern
Civic
Canadian
Accessible
Trustworthy
Resident-first
Government-friendly
Clean
Professional
```

---

## Design Style

The UI should look like a premium civic-tech startup app.

Use the Stitch design as the source of truth.

Default design direction:

```text
White/light grey backgrounds
Deep navy text
Maple red accents
Civic blue for trust and links
Green for resolved/success
Orange for in-progress/warnings
Red for urgent/rejected
Rounded cards
Soft shadows
Clean line icons
Accessible contrast
Large touch-friendly controls
Modern sans-serif typography
```

---

## Color Tokens

Use these as default values unless Stitch export has more specific values.

```text
Primary maple red: #D62828
Deep navy: #0B1F3A
Civic blue: #2563EB
Light background: #F7F9FC
Light card: #FFFFFF
Light border: #E5E7EB
Text primary: #111827
Text secondary: #6B7280
Success green: #16A34A
Warning orange: #F59E0B
Danger red: #DC2626
Purple assigned: #7C3AED
```

Dark mode suggestion:

```text
Dark background: #07111F
Dark surface: #0F1E33
Dark card: #16263D
Dark border: #26384F
Dark text primary: #F8FAFC
Dark text secondary: #CBD5E1
```

---

## Theme Requirements

Create:

```text
AppTheme.lightTheme
AppTheme.darkTheme
```

Use:

```text
ThemeMode.system
```

Settings screen should later support:

```text
System
Light
Dark
```

Do not hardcode colors everywhere.

Use centralized design tokens.

Dark mode must be readable and accessible.

---

## Typography

Use a clean modern font.

Recommended:

```text
Inter
SF Pro style
System font
```

If using Google Fonts:

```dart
GoogleFonts.interTextTheme()
```

Keep text readable.

Avoid very small labels.

---

## App Screens to Build

Build all screens from the Stitch design.

### Public / Resident Screens

1. Splash Screen
2. Welcome Screen
3. Login Screen
4. Register Screen
5. Home Screen
6. All Categories Screen
7. Submit Report — Photo Upload
8. Submit Report — Issue Details
9. Submit Report — Location Picker
10. Submit Report Preview
11. Report Success Screen
12. Public Map Screen
13. Reports List Screen
14. Report Details Screen
15. Comments Screen
16. My Reports Screen
17. Alerts / Notifications Screen
18. Profile Screen
19. Settings Screen

### City Crew Screens

20. City Crew Dashboard Screen
21. City Crew Report Update Screen

### Admin Screens

22. Admin Dashboard Screen
23. Admin Report Review Screen
24. Assign Crew Screen
25. Neighbourhood Statistics Screen

If Stitch has additional screens, include them only if they fit the app.

---

## Navigation

Use `go_router`.

Suggested routes:

```text
/
 /welcome
 /login
 /register

 /home
 /categories
 /reports
 /reports/:id
 /reports/:id/comments
 /my-reports
 /alerts
 /profile
 /settings

 /submit/photo
 /submit/details
 /submit/location
 /submit/preview
 /submit/success

 /map

 /crew
 /crew/report/:id/update

 /admin
 /admin/reports/:id/review
 /admin/assign-crew/:reportId
 /admin/neighbourhood-statistics
```

---

## Bottom Navigation

Use bottom navigation for resident app:

```text
Home
Map
Report
Alerts
Profile
```

The center `Report` item should be visually emphasized as a floating plus button.

---

## Issue Categories

Use these categories:

```text
Pothole
Road Damage
Broken Streetlight
Snow & Ice
Garbage Overflow
Graffiti
Sidewalk Damage
Park Maintenance
Drainage / Flooding
Unsafe Intersection
Accessibility Barrier
Transit Stop Issue
Noise Concern
Tree / Branch Hazard
Animal Concern
Other
```

---

## Status System

Use these report statuses:

```text
submitted
underReview
assigned
inProgress
resolved
rejected
closed
duplicate
```

Display labels:

```text
Submitted
Under Review
Assigned
In Progress
Resolved
Rejected
Closed
Duplicate
```

Status colors:

```text
Submitted: grey/blue
Under Review: blue
Assigned: purple
In Progress: orange
Resolved: green
Rejected: red
Closed: grey
Duplicate: grey
```

---

## Mock Data

First version must run fully with mock data.

Create at least:

```text
1 resident user
2 city crew users
1 admin user
16 categories
15 sample reports
8 notifications
8 comments
5 status timeline examples
```

Sample user:

```text
Alex Morgan
Toronto, ON
Verified resident
```

Sample city crew:

```text
Jamie Carter
Road Maintenance
Downtown Toronto
```

Sample admin:

```text
Taylor Brooks
City Operations Admin
Toronto
```

Sample reports:

```text
Large pothole causing traffic slowdown
Streetlight not working near bus stop
Snow and ice blocking sidewalk
Garbage bins overflowing in park
Graffiti on public wall
Sidewalk cracked near school
Water pooling after rainfall
Accessible ramp blocked
Tree branch hanging over sidewalk
Transit shelter glass damaged
```

Sample locations:

```text
Queen St W & Spadina Ave, Toronto, ON
Yonge St & Bloor St, Toronto, ON
Scarborough Town Centre, Toronto, ON
North York Centre, Toronto, ON
High Park, Toronto, ON
Downtown Vancouver, BC
Ottawa Centre, ON
Calgary Beltline, AB
```

---

## Data Models

Create clean Dart models.

### UserModel

```text
id
name
email
phone
photoUrl
role
city
province
neighbourhood
isVerified
createdAt
```

Roles:

```text
resident
crew
admin
```

### ReportModel

```text
id
title
description
categoryId
categoryName
status
priority
locationText
city
province
neighbourhood
latitude
longitude
imageUrls
beforeImageUrl
afterImageUrl
createdBy
assignedCrewId
upvoteCount
commentCount
isPublic
createdAt
updatedAt
```

### CategoryModel

```text
id
name
icon
color
description
```

### CommentModel

```text
id
reportId
userId
userName
userPhotoUrl
text
isCityStaffReply
createdAt
```

### ReportUpdateModel

```text
id
reportId
status
note
imageUrl
updatedBy
updatedAt
```

### NotificationModel

```text
id
title
body
reportId
isRead
createdAt
```

---

## Repository Architecture

Use mock repositories first.

Create interfaces:

```dart
abstract class ReportsRepository {
  Future<List<ReportModel>> getReports();
  Future<ReportModel?> getReportById(String id);
  Future<void> createReport(ReportModel report);
  Future<void> updateReportStatus(String reportId, ReportStatus status);
}
```

Create:

```text
MockReportsRepository
MockAuthRepository
MockNotificationsRepository
MockStorageRepository
```

Later Firebase implementations:

```text
FirebaseReportsRepository
FirebaseAuthRepository
FirebaseNotificationsRepository
FirebaseStorageRepository
```

Do not block UI development on Firebase.

---

## Suggested Flutter Structure

Create this structure:

```text
app/
└── lib/
    ├── main.dart
    │
    ├── app/
    │   ├── citywatch_app.dart
    │   ├── router.dart
    │   └── app_bootstrap.dart
    │
    ├── core/
    │   ├── constants/
    │   │   ├── app_assets.dart
    │   │   ├── app_strings.dart
    │   │   └── app_sizes.dart
    │   ├── theme/
    │   │   ├── app_colors.dart
    │   │   ├── app_theme.dart
    │   │   ├── app_text_styles.dart
    │   │   └── status_colors.dart
    │   ├── utils/
    │   │   ├── date_formatter.dart
    │   │   └── validators.dart
    │   └── widgets/
    │       ├── app_button.dart
    │       ├── app_text_field.dart
    │       ├── app_bottom_nav.dart
    │       ├── app_card.dart
    │       ├── status_badge.dart
    │       ├── category_card.dart
    │       ├── report_card.dart
    │       └── empty_state.dart
    │
    ├── features/
    │   ├── auth/
    │   ├── home/
    │   ├── reports/
    │   ├── map/
    │   ├── alerts/
    │   ├── profile/
    │   ├── crew/
    │   └── admin/
    │
    └── mock/
        ├── mock_categories.dart
        ├── mock_reports.dart
        ├── mock_users.dart
        └── mock_notifications.dart
```

---

## Map Requirements

Use `flutter_map` and `latlong2`.

Default map location:

```text
Toronto, Ontario, Canada
Latitude: 43.6532
Longitude: -79.3832
```

Public map should include:

```text
Issue pins
Category filters
Status filters
Nearby reports bottom sheet
Current location button
Report preview card
```

If location permission is not set up yet, default to Toronto.

---

## Submit Report Flow

Create a multi-step flow:

```text
Photo Upload
Issue Details
Location Picker
Preview
Success
```

Validation:

```text
Category required
Title required
Description required
Location required
Photo optional for mock version
```

Validation messages:

```text
Please select a category.
Please enter an issue title.
Please describe the issue.
Please confirm the location.
```

---

## Admin Screens

Admin dashboard should include:

```text
Total Reports
New Reports
Under Review
In Progress
Resolved
Urgent Reports
Reports by category
Reports by neighbourhood
Resolved vs pending
Recent reports
Urgent reports
```

Admin report review should include:

```text
Report image
Issue details
Location map
Reporter information
Similar nearby reports
Status timeline
Admin notes
Verify button
Reject button
Mark Duplicate button
Assign Crew button
Change Priority button
```

---

## City Crew Screens

Crew dashboard should include:

```text
Crew profile
Assigned reports count
Today’s tasks
Map preview
Assigned reports list
Status badges
```

Crew update screen should include:

```text
Report details
Current status
Status dropdown
Work note
Resolved photo upload placeholder
Submit update button
```

---

## Accessibility Requirements

Design must be accessible.

Use:

```text
High contrast text
Large touch targets
Readable font sizes
Clear focus states where possible
Semantic labels for important buttons
No color-only status meaning
Icons plus text labels
```

---

## Build Order

Follow this exact order.

### Stage 1 — Setup

Branch:

```text
setup/flutter-init
```

Tasks:

```text
Create Flutter app in app/
Add .gitignore
Add dependencies
Create clean folder structure
Create basic app shell
Add light/dark theme foundation
Run analyze/test
Commit and push
```

Commit:

```text
chore: initialize Flutter project
```

---

### Stage 2 — Design System

Branch:

```text
feature/design-system
```

Tasks:

```text
Colors
Typography
Themes
Buttons
Text fields
Cards
Status badges
Bottom navigation
Category cards
Report cards
```

Commit:

```text
feat: add design system
```

---

### Stage 3 — Auth Screens

Branch:

```text
feature/auth-screens
```

Tasks:

```text
Splash
Welcome
Login
Register
Routing
```

Commit:

```text
feat: build auth screens
```

---

### Stage 4 — Home and Categories

Branch:

```text
feature/home-and-categories
```

Tasks:

```text
Home screen
Category grid
Nearby map preview
Recent reports
All categories screen
```

Commit:

```text
feat: build home and categories
```

---

### Stage 5 — Submit Report Flow

Branch:

```text
feature/report-submit-flow
```

Tasks:

```text
Photo upload
Issue details
Location picker
Preview
Success screen
Validation
```

Commit:

```text
feat: build report submission flow
```

---

### Stage 6 — Map and Reports

Branch:

```text
feature/map-and-reports
```

Tasks:

```text
Public map
Reports list
Filters
Markers
Nearby reports bottom sheet
```

Commit:

```text
feat: add map and reports list
```

---

### Stage 7 — Details and Comments

Branch:

```text
feature/report-details-comments
```

Tasks:

```text
Report details
Status timeline
Before/after section
City response note
Comments screen
Upvote and save UI
```

Commit:

```text
feat: add report details and comments
```

---

### Stage 8 — Profile and Alerts

Branch:

```text
feature/profile-alerts
```

Tasks:

```text
My reports
Alerts/notifications
Profile
Settings
Theme setting UI
Language setting UI
```

Commit:

```text
feat: add profile and alerts
```

---

### Stage 9 — Crew Panel

Branch:

```text
feature/crew-panel
```

Tasks:

```text
Crew dashboard
Crew report update screen
Assigned report cards
Status update UI
```

Commit:

```text
feat: add city crew panel
```

---

### Stage 10 — Admin Panel

Branch:

```text
feature/admin-panel
```

Tasks:

```text
Admin dashboard
Admin report review
Assign crew
Neighbourhood statistics
```

Commit:

```text
feat: add admin panel
```

---

### Stage 11 — Firebase Ready Architecture

Branch:

```text
feature/firebase-ready-architecture
```

Tasks:

```text
Repository interfaces
Mock repositories
Firebase service placeholders
Keep app running without Firebase config
```

Commit:

```text
feat: prepare Firebase-ready architecture
```

---

### Stage 12 — UI Polish

Branch:

```text
fix/ui-polish
```

Tasks:

```text
Compare every Flutter screen with Stitch screen.png
Improve spacing
Improve colors
Improve icons
Improve dark mode
Fix overflow
Run analyze/test
```

Commit:

```text
fix: polish UI against Stitch design
```

---

## Final Validation

Before final response, run:

```bash
flutter analyze
flutter test
```

Also run the app if possible:

```bash
flutter run
```

If browser/device preview is available, visually check:

```text
Splash
Home
Submit flow
Map
Report details
Profile
Dark mode
```

---

## Final Response Format for Agent

When a stage is complete, report:

```text
Completed stage:
Branch:
Commit:
Files changed:
Commands run:
flutter analyze:
flutter test:
Screens completed:
Known issues:
Next recommended stage:
```

---

## First Prompt to Give Antigravity Agent

Paste this after adding this Markdown file to the project root:

```text
Read ANTIGRAVITY_STITCH_BUILD_PROMPT.md completely before doing anything.

This project uses Google Stitch design exports. The design folder contains screen folders with code.html and screen.png files for light and dark mode.

Start only with Stage 1.

Do not build a WebView app.
Do not copy HTML directly.
Use native Flutter widgets.
Use mock data first.
Do not configure Firebase yet.
Use Git branches and commit frequently.

First:
1. Inspect the repository structure.
2. Inspect the design folder.
3. Check git status.
4. Create branch setup/flutter-init.
5. Create Flutter project inside app/.
6. Add .gitignore.
7. Add initial dependencies only if needed.
8. Create basic app shell with light/dark theme.
9. Run flutter pub get, flutter analyze, and flutter test.
10. Commit and push if remote exists.

Stop after Stage 1 and report what you completed.
```

---

## Continue Prompt for Next Stages

After Stage 1 is complete, use:

```text
Continue with the next unfinished stage from ANTIGRAVITY_STITCH_BUILD_PROMPT.md.

Before coding:
1. Read PROGRESS.md.
2. Check git status.
3. Check current branch.
4. Check recent commits.
5. Create the correct new branch for the next stage.

Use the Stitch screen.png files as the main visual reference and code.html files for colors, spacing, and layout details.

Build only the next stage.
Run flutter analyze and flutter test.
Commit and push when done.
Update PROGRESS.md.
Stop and report completion.
```
