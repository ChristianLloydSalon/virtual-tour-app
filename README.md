# BueNearby

An awesome way to promote tourist spots in Buenvista, Bohol.

## Getting Started

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

For help getting started with Flutter, view our
[online documentation](https://flutter.dev/docs), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

### Starting Development

- see [Environment Variables](#environment-variables)
- `cd web && yarn install && yarn build` to initialize web files
- `flutter run --web-port 3000` to run development in port 3000

### Environment Variables
#### Initialize (Local)
- run `cp .env.example .env` to create `.env` file
- run `dart env.dart` to create `lib/config/environment.dart` file

### Folder Structure

```bash
  .
  ├── assets
  │   ├── fonts                   # Fonts
  │   ├── images                  # Images
  │   └── icons                   # Icons
  ├── lib
  │   ├── common
  │   │   ├── component           # Reusable Components
  │   │   ├── di                  # Reusable Data Injections
  │   │   ├── helper              # Reusable Helpers
  │   │   ├── service             # Reusable Services
  │   │   ├── state               # Reusable States
  │   │   └── theme               # Theme
  │   ├── <feature/module>
  │   │   ├── data
  │   │   │   ├── remote          # API Calls
  │   │   │   └── repository      # Repository Impelementations
  │   │   ├── di                  # Data Injections
  │   │   ├── domain
  │   │   │   ├── model           # Models
  │   │   │   └── repository      # Abstract Repositories
  │   │   └── presentation
  │   │   │   ├── component       # Components
  │   │   │   ├── screen          # Screens
  │   │   │   └── view_model      # View Models
  │   ├── <feature/module>
  │   └── ...
  ├── test
  │   ├── <feature/module>
  │   └── ...
  └── env.dart                    # Environment variable builder

  Notes
  - Use singular folder name
```

## Git Workflow

### Feature

1. Checkout from `master` to get the latest codebase
2. Create feature branch ie. `feature/name-of-feature`
3. Ready to merge your changes? Create a Merge Request to `master` branch

### Enhancement / Update

1. Checkout from `master` to get the latest codebase
2. Create feature branch ie. `enhancement/name-of-feature`
3. Ready to merge your changes? Create a Merge Request to `master` branch

### Bugfix / Hotfix

1. Checkout from `master` to get the latest codebase
2. Create `bugfix` branch ie. `bugfix/name-of-feature`
3. Ready to merge your changes? Create a Merge Request to `master` branch

## Commit Message

https://www.freecodecamp.org/news/writing-good-commit-messages-a-practical-guide/

### Changelog

- install `changelog` https://github.com/whitecloakph/changelog-sh
- run `change <change-type> <message>` to a changelog entry

#### Change Types

1. added
2. changed
3. deprecated
4. fixed
5. removed
6. security