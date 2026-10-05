import 'package:book_spinner/core/theme/app_colors.dart';
import 'package:book_spinner/models/book.dart';
import 'package:book_spinner/models/book_category.dart';
import 'package:flutter/material.dart';

class BookResultCard extends StatelessWidget
{
  const BookResultCard({super.key, required this.book, required this.onSpinAgain});

  final Book book;
  final VoidCallback onSpinAgain;

  @override
  Widget build(BuildContext context)
  {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 900),
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        transitionBuilder: (child, animation)
        {
          return FadeTransition(
            opacity: animation,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, 0.05),
                end: Offset.zero,
              ).animate(animation),
              child: child,
            ),
          );
        },
        child: Container(
          key: ValueKey(book.id),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.border),
            borderRadius: BorderRadius.circular(28),
            color: AppColors.surface,
            boxShadow:
            [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.2),
                blurRadius: 30,
                offset: const Offset(0, 16),
              ),
            ],
          ),
          child: LayoutBuilder(
            builder: (context, constraints)
            {
              final isMobile = constraints.maxWidth < 650;

              if (isMobile)
              {
                return _MobileBookCard(book: book, onSpinAgain: onSpinAgain);
              }

              return _DesktopBookCard(book: book, onSpinAgain: onSpinAgain);
            },
          ),
        ),
      ),
    );
  }
}

class _DesktopBookCard extends StatelessWidget
{
  const _DesktopBookCard({required this.book, required this.onSpinAgain});

  final Book book;
  final VoidCallback onSpinAgain;

  @override
  Widget build(BuildContext context)
  {
    return Padding(
      padding: const EdgeInsets.all(28),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:
        [
          _BookCover(book: book, width: 190, height: 280),
          const SizedBox(width: 32),
          Expanded(
            child: _BookInformation(book: book, onSpinAgain: onSpinAgain),
          ),
        ],
      ),
    );
  }

}

class _MobileBookCard extends StatelessWidget
{
  const _MobileBookCard({required this.book, required this.onSpinAgain});

  final Book book;
  final VoidCallback onSpinAgain;

  @override
  Widget build(BuildContext context)
  {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children:
        [
          Center(child: _BookCover(book: book, width: 160, height: 235)),
          const SizedBox(height: 24),
          _BookInformation(book: book, onSpinAgain: onSpinAgain),
        ],
      ),
    );
  }
}

class _BookCover extends StatelessWidget
{
  const _BookCover({required this.book, required this.width, required this.height});

  final Book book;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context)
  {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.border),
        borderRadius: BorderRadius.circular(18),
        color: AppColors.surfaceSecondary,
      ),
      width: width,
      height: height,
      child: book.coverUrl.isEmpty ? _PlaceholderCover(book: book) : Image.network(
        book.coverUrl,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace)
        {
          return _PlaceholderCover(book: book);
        },
      ),
    );
  }
}

class _PlaceholderCover extends StatelessWidget
{
  const _PlaceholderCover({required this.book});

  final Book book;

  @override
  Widget build(BuildContext context)
  {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors:
          [
            AppColors.purple.withValues(alpha: 0.8),
            AppColors.blue.withValues(alpha: 0.8),
          ],
        ),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:
        [
          const Icon(Icons.auto_stories_rounded, color: Colors.white, size: 42),
          const SizedBox(height: 20),
          Text(
            book.title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 18,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            book.author,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white70,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}

class _BookInformation extends StatelessWidget
{
  const _BookInformation({required this.book, required this.onSpinAgain});

  final Book book;
  final VoidCallback onSpinAgain;

  @override
  Widget build(BuildContext context)
  {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children:
      [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            border: Border.all(color: AppColors.purple.withValues(alpha: 0.3)),
            borderRadius: BorderRadius.circular(20),
            color: AppColors.purple.withValues(alpha: 0.12),
          ),
          child: Text(
            book.category.displayName.toUpperCase(),
            style: Theme.of(context).textTheme.labelMedium?.copyWith(
              color: AppColors.purple,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.2,
            ),
          ),
        ),
        const SizedBox(height: 16),
        Text(
          book.title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          book.author,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.textSecondary),
        ),
        const SizedBox(height: 20),
        Text(
          book.description,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textSecondary,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 28),
        FilledButton.icon(
          onPressed: onSpinAgain,
          icon: const Icon(Icons.casino_rounded),
          label: const Text('SPIN AGAIN'),
        ),
      ],
    );
  }
}