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
- Entry creation from blank or template

## Tech Stack
- Flutter (Material 3)
- `flutter_riverpod` (v3.x)
- `go_router` (v17.x)
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

Schema version: **3**.

Notable migration behavior:
- Adds `brew_methods`
- Migrates legacy brew-method names (`other`/`Other`) to `Unspecified`
- Converts `coffees.altitude_m` from numeric (`REAL`) to text (`TEXT`) while preserving existing values

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

State providers:
- `unitSystemProvider`: `FutureProvider`
- `themeModeProvider`: Riverpod 3 `NotifierProvider` (`ThemeModeController extends Notifier<ThemeMode>`)

Important logic:
- Templates are normalized to **global only**
- Deleting a brew method remaps related entries/templates to `Unspecified`
- Backup includes brew methods
- `TemplateRepository` now supports `getById(...)` for template editing and entry prefill
- Backup import tolerates old numeric altitude values and normalizes them to text
- `CoffeeRecord` includes a derived nullable `lastEntryAt` sourced from the latest `entries.brewAt`
- Coffee list `updatedAt` sort option is presented as **Recent activity** and orders by:
  - latest `lastEntryAt` when a coffee has entries
  - otherwise `coffee.updatedAt`
  - then coffee name as a stable tie-breaker

## Navigation / Screens
Routes in `lib/app/router.dart`.

Screens:
- Home coffee list: `lib/features/coffees/coffee_list_screen.dart`
- Coffee form: `lib/features/coffees/coffee_form_screen.dart`
- Entry list: `lib/features/entries/entry_list_screen.dart`
- Entry form/edit: `lib/features/entries/entry_form_screen.dart`
- Entry detail: `lib/features/entries/entry_detail_screen.dart`
- Templates: `lib/features/templates/templates_screen.dart`
- Template form/edit: `lib/features/templates/template_form_screen.dart`
- Brew methods: `lib/features/brew_methods/brew_methods_screen.dart`
- Settings: `lib/features/settings/settings_screen.dart`
- Backup: `lib/features/settings/backup_screen.dart`

## Current Product Decisions
- Brew methods are DB-driven, editable, alphabetical.
- `Unspecified` is locked and non-deletable.
- Templates are global-only.
- Template can be created from entry (entry list and detail menus).
- Entry detail menu mirrors entry list menu actions.
- New entry flow on entry list FAB is a chooser:
  - Blank entry
  - From template (template picker + prefilled entry form)

## Dependency State (Latest Update)
- Ran:
  1. `flutter pub upgrade`
  2. `flutter pub upgrade --major-versions`
- Key direct dependency upgrades:
  - `flutter_riverpod`: `2.6.1 -> 3.2.1`
  - `go_router`: `16.3.0 -> 17.1.0`
  - `sqlite3_flutter_libs`: `0.5.42 -> 0.6.0+eol`
  - `build_runner`: `2.11.1 -> 2.12.2`
- Compatibility changes applied:
  - Replaced legacy Riverpod `StateNotifierProvider` usage for theme mode with `NotifierProvider`
  - Replaced `AsyncValue.valueOrNull` call sites with `maybeWhen(...)` pattern
- Post-upgrade validation:
  - `flutter analyze` passes
  - `flutter test` passes

## Generated File Notes
- After dependency upgrades, Flutter regenerated plugin registrant files for desktop targets.
- Typical changed files include:
  - `linux/flutter/generated_plugin_registrant.cc`
  - `linux/flutter/generated_plugins.cmake`
  - `macos/Flutter/GeneratedPluginRegistrant.swift`
  - `windows/flutter/generated_plugin_registrant.cc`
  - `windows/flutter/generated_plugins.cmake`
- These are expected generated updates and can be committed when dependency/plugin graph changes.

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
- Supports seed loading from:
  - Existing entry (edit)
  - Duplicate source entry
  - Template (`templateId` query param)

### Entry list
- Filters/sort panel toggled from app bar.
- Top header includes a shared coffee summary card widget.
- Header shows entry count + sort chip + active method filter chip.
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
- Top of page uses the same shared coffee summary card as entry list.
- Detail content is now sectioned into:
  - heading row with brew date/time and brew method chip
  - extraction outcome and starred chips
  - recipe details grid
  - recipe steps timeline
  - results grid
  - sensory grid
- Star indicator in app bar when starred.
- Timeline-style recipe list with final `End` tile.
- `Start`/`Dur` removed from step subtitle.
- Hides empty fields.
- Suppresses extraction outcome when `unknown`.
- Template-name prompt uses controller-free dialog input to avoid disposed-controller crashes
- Espresso-specific values (`yield`, `pressure`, `preinfusion`) appear in the recipe details grid when present

## Formatting Rules (Current)
Applied in entry list/detail:
- Shared display formatting now lives in `lib/core/utils/display_formatters.dart`
- Temperature: `<number> °C` or `<number> °F`
- Time: `mm:ss`
- Weight: `<number> g`
- Grinder: `GrindSize (Grinder)` when both exist
- Pressure and extraction-outcome labels are also formatted from the shared display formatter

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
- Sort label `Recent activity` maps to derived coffee activity, not just coffee-record edits
- Active context chips (search only)
- Coffee card metadata chip now combines location as `Region, Country`
- Coffee card metadata chips: `Region, Country`, `Varietal`, `Process`
- Altitude is shown as plain text metadata (not a chip)
- Tasting notes appear above tag text and use a slightly larger text style (`bodyMedium`)
- Coffee cards show `Last entry <date>` only when the coffee has at least one entry
- Shared coffee summary card matches the home card typography for name/roaster and shows the full coffee metadata set:
  - chips: `Region, Country`, `Varietal`, `Process`
  - supporting lines: farm, producer, altitude, roast date, tags
  - tasting notes as body text

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
      display_formatters.dart
      recipe_scaler.dart
      unit_converter.dart
  features/
    brew_methods/
      brew_methods_screen.dart
    coffees/
      coffee_form_screen.dart
      coffee_list_screen.dart
      widgets/
        coffee_summary_card.dart
    entries/
      entry_detail_screen.dart
      entry_form_screen.dart
      entry_list_screen.dart
    settings/
      backup_screen.dart
      settings_screen.dart
    templates/
      template_form_screen.dart
      templates_screen.dart
  main.dart

test/
  brew_time_calculator_test.dart
  coffee_list_screen_test.dart
  coffee_repository_test.dart
  recipe_scaler_test.dart
  unit_converter_test.dart
  widget_test.dart
```

## Validation Workflow
Use after changes:
1. `dart run build_runner build --delete-conflicting-outputs` (when schema/model changes)
2. `flutter analyze`
3. `flutter test`
