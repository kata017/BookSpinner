import 'package:book_spinner/models/book_category.dart';
import 'package:book_spinner/repositories/mock_book_repository.dart';

import 'package:flutter_test/flutter_test.dart';

void main()
{
  group('MockBookRepository', ()
  {
    const repository = MockBookRepository();

    test('returns all mock books', () async
    {
      final books = await repository.getBooks();

      expect(books, isNotEmpty);
      expect(books.length, 8);
    });

    test('returns only books from the requested category', () async
    {
      final books = await repository.getBooksByCategory(BookCategory.fantasy);

      expect(books, isNotEmpty);

      for (final book in books)
      {
        expect(book.category, BookCategory.fantasy);
      }
    });

    test('returns The Hobbit for fantasy category', () async
    {
      final books = await repository.getBooksByCategory(BookCategory.fantasy);
      expect(books.any((book) => book.title == 'The Hobbit'), isTrue);
    });
  });
}