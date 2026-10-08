import 'dart:math';

import 'package:book_spinner/core/theme/app_colors.dart';
import 'package:book_spinner/models/book_category.dart';
import 'package:flutter/material.dart';

class BookSpinner extends StatefulWidget
{
  const BookSpinner({super.key, this.onCategorySelected});

  final ValueChanged<BookCategory>? onCategorySelected;

  @override
  State<BookSpinner> createState() => BookSpinnerState();
}

class BookSpinnerState extends State<BookSpinner> with SingleTickerProviderStateMixin
{
  static const List<BookCategory> categories = BookCategory.values;
  late final AnimationController _controller;

  Animation<double>? _rotationAnimation;
  double _rotation = 0;

  BookCategory? _selectedCategory;
  BookCategory? _pendingCategory;

  @override
  void initState()
  {
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1800));
    _controller.addStatusListener(_handleAnimationStatus);
  }

  @override
  void dispose()
  {
    _controller.removeStatusListener(_handleAnimationStatus);
    _controller.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context)
  {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children:
      [
        LayoutBuilder(
          builder: (context, constraints)
          {
            final availableWidth = constraints.maxWidth;
            final wheelSize = min(availableWidth, 320.0);

            return Stack(
              alignment: Alignment.topCenter,
              children:
              [
                AnimatedBuilder(
                  animation: _controller,
                  builder: (context, child)
                  {
                    final rotation = _rotationAnimation?.value ?? _rotation;
                    return Transform.rotate(angle: rotation, child: child);
                  },
                  child: _Wheel(categories: categories, size: wheelSize),
                ),
                const _Pointer(),
              ],
            );
          },
        ),
        const SizedBox(height: 24),
        _SpinButton(isAnimating: _controller.isAnimating, onPressed: spin),

        if (_selectedCategory != null) ...[
          const SizedBox(height: 20),
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 250),
            child: Text(
              'Selected: ${_selectedCategory!.displayName}',
              key: ValueKey(_selectedCategory),
              style: Theme.of(context).textTheme.bodySmall?.copyWith(color: AppColors.textSecondary),
            ),
          ),
        ],
      ],
    );
  }

  void spin()
  {
    if (_controller.isAnimating)
    {
      return;
    }

    final random = Random();

    final selectedIndex = random.nextInt(categories.length);
    final selectedCategory = categories[selectedIndex];

    final segmentAngle = 2 * pi / categories.length;

    // A kiválasztott szegmens középpontja.
    final segmentCenterAngle = -pi / 2 + (selectedIndex + 0.5) * segmentAngle;

    // A mutató a kerék tetején van.
    const pointerAngle = -pi / 2;

    // A kiválasztott szegmens közepét a pointerhez forgatjuk.
    final targetRotation = pointerAngle - segmentCenterAngle;
    final currentNormalized = _rotation % (2 * pi);

    var delta = targetRotation - currentNormalized;

    if (delta < 0)
    {
      delta += 2 * pi;
    }

    // 4–6 teljes extra fordulat.
    final extraTurns = 4 + random.nextInt(3);
    final totalRotation = extraTurns * 2 * pi + delta;

    final startRotation = _rotation;
    final endRotation = startRotation + totalRotation;

    _pendingCategory = selectedCategory;
    _rotationAnimation = Tween<double>(begin: startRotation, end: endRotation).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic));

    _controller..reset()..forward();
  }

  void _handleAnimationStatus(AnimationStatus status)
  {
    if (status != AnimationStatus.completed)
    {
      return;
    }

    final animation = _rotationAnimation;

    if (animation == null)
    {
      return;
    }

    final selectedCategory = _pendingCategory;

    setState(()
    {
      _rotation = animation.value;
      _selectedCategory = selectedCategory;
    });

    if (selectedCategory != null)
    {
      widget.onCategorySelected?.call(selectedCategory);
    }

    _pendingCategory = null;
  }
}

// -----------------------------------------------------------------------------
// WHEEL
// -----------------------------------------------------------------------------
class _Wheel extends StatelessWidget
{
  const _Wheel({required this.categories, required this.size});

  final List<BookCategory> categories;
  final double size;

  @override
  Widget build(BuildContext context)
  {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow:
        [
          BoxShadow(color: AppColors.purple.withValues(alpha: 0.12), blurRadius: 30, spreadRadius: 4),
          BoxShadow(color: AppColors.cyan.withValues(alpha: 0.05), blurRadius: 50, spreadRadius: 8),
        ],
      ),
      child: CustomPaint(painter: _WheelPainter(categories: categories)),
    );
  }
}

// -----------------------------------------------------------------------------
// WHEEL PAINTER
// -----------------------------------------------------------------------------
class _WheelPainter extends CustomPainter
{
  _WheelPainter({required this.categories});

  final List<BookCategory> categories;

  static const List<Color> _segmentColors =
  [
    AppColors.purple,
    AppColors.pink,
    AppColors.cyan,
    AppColors.purple,
    AppColors.pink,
    AppColors.purple,
    AppColors.cyan,
    AppColors.pink,
  ];

  @override
  void paint(Canvas canvas, Size size)
  {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final segmentAngle = 2 * pi / categories.length;

    final fillPaint = Paint()..style = PaintingStyle.fill;
    final borderPaint = Paint()..style = PaintingStyle.stroke..strokeWidth = 1.5..color = AppColors.background;

    final outerBorderPaint = Paint()..style = PaintingStyle.stroke..strokeWidth = 4..color = AppColors.gold;
    final innerBorderPaint = Paint()..style = PaintingStyle.stroke..strokeWidth = 2..color = AppColors.border;

    for (var i = 0; i < categories.length; i++)
    {
      final startAngle = -pi / 2 + i * segmentAngle;

      fillPaint.color = _segmentColors[i % _segmentColors.length];

      final rect = Rect.fromCircle(center: center, radius: radius - 2);

      canvas.drawArc(rect, startAngle, segmentAngle, true, fillPaint);
      canvas.drawArc(rect, startAngle, segmentAngle, true, borderPaint);

      _paintCategoryLabel(canvas: canvas, center: center, radius: radius, startAngle: startAngle, segmentAngle: segmentAngle, label: categories[i].displayName);
    }

    // Gold outer border.
    canvas.drawCircle(center, radius - 2, outerBorderPaint);

    // Inner circle.
    final innerRadius = radius * 0.20;
    final innerFillPaint = Paint()..style = PaintingStyle.fill..color = AppColors.background;

    canvas.drawCircle(center, innerRadius, innerFillPaint);
    canvas.drawCircle(center, innerRadius, innerBorderPaint);

    // Small gold center accent.
    final centerDotPaint = Paint()..style = PaintingStyle.fill..color = AppColors.gold;
    canvas.drawCircle(center, 4, centerDotPaint,);
  }

  void _paintCategoryLabel({required Canvas canvas, required Offset center, required double radius, required double startAngle, required double segmentAngle, required String label})
  {
    final textAngle = startAngle + segmentAngle / 2;
    final textRadius = radius * 0.66;

    final textPosition = Offset(center.dx + cos(textAngle) * textRadius, center.dy + sin(textAngle) * textRadius);

    final textPainter = TextPainter(
      text: TextSpan(
        text: label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          letterSpacing: 0.1,
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    canvas.save();
    canvas.translate(textPosition.dx, textPosition.dy);

    var labelRotation = textAngle + pi / 2;

    if (labelRotation > pi / 2 && labelRotation < 3 * pi / 2)
    {
      labelRotation += pi;
    }

    canvas.rotate(labelRotation);

    textPainter.paint(canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _WheelPainter oldDelegate)
  {
    return oldDelegate.categories != categories;
  }
}

// -----------------------------------------------------------------------------
// POINTER
// -----------------------------------------------------------------------------
class _Pointer extends StatelessWidget
{
  const _Pointer();

  @override
  Widget build(BuildContext context)
  {
    return Container(
      width: 0,
      height: 0,
      decoration: const BoxDecoration(
        border: Border(
          top: BorderSide(color: AppColors.gold, width: 20),
          left: BorderSide(color: Colors.transparent, width: 12),
          right: BorderSide(color: Colors.transparent, width: 12),
        ),
        boxShadow:
        [
          BoxShadow(color: AppColors.gold, blurRadius: 12),
        ],
      ),
    );
  }
}

// -----------------------------------------------------------------------------
// SPIN BUTTON
// -----------------------------------------------------------------------------
class _SpinButton extends StatefulWidget
{
  const _SpinButton({required this.isAnimating, required this.onPressed});

  final bool isAnimating;
  final VoidCallback onPressed;

  @override
  State<_SpinButton> createState() => _SpinButtonState();
}

class _SpinButtonState extends State<_SpinButton>
{
  bool _isHovered = false;

  @override
  Widget build(BuildContext context)
  {
    return MouseRegion(
      cursor: widget.isAnimating ? SystemMouseCursors.basic : SystemMouseCursors.click,
      onEnter: (_)
      {
        if (!widget.isAnimating)
        {
          setState(()
          {
            _isHovered = true;
          });
        }
      },
      onExit: (_)
      {
        setState(()
        {
          _isHovered = false;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        transform: Matrix4.diagonal3Values(_isHovered ? 1.03 : 1.0, _isHovered ? 1.03 : 1.0, 1.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(colors: widget.isAnimating ? [AppColors.surfaceSecondary, AppColors.surface] : [AppColors.pink, AppColors.purple, AppColors.cyan]),
          boxShadow: _isHovered && !widget.isAnimating ? [BoxShadow(color: AppColors.purple.withValues(alpha: 0.35), blurRadius: 24, spreadRadius: 2)] : null,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: widget.isAnimating ? null : widget.onPressed,
            borderRadius: BorderRadius.circular(18),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children:
                [
                  Icon(
                    Icons.casino_rounded,
                    size: 20,
                    color: widget.isAnimating ? AppColors.textSecondary : Colors.white,
                  ),
                  const SizedBox(width: 10),
                  Text(
                    widget.isAnimating ? 'SPINNING...' : 'SPIN THE WHEEL',
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: widget.isAnimating ? AppColors.textSecondary : Colors.white,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.8,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}