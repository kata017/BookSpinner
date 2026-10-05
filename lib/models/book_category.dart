enum BookCategory
{
  fiction,
  fantasy,
  sciFi,
  mystery,
  biography,
  history,
  romance,
  thriller,
}

extension BookCategoryExtension on BookCategory
{
  String get displayName
  {
    switch (this)
    {
      case BookCategory.fiction:
        return 'Fiction';
      case BookCategory.fantasy:
        return 'Fantasy';
      case BookCategory.sciFi:
        return 'Sci-Fi';
      case BookCategory.mystery:
        return 'Mystery';
      case BookCategory.biography:
        return 'Biography';
      case BookCategory.history:
        return 'History';
      case BookCategory.romance:
        return 'Romance';
      case BookCategory.thriller:
        return 'Thriller';
    }
  }

  String get firestoreValue
  {
    switch (this)
    {
      case BookCategory.fiction:
        return 'fiction';
      case BookCategory.fantasy:
        return 'fantasy';
      case BookCategory.sciFi:
        return 'sci-fi';
      case BookCategory.mystery:
        return 'mystery';
      case BookCategory.biography:
        return 'biography';
      case BookCategory.history:
        return 'history';
      case BookCategory.romance:
        return 'romance';
      case BookCategory.thriller:
        return 'thriller';
    }
  }
}

extension BookCategoryCollection on BookCategory
{
  static const values = BookCategory.values;
}

const bookCategories = BookCategory.values;