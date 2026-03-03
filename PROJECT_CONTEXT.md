# Coffee Journal Flutter App - Project Context

## Overview
This project was created as a local-first Flutter mobile app (iOS + Android) for tracking coffee brewing journals. It follows a structured data model with SQLite persistence, typed repositories, and feature-oriented UI modules.

Core goals implemented:
- Coffee catalog with metadata and tags
- Per-coffee journal entries with brewing details and recipe steps
- Recipe templates (global and per-coffee)
- Starred entries sorting and entry filtering
- Unit preference setting (metric/imperial display preference)
- JSON export/import backup flow
- Test coverage for core brewing logic utilities

## Original Plan (Implementation Intent)
The app was built around these decisions:
- **Architecture:** Flutter + Riverpod + GoRouter + Drift (SQLite)
- **Storage:** Local SQLite only (no auth/cloud sync in v1)
- **Data model:** `Coffee`, `JournalEntry`, `RecipeStep`, `RecipeTemplate`, `Tag`
- **Recipe approach:** Hybrid typed steps + custom step support
- **Entry ordering:** Starred-first then newest-first by default
- **Backup:** Manual JSON export/import with preview
- **Units:** Metric canonical values in storage, with unit-system preference

## What Was Implemented (Step-by-Step)

### 1. Project scaffolding
- Generated a fresh Flutter app in this workspace.
- Added dependencies for state management, routing, database, serialization, and testing support.

### 2. Core dependencies and config
`pubspec.yaml` was updated to include:
- Runtime: `flutter_riverpod`, `go_router`, `drift`, `sqlite3_flutter_libs`, `path_provider`, `path`, `json_annotation`, `intl`, `uuid`
- Dev: `drift_dev`, `build_runner`, `json_serializable`, `flutter_lints`

### 3. Domain models and utilities
Created foundational model and utility files:
- Enums for methods, step types, outcomes, template scope, unit system, sort options
- `RecipeStepDraft` as editor/repository transfer object
- `SensoryNotes` JSON model
- `RecipeScaler` for ratio and proportional pour redistribution
- `BrewTimeCalculator` for auto brew-time derivation
- `UnitConverter` for unit conversion helpers
- `SearchIndexer` for normalized search text/token building

### 4. SQLite schema (Drift)
Implemented `lib/core/db/database.dart` with tables:
- `coffees`, `entries`, `entry_steps`
- `templates`, `template_steps`
- `tags`, `coffee_tags`, `entry_tags`, `template_tags`
- `app_settings`

Added indexes and foreign-key cascade relationships matching the intended behavior.

### 5. Repository layer
Defined repository contracts and local implementations:
- `CoffeeRepository`
- `EntryRepository`
- `TemplateRepository`
- `SettingsRepository`
- `BackupRepository`

Implemented local logic for:
- CRUD operations
- Tag normalization/de-duplication
- Entry duplication to a new day
- Filter/sort queries (including starred-first mode)
- JSON export/import with schema version check and conflict handling strategy

### 6. Providers
Created Riverpod providers to wire:
- Database singleton lifecycle
- Repository implementations
- Utility services (`RecipeScaler`, `BrewTimeCalculator`, etc.)

### 7. Navigation and app shell
- Replaced default counter app with app shell + GoRouter routes.
- Added routes for coffee list/form, entry list/detail/form, templates, and settings.

### 8. UI feature screens
Implemented feature screens:
- Coffee list with search/sort + CRUD actions
- Coffee form for metadata + tags
- Entry list with sort/filter/star/duplicate/delete
- Entry detail view for full read-only data
- Entry form/editor with recipe steps, ratio lock option, and sensory fields
- Templates screen with global/per-coffee tabs and template creation
- Settings with unit preference and JSON backup/import preview flow

### 9. Code generation and quality checks
- Ran `build_runner` for Drift and JSON generated files.
- Fixed analyzer issues due to API changes and typing.
- Ran `flutter analyze` and ensured clean output.
- Added/updated tests and ensured `flutter test` passes.

### 10. Bug fix after manual testing
A runtime cast error occurred when editing entries without recipe steps:
- Error: `type 'List<dynamic>' is not a subtype of type 'List<RecipeStepDraft>'`
- Cause: `FutureBuilder` and `loadFuture()` were typed as `dynamic`, allowing runtime list inference.
- Fix: made the edit loader fully typed:
  - `Future<EntryRecord?> loadFuture()`
  - `FutureBuilder<EntryRecord?>`
  - explicit typed mapping `.map<RecipeStepDraft>(...)`
- Post-fix: `flutter analyze` passed.

## Current Project Structure

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
    coffees/
      coffee_form_screen.dart
      coffee_list_screen.dart
    entries/
      entry_detail_screen.dart
      entry_form_screen.dart
      entry_list_screen.dart
    settings/
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

## Important Behavior Notes for Future Iteration
- Entry editor supports recipe steps but currently uses a straightforward dialog-based step editor.
- Unit-system preference is stored in settings, while data remains metric in storage.
- Import uses a conflict strategy that creates new IDs and stores ID mapping metadata.
- Template CRUD is present; richer “apply template directly to entry draft” UX can be expanded.
- Search is normalized text-based and local; can evolve into FTS if needed.

## How to Continue (for another model/engineer)
1. Run `flutter pub get`.
2. Run `flutter pub run build_runner build --delete-conflicting-outputs` if generated files drift.
3. Run `flutter analyze` and `flutter test`.
4. Prioritize next enhancements from this baseline:
   - stronger template-to-entry workflow
   - richer validation per brew method
   - charts/analytics
   - cloud sync layer on top of existing repository contracts
