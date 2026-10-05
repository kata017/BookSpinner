import 'package:book_spinner/core/theme/app_colors.dart';
import 'package:book_spinner/features/spinner/presentation/book_spinner.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget
{
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
{
  String? _selectedCategory;

  @override
  Widget build(BuildContext context)
  {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 64),
        child: Column(
          children:
          [
            _HeroSection(
              onCategorySelected: (category)
              {
                setState(()
                {
                  _selectedCategory = category;
                });
              },
            ),
            const SizedBox(height: 80),
            _CategoriesSection( selectedCategory: _selectedCategory),
          ],
        ),
      ),
    );
  }
}

class _HeroSection extends StatelessWidget
{
  const _HeroSection({required this.onCategorySelected});

  final ValueChanged<String> onCategorySelected;

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
          BookSpinner(onCategorySelected: onCategorySelected),
        ],
      ),
    );
  }
}

class _CategoriesSection extends StatelessWidget
{
  const _CategoriesSection({this.selectedCategory});

  final String? selectedCategory;

  @override
  Widget build(BuildContext context)
  {
    const categories =
    [
      'Fiction',
      'Fantasy',
      'Sci-Fi',
      'Mystery',
      'Biography',
      'History',
      'Romance',
      'Thriller',
    ];

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
                  label: category,
                  isSelected: category == selectedCategory,
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
  const _CategoryChip({required this.label, this.isSelected = false});

  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context)
  {
    return AnimatedContainer(
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
    );
  }
}