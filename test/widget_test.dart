import 'package:book_spinner/core/navigation/app_router.dart';
import 'package:book_spinner/features/home/presentation/home_page.dart';
import 'package:book_spinner/repositories/mock_book_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main()
{
  testWidgets('BookSpinner app loads', (WidgetTester tester) async
  {
    await tester.pumpWidget(
      MaterialApp(
        home: HomePage(
          repository: const MockBookRepository(),
        ),
      ),
    );

    await tester.pump();

    expect(find.byType(HomePage), findsOneWidget);
    expect(find.text('Your next book is one spin away.'), findsOneWidget);
  });

  testWidgets('Navigation items are visible', (WidgetTester tester) async
  {
    final router = AppRouter.createRouter(repository: const MockBookRepository());

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
      ),
    );

    expect(find.text('BookSpinner'), findsOneWidget);
    expect(find.text('Discover'), findsOneWidget);
    expect(find.text('Library'), findsOneWidget);
    expect(find.text('About'), findsOneWidget);
  });

  testWidgets('Library navigation works', (WidgetTester tester) async
  {
    final router = AppRouter.createRouter(repository: const MockBookRepository());

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
      ),
    );

    await tester.tap(find.text('Library'));
    await tester.pumpAndSettle();

    expect(find.text('LIBRARY'), findsOneWidget);
  });

  testWidgets('About navigation works', (WidgetTester tester) async
  {
    final router = AppRouter.createRouter(repository: const MockBookRepository());

    await tester.pumpWidget(
      MaterialApp.router(
        routerConfig: router,
      ),
    );

    await tester.tap(find.text('About'));
    await tester.pumpAndSettle();

    expect(find.text('ABOUT'), findsOneWidget);
  });
}