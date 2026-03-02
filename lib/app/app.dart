import 'package:coffee_journal/app/router.dart';
import 'package:flutter/material.dart';

class CoffeeJournalApp extends StatelessWidget {
  const CoffeeJournalApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Coffee Journal',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF8A5A3B)),
        useMaterial3: true,
      ),
      routerConfig: appRouter,
    );
  }
}
