import 'package:coffee_journal/app/app.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  testWidgets('App smoke test renders coffee journal title', (tester) async {
    await tester.pumpWidget(const ProviderScope(child: CoffeeJournalApp()));
    await tester.pump(const Duration(milliseconds: 200));
    expect(find.byType(CoffeeJournalApp), findsOneWidget);
  });
}
