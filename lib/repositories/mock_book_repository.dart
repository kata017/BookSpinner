import 'package:book_spinner/models/book.dart';
import 'package:book_spinner/models/book_category.dart';
import 'package:book_spinner/repositories/book_repository.dart';

class MockBookRepository implements BookRepository
{
  const MockBookRepository();

  static const List<Book> _books =
  [
    Book(
      id: '1',
      title: 'The Hobbit',
      author: 'J. R. R. Tolkien',
      description:
      'A reluctant hobbit embarks on an unexpected adventure.',
      coverUrl: '',
      category: BookCategory.fantasy,
    ),
    Book(
      id: '2',
      title: 'Dune',
      author: 'Frank Herbert',
      description:
      'A young heir becomes involved in a struggle for control of a desert planet.',
      coverUrl: '',
      category: BookCategory.sciFi,
    ),
    Book(
      id: '3',
      title: 'The Silent Patient',
      author: 'Alex Michaelides',
      description:
      'A famous painter stops speaking after a shocking crime.',
      coverUrl: '',
      category: BookCategory.mystery,
    ),
    Book(
      id: '4',
      title: 'Pride and Prejudice',
      author: 'Jane Austen',
      description:
      'A classic story about relationships, society and first impressions.',
      coverUrl: '',
      category: BookCategory.romance,
    ),
    Book(
      id: '5',
      title: 'The Great Gatsby',
      author: 'F. Scott Fitzgerald',
      description:
      'A mysterious millionaire and a vanished dream in 1920s America.',
      coverUrl: '',
      category: BookCategory.fiction,
    ),
    Book(
      id: '6',
      title: 'Steve Jobs',
      author: 'Walter Isaacson',
      description:
      'The story of one of the most influential figures in technology.',
      coverUrl: '',
      category: BookCategory.biography,
    ),
    Book(
      id: '7',
      title: 'Sapiens',
      author: 'Yuval Noah Harari',
      description:
      'A journey through the history of humankind.',
      coverUrl: '',
      category: BookCategory.history,
    ),
    Book(
      id: '8',
      title: 'The Girl with the Dragon Tattoo',
      author: 'Stieg Larsson',
      description:
      'A journalist and a hacker investigate a decades-old disappearance.',
      coverUrl: '',
      category: BookCategory.thriller,
    ),
  ];

  @override
  Future<List<Book>> getBooks() async
  {
    return _books;
  }

  @override
  Future<List<Book>> getBooksByCategory(BookCategory category) async
  {
    return _books.where((book) => book.category == category).toList();
  }
}