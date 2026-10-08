import 'package:book_spinner/features/home/presentation/widgets/book_result_card.dart';
import 'package:book_spinner/models/book.dart';
import 'package:book_spinner/models/book_category.dart';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main()
{
  const book = Book(
    id: 'test-book',
    title: 'The Hobbit',
    author: 'J. R. R. Tolkien',
    description:
    'A reluctant hobbit embarks on an unexpected adventure.',
    coverUrl: '',
    category: BookCategory.fantasy,
  );

  group('BookResultCard', ()
  {
    testWidgets('displays book information', (tester) async
    {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BookResultCard(
              book: book,
              onSpinAgain: () {},
            ),
          ),
        ),
      );

      expect(
        find.text('The Hobbit'),
        findsAtLeastNWidgets(1),
      );

      expect(
        find.text('J. R. R. Tolkien'),
        findsAtLeastNWidgets(1),
      );

      expect(
        find.text(
          'A reluctant hobbit embarks on an unexpected adventure.',
        ),
        findsOneWidget,
      );

      expect(
        find.text('FANTASY'),
        findsOneWidget,
      );

      expect(
        find.text('SPIN AGAIN'),
        findsOneWidget,
      );
    });

    testWidgets('calls onSpinAgain when button is pressed', (tester) async
    {
      var wasPressed = false;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BookResultCard(
              book: book,
              onSpinAgain: () {
                wasPressed = true;
              },
            ),
          ),
        ),
      );

      await tester.tap(find.text('SPIN AGAIN'));

      expect(wasPressed, isTrue);
    });

    testWidgets('displays placeholder when cover URL is empty', (tester) async
    {
        await tester.pumpWidget(
          MaterialApp(
            home: Scaffold(
              body: BookResultCard(
                book: book,
                onSpinAgain: () {},
              ),
            ),
          ),
        );

        await tester.pumpAndSettle();

        expect(
          find.byIcon(Icons.auto_stories_rounded),
          findsOneWidget,
        );

        expect(
          find.text('The Hobbit'),
          findsAtLeastNWidgets(1),
        );

        expect(
          find.text('J. R. R. Tolkien'),
          findsAtLeastNWidgets(1),
        );
      },
    );
  });
}