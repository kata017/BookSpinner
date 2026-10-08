import 'package:book_spinner/models/book.dart';
import 'package:book_spinner/models/book_category.dart';
import 'package:book_spinner/repositories/book_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseBookRepository implements BookRepository
{
  FirebaseBookRepository({FirebaseFirestore? firestore,}) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;
  CollectionReference<Map<String, dynamic>> get _booksCollection => _firestore.collection('books');

  @override
  Future<List<Book>> getBooks() async
  {
    final snapshot = await _booksCollection.get();
    return snapshot.docs.map(_bookFromDocument).toList();
  }

  @override
  Future<List<Book>> getBooksByCategory(BookCategory category) async
  {
    final snapshot = await _booksCollection.where('category', isEqualTo: category.firestoreValue).get();
    return snapshot.docs.map(_bookFromDocument).toList();
  }

  Book _bookFromDocument(QueryDocumentSnapshot<Map<String, dynamic>> document)
  {
    final data = document.data();
    return Book(
        id: document.id,
        title: data['title'] as String? ?? '',
        author: data['author'] as String? ?? '',
        description: data['description'] as String? ?? '',
        coverUrl: data['coverUrl'] as String? ?? '',
        category: _categoryFromFirestore(data['category'] as String? ?? ''),
    );
  }

  BookCategory _categoryFromFirestore(String value)
  {
    return BookCategory.values.firstWhere((category) => category.firestoreValue == value, orElse: () => throw StateError('Unknown book category: $value'));
  }
}