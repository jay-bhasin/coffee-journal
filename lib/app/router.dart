import 'package:coffee_journal/features/coffees/coffee_form_screen.dart';
import 'package:coffee_journal/features/coffees/coffee_list_screen.dart';
import 'package:coffee_journal/features/brew_methods/brew_methods_screen.dart';
import 'package:coffee_journal/features/entries/entry_detail_screen.dart';
import 'package:coffee_journal/features/entries/entry_form_screen.dart';
import 'package:coffee_journal/features/settings/backup_screen.dart';
import 'package:coffee_journal/features/entries/entry_list_screen.dart';
import 'package:coffee_journal/features/settings/settings_screen.dart';
import 'package:coffee_journal/features/templates/template_form_screen.dart';
import 'package:coffee_journal/features/templates/templates_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final appRouter = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const CoffeeListScreen(),
      routes: [
        GoRoute(
          path: 'coffee/new',
          builder: (context, state) => const CoffeeFormScreen(),
        ),
        GoRoute(
          path: 'coffee/:coffeeId/edit',
          builder: (context, state) => CoffeeFormScreen(
            coffeeId: state.pathParameters['coffeeId'],
          ),
        ),
        GoRoute(
          path: 'coffee/:coffeeId',
          builder: (context, state) => EntryListScreen(
            coffeeId: state.pathParameters['coffeeId']!,
          ),
          routes: [
            GoRoute(
              path: 'entry/new',
              builder: (context, state) => EntryFormScreen(
                coffeeId: state.pathParameters['coffeeId']!,
                duplicateFromEntryId: state.uri.queryParameters['duplicateFrom'],
                templateId: state.uri.queryParameters['templateId'],
              ),
            ),
            GoRoute(
              path: 'entry/:entryId/edit',
              builder: (context, state) => EntryFormScreen(
                coffeeId: state.pathParameters['coffeeId']!,
                entryId: state.pathParameters['entryId']!,
              ),
            ),
          ],
        ),
        GoRoute(
          path: 'entry/:entryId',
          builder: (context, state) =>
              EntryDetailScreen(entryId: state.pathParameters['entryId']!),
        ),
        GoRoute(
          path: 'templates',
          builder: (context, state) => TemplatesScreen(
            isPickerMode: state.uri.queryParameters['picker'] == '1',
          ),
          routes: [
            GoRoute(
              path: 'new',
              builder: (context, state) => const TemplateFormScreen(),
            ),
            GoRoute(
              path: ':templateId/edit',
              builder: (context, state) =>
                  TemplateFormScreen(templateId: state.pathParameters['templateId']!),
            ),
          ],
        ),
        GoRoute(
          path: 'settings',
          builder: (context, state) => const SettingsScreen(),
        ),
        GoRoute(
          path: 'backup',
          builder: (context, state) => const BackupScreen(),
        ),
        GoRoute(
          path: 'brew-methods',
          builder: (context, state) => const BrewMethodsScreen(),
        ),
      ],
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    appBar: AppBar(title: const Text('Not found')),
    body: Center(child: Text(state.error.toString())),
  ),
);
