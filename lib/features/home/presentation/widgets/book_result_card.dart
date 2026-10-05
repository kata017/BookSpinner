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
            child: SlideTransition(position: Tween<Offset>(begin: const Offset(0, 0.05), end: Offset.zero).animate(animation), child: child),
          );
        },
        child: Container(
          key: ValueKey(book.id),
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: AppColors.border),
            boxShadow:
            [
              BoxShadow(
                color: AppColors.purple.withValues(alpha: 0.08),
                blurRadius: 40,
                spreadRadius: 2,
                offset: const Offset(0, 18),
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

// -----------------------------------------------------------------------------
// DESKTOP
// -----------------------------------------------------------------------------
class _DesktopBookCard extends StatelessWidget
{
  const _DesktopBookCard({required this.book, required this.onSpinAgain,});

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
          Expanded(child: _BookInformation(book: book, onSpinAgain: onSpinAgain)),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// MOBILE
// -----------------------------------------------------------------------------
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
          const SizedBox(height: 28),
          _BookInformation(book: book, onSpinAgain: onSpinAgain),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// BOOK COVER
// -----------------------------------------------------------------------------
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
      width: width,
      height: height,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.surfaceSecondary,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
        boxShadow:
        [
          BoxShadow(
            color: AppColors.purple.withValues(alpha: 0.16),
            blurRadius: 24,
            spreadRadius: 2,
          ),
        ],
      ),
      child: book.coverUrl.isEmpty
          ? _PlaceholderCover(book: book)
          : Image.network(
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

// -----------------------------------------------------------------------------
// PLACEHOLDER COVER
// -----------------------------------------------------------------------------
class _PlaceholderCover extends StatelessWidget
{
  const _PlaceholderCover({required this.book});

  final Book book;

  @override
  Widget build(BuildContext context)
  {
    return DecoratedBox(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors:
          [
            AppColors.purple,
            AppColors.pink,
            AppColors.cyan,
          ],
          stops:
          [
            0.0,
            0.58,
            1.0,
          ],
        ),
      ),
      child: Stack(
        children:
        [
          // Subtle decorative glow.
          Positioned(
            top: -45,
            right: -35,
            child: Container(
              width: 110,
              height: 110,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.10),
              ),
            ),
          ),
          Positioned(
            bottom: -50,
            left: -40,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: AppColors.purple.withValues(alpha: 0.20),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children:
              [
                Container(
                  width: 58,
                  height: 58,
                  decoration: BoxDecoration(
                    color: Colors.white.withValues(alpha: 0.14),
                    borderRadius: BorderRadius.circular(18),
                    border: Border.all(color: Colors.white.withValues(alpha: 0.22)),
                  ),
                  child: const Icon(Icons.auto_stories_rounded, color: Colors.white, size: 32),
                ),
                const SizedBox(height: 24),
                Text(
                  book.title,
                  textAlign: TextAlign.center,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  book.author,
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.white.withValues(alpha: 0.78)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// BOOK INFORMATION
// -----------------------------------------------------------------------------
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
        _CategoryBadge(category: book.category.displayName),
        const SizedBox(height: 18),
        Text(
          book.title,
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: AppColors.textPrimary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 6),
        Text(book.author, style: Theme.of(context).textTheme.titleMedium?.copyWith(color: AppColors.textSecondary)),
        const SizedBox(height: 22),
        Text(
          book.description,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: AppColors.textSecondary,
            height: 1.6,
          ),
        ),
        const SizedBox(height: 28),
        _SpinAgainButton(onPressed: onSpinAgain),
      ],
    );
  }
}

// -----------------------------------------------------------------------------
// CATEGORY BADGE
// -----------------------------------------------------------------------------
class _CategoryBadge extends StatelessWidget
{
  const _CategoryBadge({required this.category});

  final String category;

  @override
  Widget build(BuildContext context)
  {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 7),
      decoration: BoxDecoration(
        color: AppColors.purple.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: AppColors.purple.withValues(alpha: 0.45)),
        boxShadow:
        [
          BoxShadow(
            color: AppColors.purple.withValues(alpha: 0.08),
            blurRadius: 12,
          ),
        ],
      ),
      child: Text(
        category.toUpperCase(),
        style: Theme.of(context).textTheme.labelMedium?.copyWith(
          color: AppColors.purple,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// SPIN AGAIN BUTTON
// -----------------------------------------------------------------------------
class _SpinAgainButton extends StatefulWidget
{
  const _SpinAgainButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  State<_SpinAgainButton> createState() => _SpinAgainButtonState();
}

class _SpinAgainButtonState extends State<_SpinAgainButton>
{
  bool _isHovered = false;

  @override
  Widget build(BuildContext context)
  {
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
      child: AnimatedScale(
        scale: _isHovered ? 1.03 : 1.0,
        duration: const Duration(milliseconds: 180),
        child: DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: const LinearGradient(
              colors:
              [
                AppColors.pink,
                AppColors.purple,
                AppColors.cyan,
              ],
            ),
            boxShadow: _isHovered ? [BoxShadow(color: AppColors.purple.withValues(alpha: 0.30), blurRadius: 22, spreadRadius: 1)] : null,
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: widget.onPressed,
              borderRadius: BorderRadius.circular(16),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 13),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children:
                  [
                    const Icon(Icons.casino_rounded, color: Colors.white, size: 19),
                    const SizedBox(width: 9),
                    Text(
                      'SPIN AGAIN',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.7,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}