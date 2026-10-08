import 'package:book_spinner/models/book.dart';
import 'package:book_spinner/models/book_category.dart';

abstract interface class BookRepository
{
  Future<List<Book>> getBooks();
  Future<List<Book>> getBooksByCategory(BookCategory category);
}