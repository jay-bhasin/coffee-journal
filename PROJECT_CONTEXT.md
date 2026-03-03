# Coffee Journal Flutter App - Project Context (Updated)

## Overview
This is a local-first Flutter app for coffee brewing journaling (iOS + Android) built with Riverpod, GoRouter, and Drift/SQLite.

Current product focuses on:
- Coffee catalog + metadata
- Entry journaling per coffee with recipe steps
- Global recipe templates
- Editable brew methods
- Local backup/restore (JSON)
- Settings for units + dark mode

## Tech Stack
- Flutter (Material 3)
- `flutter_riverpod`
- `go_router`
- `drift` + `sqlite3_flutter_libs`
- `json_serializable` / `json_annotation`

## Data Layer
Defined in `lib/core/db/database.dart`.

Key tables:
- `coffees`, `entries`, `entry_steps`
- `templates`, `template_steps`
- `tags`, join tables
- `app_settings`
- `brew_methods`

Schema version: **2**.

Notable migration behavior:
- Adds `brew_methods`
- Migrates legacy brew-method names (`other`/`Other`) to `Unspecified`

## Repository Layer
Contracts and implementations:
- `lib/core/repositories/contracts.dart`
- `lib/core/repositories/local_repositories.dart`

Main repositories:
- `CoffeeRepository`
- `EntryRepository`
- `TemplateRepository`
- `BrewMethodRepository`
- `SettingsRepository`
- `BackupRepository`

Important logic:
- Templates are normalized to **global only**
- Deleting a brew method remaps related entries/templates to `Unspecified`
- Backup includes brew methods

## Navigation / Screens
Routes in `lib/app/router.dart`.

Screens:
- Home coffee list: `lib/features/coffees/coffee_list_screen.dart`
- Coffee form: `lib/features/coffees/coffee_form_screen.dart`
- Entry list: `lib/features/entries/entry_list_screen.dart`
- Entry form/edit: `lib/features/entries/entry_form_screen.dart`
- Entry detail: `lib/features/entries/entry_detail_screen.dart`
- Templates: `lib/features/templates/templates_screen.dart`
- Brew methods: `lib/features/brew_methods/brew_methods_screen.dart`
- Settings: `lib/features/settings/settings_screen.dart`
- Backup: `lib/features/settings/backup_screen.dart`

## Current Product Decisions
- Brew methods are DB-driven, editable, alphabetical.
- `Unspecified` is locked and non-deletable.
- Templates are global-only.
- Template can be created from entry (entry list and detail menus).
- Entry detail menu mirrors entry list menu actions.

## Settings
Settings screen currently provides:
- Unit system (metric/imperial)
- Dark mode toggle
- Manage brew methods
- Recipe templates navigation
- Backup/restore navigation

Backup/import UI is in dedicated `BackupScreen`.

## Entry Editing/Display Behavior
### Entry form
- Cached loading future to prevent focus loss while typing.
- Save via app-bar icon and bottom button share one save handler.
- Recipe steps support add/edit/delete/reorder.
- Timeline marker shown next to steps.

### Entry list
- Filters/sort panel toggled from app bar.
- Header shows entry count + sort chip + active filter chips.
- Entry card formatting:
  - Brew method shown as chip
  - Other metadata as regular text
  - Grinder format: `GrindSize (Grinder)`
- Entry menu actions:
  - Star/Unstar
  - Duplicate as today
  - Edit
  - Create template from entry
  - Delete

### Entry detail
- Same menu actions as entry list.
- Star indicator in app bar when starred.
- Timeline-style recipe list with final `End` tile.
- `Start`/`Dur` removed from step subtitle.
- Hides empty fields.
- Suppresses extraction outcome when `unknown`.

## Formatting Rules (Current)
Applied in entry list/detail:
- Temperature: `<number>° C` or `<number>° F`
- Time: `mm:ss`
- Weight: `<number> g`
- Grinder: `GrindSize (Grinder)` when both exist

## Home Screen Aesthetic State
Home screen currently includes:
- `SliverAppBar.large`
- Search toggle in app bar
- Compact metrics strip under search/title showing:
  - distinct roaster count
  - total coffee count
  - distinct brew method count
- Metrics tile layout: label above number
- Section header: `All Coffees (N)` + sort chip
- Active context chips (search only)
- Coffee card metadata chip now combines location as `Region, Country`

## Known UX Rationale
- No avatar circles on coffee tiles (avoids decorative clutter).
- Hero strip retained only where metrics are meaningful and compact.
- Dense chips used selectively to keep information readable on mobile.

## Current Structure
```text
lib/
  app/
    app.dart
    router.dart
  core/
    db/
      database.dart
      database.g.dart
      database_provider.dart
    models/
      enums.dart
      recipe_step_draft.dart
      sensory_notes.dart
      sensory_notes.g.dart
    repositories/
      contracts.dart
      local_repositories.dart
    search/
      search_indexer.dart
    utils/
      brew_time_calculator.dart
      recipe_scaler.dart
      unit_converter.dart
  features/
    brew_methods/
      brew_methods_screen.dart
    coffees/
      coffee_form_screen.dart
      coffee_list_screen.dart
    entries/
      entry_detail_screen.dart
      entry_form_screen.dart
      entry_list_screen.dart
    settings/
      backup_screen.dart
      settings_screen.dart
    templates/
      templates_screen.dart
  main.dart

test/
  brew_time_calculator_test.dart
  recipe_scaler_test.dart
  unit_converter_test.dart
  widget_test.dart
```

## Validation Workflow
Use after changes:
1. `flutter pub run build_runner build --delete-conflicting-outputs` (when schema/model changes)
2. `flutter analyze`
3. `flutter test`
