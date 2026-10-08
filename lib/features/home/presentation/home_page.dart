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
      child: LayoutBuilder(
        builder: (context, constraints)
        {
          final width = constraints.maxWidth;

          final isDesktop = width >= 1100;
          final isTablet = width >= 700 && width < 1100;

          final horizontalPadding = switch (true)
          {
            _ when isDesktop => 56.0,
            _ when isTablet => 36.0,
            _ => 20.0,
          };

          final verticalPadding = switch (true)
          {
            _ when isDesktop => 56.0,
            _ when isTablet => 44.0,
            _ => 32.0,
          };

          final heroSpacing = switch (true)
          {
            _ when isDesktop => 48.0,
            _ when isTablet => 40.0,
            _ => 32.0,
          };

          final resultSpacing = switch (true)
          {
            _ when isDesktop => 56.0,
            _ when isTablet => 48.0,
            _ => 40.0,
          };

          final footerSpacing = switch (true)
          {
            _ when isDesktop => 80.0,
            _ when isTablet => 64.0,
            _ => 52.0,
          };

          return Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding, vertical: verticalPadding),
            child: Column(
              children:
              [
                const _HeroHeader(),
                SizedBox(height: heroSpacing),

                if (isDesktop)
                  _DesktopSpinnerSection(
                    spinnerKey: _spinnerKey,
                    selectedCategory: _selectedCategory,
                    onCategorySelected: _selectBook,
                  )
                else
                  Center(
                    child: ConstrainedBox(
                      constraints: const BoxConstraints(maxWidth: 900),
                      child: _MobileSpinnerSection(
                        spinnerKey: _spinnerKey,
                        selectedCategory: _selectedCategory,
                        onCategorySelected: _selectBook,
                      ),
                    ),
                  ),

                if (_selectedBook != null) ...[
                  SizedBox(height: resultSpacing),
                  _ResultSection(
                    book: _selectedBook!,
                    onSpinAgain: ()
                    {
                      _spinnerKey.currentState?.spin();
                    },
                  ),
                ],

                SizedBox(height: footerSpacing),
                const _HomeFooter(),
              ],
            ),
          );
        },
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

    if (!mounted || books.isEmpty)
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

// -----------------------------------------------------------------------------
// HERO HEADER
// -----------------------------------------------------------------------------
class _HeroHeader extends StatelessWidget
{
  const _HeroHeader();

  @override
  Widget build(BuildContext context)
  {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1000),
      child: Column(
        children:
        [
          // Kata-App gradient accent
          Container(
            width: 118,
            height: 3,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors:
                [
                  AppColors.pink,
                  AppColors.purple,
                  AppColors.cyan,
                ],
              ),
              borderRadius: BorderRadius.circular(999),
              boxShadow:
              [
                BoxShadow(
                  color: AppColors.purple.withValues(alpha: 0.28),
                  blurRadius: 16,
                  spreadRadius: 1,
                ),
              ],
            ),
          ),
          const SizedBox(height: 28),
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              style: Theme.of(context).textTheme.displayMedium?.copyWith(
                color: AppColors.textPrimary,
                fontWeight: FontWeight.w700,
                height: 1.0,
                letterSpacing: -1.5,
              ),
              children:
              [
                const TextSpan(text: 'DISCOVER YOUR\n'),
                TextSpan(
                  text: 'NEXT CHAPTER',
                  style: const TextStyle(color: AppColors.textPrimary),
                ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          Text(
            'Your next book is one spin away.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppColors.textSecondary,
              letterSpacing: 0.3,
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// DESKTOP
// -----------------------------------------------------------------------------
class _DesktopSpinnerSection extends StatelessWidget
{
  const _DesktopSpinnerSection({required this.spinnerKey, required this.selectedCategory, required this.onCategorySelected});

  final GlobalKey<BookSpinnerState> spinnerKey;
  final BookCategory? selectedCategory;
  final ValueChanged<BookCategory> onCategorySelected;

  @override
  Widget build(BuildContext context)
  {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 1200),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          Expanded(
            flex: 6,
            child: _WheelPanel(
              spinnerKey: spinnerKey,
              onCategorySelected: onCategorySelected,
            ),
          ),
          const SizedBox(width: 32),
          Expanded(
            flex: 4,
            child: _CategoryPanel(
              selectedCategory: selectedCategory,
              onCategorySelected: onCategorySelected,
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// MOBILE / TABLET
// -----------------------------------------------------------------------------
class _MobileSpinnerSection extends StatelessWidget
{
  const _MobileSpinnerSection({required this.spinnerKey, required this.selectedCategory, required this.onCategorySelected});

  final GlobalKey<BookSpinnerState> spinnerKey;
  final BookCategory? selectedCategory;
  final ValueChanged<BookCategory> onCategorySelected;

  @override
  Widget build(BuildContext context)
  {
    return Column(
      children:
      [
        _WheelPanel(spinnerKey: spinnerKey, onCategorySelected: onCategorySelected),
        const SizedBox(height: 32),
        _CategoryPanel(selectedCategory: selectedCategory, onCategorySelected: onCategorySelected),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// WHEEL PANEL
// -----------------------------------------------------------------------------
class _WheelPanel extends StatelessWidget
{
  const _WheelPanel({required this.spinnerKey, required this.onCategorySelected});

  final GlobalKey<BookSpinnerState> spinnerKey;
  final ValueChanged<BookCategory> onCategorySelected;

  @override
  Widget build(BuildContext context)
  {
    return _GlassPanel(
      child: Column(
        children:
        [
          const _PanelTitle(
            title: 'YOUR BOOK WHEEL',
            subtitle: 'Let fate choose your next read.',
          ),
          const SizedBox(height: 24),
          BookSpinner(key: spinnerKey, onCategorySelected: onCategorySelected),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// CATEGORY PANEL
// -----------------------------------------------------------------------------
class _CategoryPanel extends StatelessWidget
{
  const _CategoryPanel({required this.selectedCategory, required this.onCategorySelected});

  final BookCategory? selectedCategory;
  final ValueChanged<BookCategory> onCategorySelected;

  @override
  Widget build(BuildContext context)
  {
    final categories = BookCategory.values;

    return _GlassPanel(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          const _PanelTitle(
            title: 'CHOOSE YOUR GENRE',
            subtitle: 'Or pick a category directly.',
          ),
          const SizedBox(height: 28),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children:
            [
              for (final category in categories)
                _CategoryChip(
                  category: category,
                  isSelected: category == selectedCategory,
                  onTap: () => onCategorySelected(category),
                ),
            ],
          ),
          const SizedBox(height: 28),
          Container(height: 1, color: AppColors.border),
          const SizedBox(height: 24),
          Row(
            children:
            [
              Container(
                width: 8,
                height: 8,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors:
                    [
                      AppColors.pink,
                      AppColors.cyan,
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  selectedCategory == null
                      ? 'Choose a genre or spin the wheel.'
                      : 'Selected: ${selectedCategory!.displayName}',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// CATEGORY CHIP
// -----------------------------------------------------------------------------
class _CategoryChip extends StatefulWidget
{
  const _CategoryChip({required this.category, required this.isSelected, required this.onTap});

  final BookCategory category;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  State<_CategoryChip> createState() => _CategoryChipState();
}

class _CategoryChipState extends State<_CategoryChip>
{
  bool _isHovered = false;

  @override
  Widget build(BuildContext context)
  {
    final isHighlighted = widget.isSelected || _isHovered;

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_)
      {
        setState(()
        {
          _isHovered = true;
        });
      },
      onExit: (_)
      {
        setState(()
        {
          _isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedScale(
          scale: _isHovered ? 1.04 : 1.0,
          duration: const Duration(milliseconds: 160),
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            curve: Curves.easeOut,
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 11),
            decoration: BoxDecoration(
              color: widget.isSelected ? AppColors.purple.withValues(alpha: 0.18) : AppColors.surfaceSecondary,
              borderRadius: BorderRadius.circular(999),
              border: Border.all(
                color: isHighlighted ? AppColors.purple.withValues(alpha: 0.8) : AppColors.border,
                width: widget.isSelected ? 1.2 : 1,
              ),
              boxShadow: widget.isSelected ? [BoxShadow(color: AppColors.purple.withValues(alpha: 0.18), blurRadius: 18, spreadRadius: -4)] : null,
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children:
              [
                Container(
                  width: 6,
                  height: 6,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: widget.isSelected ? const LinearGradient(
                      colors:
                      [
                        AppColors.pink,
                        AppColors.cyan,
                      ],
                    ) : null,
                    color: widget.isSelected ? null : AppColors.textSecondary.withValues(alpha: 0.4),
                  ),
                ),
                const SizedBox(width: 9),
                Text(
                  widget.category.displayName,
                  style: TextStyle(
                    color: widget.isSelected ? AppColors.textPrimary : AppColors.textSecondary,
                    fontSize: 14,
                    fontWeight: widget.isSelected ? FontWeight.w600 : FontWeight.w500,
                    letterSpacing: 0.2,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// RESULT
// -----------------------------------------------------------------------------
class _ResultSection extends StatelessWidget
{
  const _ResultSection({required this.book, required this.onSpinAgain});

  final Book book;
  final VoidCallback onSpinAgain;

  @override
  Widget build(BuildContext context)
  {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 900),
      child: Column(
        children:
        [
          const _SectionDivider(),
          const SizedBox(height: 32),
          Text(
            'YOUR NEXT BOOK',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(letterSpacing: 2, fontWeight: FontWeight.w700),
          ),

          const SizedBox(height: 24),
          BookResultCard(book: book, onSpinAgain: onSpinAgain),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// PANEL
// -----------------------------------------------------------------------------
class _GlassPanel extends StatelessWidget
{
  const _GlassPanel({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context)
  {
    return Container(
      padding: const EdgeInsets.all(28),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: AppColors.border.withValues(alpha: 0.9), width: 1),
        boxShadow:
        [
          BoxShadow(
            color: AppColors.purple.withValues(alpha: 0.07),
            blurRadius: 45,
            spreadRadius: -8,
            offset: const Offset(0, 12),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.18),
            blurRadius: 30,
            spreadRadius: -10,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: child,
    );
  }
}

// -----------------------------------------------------------------------------
// PANEL TITLE
// -----------------------------------------------------------------------------
class _PanelTitle extends StatelessWidget
{
  const _PanelTitle({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Text(
          title,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w700,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          subtitle,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// DIVIDER
// -----------------------------------------------------------------------------
class _SectionDivider extends StatelessWidget
{
  const _SectionDivider();

  @override
  Widget build(BuildContext context)
  {
    return Container(
      width: 90,
      height: 2,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors:
          [
            AppColors.pink,
            AppColors.purple,
            AppColors.cyan,
          ],
        ),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// FOOTER DECORATION
// -----------------------------------------------------------------------------
class _HomeFooter extends StatelessWidget
{
  const _HomeFooter();

  @override
  Widget build(BuildContext context)
  {
    return Opacity(
      opacity: 0.65,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
        [
          Container(
            width: 5,
            height: 5,
            decoration: const BoxDecoration(color: AppColors.pink, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Container(
            width: 5,
            height: 5,
            decoration: const BoxDecoration(color: AppColors.purple, shape: BoxShape.circle),
          ),
          const SizedBox(width: 8),
          Container(
            width: 5,
            height: 5,
            decoration: const BoxDecoration(color: AppColors.cyan, shape: BoxShape.circle),
          ),
        ],
      ),
    );
  }
}