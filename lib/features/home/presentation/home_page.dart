import 'dart:math';

import 'package:book_spinner/core/theme/app_colors.dart';
import 'package:book_spinner/features/home/presentation/widgets/book_result_card.dart';
import 'package:book_spinner/features/spinner/presentation/book_spinner.dart';
import 'package:book_spinner/models/book.dart';
import 'package:book_spinner/models/book_category.dart';
import 'package:book_spinner/repositories/book_repository.dart';

import 'package:flutter/material.dart';

class HomePage extends StatefulWidget
{
  const HomePage({super.key, required this.repository});

  final BookRepository repository;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
  final GlobalKey<BookSpinnerState> _spinnerKey = GlobalKey<BookSpinnerState>();

  BookCategory? _selectedCategory;
  Book? _selectedBook;

  @override
  Widget build(BuildContext context)
  {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
        child: Column(
          children:
          [
            //Hero
            _HeroSection(spinnerKey: _spinnerKey, onCategorySelected: _selectBook),

            //Selected book
            if (_selectedBook != null) ...[
              const SizedBox(height: 40),
              BookResultCard(
                book: _selectedBook!,
                onSpinAgain: ()
                {
                  _spinnerKey.currentState?.spin();
                },
              ),
            ],

            //Categories
            const SizedBox(height: 80),
            _CategoriesSection(selectedCategory: _selectedCategory,  onCategorySelected: _selectBook),
          ],
        ),
      ),
    );
  }

  Future<void> _selectBook(BookCategory category) async
  {
    setState(()
    {
      _selectedCategory = category;
      _selectedBook = null;
    });

    final books = await widget.repository.getBooksByCategory(category);

    if (!mounted)
    {
      return;
    }

    if (books.isEmpty)
    {
      return;
    }

    final random = Random();
    final selectedBook = books[random.nextInt(books.length)];

    setState(()
    {
      _selectedBook = selectedBook;
    });
  }
}

class _HeroSection extends StatelessWidget
{
  const _HeroSection({required this.spinnerKey, required this.onCategorySelected});

  final GlobalKey<BookSpinnerState> spinnerKey;
  final ValueChanged<BookCategory> onCategorySelected;

  @override
  Widget build(BuildContext context)
  {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1100),
      child: Column(
        children:
        [
          Text(
            'DISCOVER YOUR\nNEXT CHAPTER',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayMedium,
          ),
          const SizedBox(height: 20),
          Text(
            'Your next book is one spin away.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: AppColors.textSecondary),
          ),
          const SizedBox(height: 48),
          BookSpinner(key: spinnerKey, onCategorySelected: onCategorySelected),
        ],
      ),
    );
  }
}

class _CategoriesSection extends StatelessWidget
{
  const _CategoriesSection({this.selectedCategory, required this.onCategorySelected});

  final BookCategory? selectedCategory;
  final ValueChanged<BookCategory> onCategorySelected;

  @override
  Widget build(BuildContext context)
  {
    final categories = BookCategory.values;

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1000),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Text('EXPLORE BY CATEGORY', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 24),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children:
            [
              for (final category in categories)
                _CategoryChip(
                  label: category.displayName,
                  isSelected: category == selectedCategory,
                  onTap: () => onCategorySelected(category),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget
{
  const _CategoryChip({required this.label, required this.onTap, this.isSelected = false});

  final String label;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context)
  {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.purple : AppColors.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: isSelected ? AppColors.purple : AppColors.border),
          ),
          child: Text(
            label,
            style: TextStyle(
              color:  isSelected ? Colors.white : AppColors.textSecondary,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}