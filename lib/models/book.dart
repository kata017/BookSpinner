import 'package:book_spinner/models/book_category.dart';

class Book
{
  const Book({required this.id, required this.title, required this.author, required this.description, required this.coverUrl, required this.category});

  final String id;
  final String title;
  final String author;
  final String description;
  final String coverUrl;
  final BookCategory category;
}