import 'package:book_spinner/models/book_category.dart';
import 'package:book_spinner/repositories/firebase_book_repository.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';

void main()
{
  late FakeFirebaseFirestore firestore;
  late FirebaseBookRepository repository;

  setUp(()
  {
    firestore = FakeFirebaseFirestore();
    repository = FirebaseBookRepository(firestore: firestore);
  });

  group('FirebaseBookRepository', ()
  {
    test('getBooks returns books from Firestore', () async
    {
      await firestore.collection('books').doc('the-hobbit').set({
        'title': 'The Hobbit',
        'author': 'J. R. R. Tolkien',
        'description': 'A fantasy adventure.',
        'coverUrl': '',
        'category': 'fantasy',
      });

      final books = await repository.getBooks();

      expect(books, hasLength(1));
      expect(books.first.id, 'the-hobbit');
      expect(books.first.title, 'The Hobbit');
      expect(books.first.author, 'J. R. R. Tolkien');
      expect(books.first.category, BookCategory.fantasy);
    });

    test('getBooksByCategory returns only matching books', () async
    {
      await firestore.collection('books').doc('the-hobbit').set({
        'title': 'The Hobbit',
        'author': 'J. R. R. Tolkien',
        'description': 'A fantasy adventure.',
        'coverUrl': '',
        'category': 'fantasy',
      });

      await firestore.collection('books').doc('dune').set({
        'title': 'Dune',
        'author': 'Frank Herbert',
        'description': 'A science fiction novel.',
        'coverUrl': '',
        'category': 'sci-fi',
      });

      final books = await repository.getBooksByCategory(BookCategory.fantasy);

      expect(books, hasLength(1));
      expect(books.first.id, 'the-hobbit');
      expect(books.first.category, BookCategory.fantasy);
    });

    test('getBooks returns an empty list when Firestore is empty', () async
    {
      final books = await repository.getBooks();

      expect(books, isEmpty);
    });

    test('unknown category throws StateError', () async
    {
      await firestore.collection('books').doc('unknown').set({
        'title': 'Unknown Book',
        'author': 'Unknown Author',
        'description': 'Unknown category.',
        'coverUrl': '',
        'category': 'adventure',
      });

      expect(() => repository.getBooks(), throwsA(isA<StateError>()),
      );
    });
  });
}