import 'package:flutter_test/flutter_test.dart';
import 'package:book_spinner/main.dart';

void main()
{
  testWidgets('BookSpinner app loads', (WidgetTester tester) async
  {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const BookSpinnerApp());

    expect(find.text('DISCOVER YOUR\nNEXT CHAPTER'), findsOneWidget);
    expect(find.text('Your next book is one spin away.'), findsOneWidget);
    expect(find.text('SPIN IT'), findsOneWidget);
  });

  testWidgets('Navigation items are visible', (WidgetTester tester) async
  {
    await tester.pumpWidget(const BookSpinnerApp());

    expect(find.text('BookSpinner'), findsOneWidget);
    expect(find.text('Discover'), findsOneWidget);
    expect(find.text('Library'), findsOneWidget);
    expect(find.text('About'), findsOneWidget);
  });

  testWidgets('Library navigation works', (WidgetTester tester) async
  {
    await tester.pumpWidget(const BookSpinnerApp());

    await tester.tap(find.text('Library'));
    await tester.pumpAndSettle();

    expect(find.text('LIBRARY'), findsOneWidget);
  });

  testWidgets('About navigation works', (WidgetTester tester) async
  {
    await tester.pumpWidget(const BookSpinnerApp());

    await tester.tap(find.text('About'));
    await tester.pumpAndSettle();

    expect(find.text('ABOUT'), findsOneWidget);
  });
}