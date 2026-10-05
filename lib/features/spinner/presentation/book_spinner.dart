import 'dart:math';

import 'package:book_spinner/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class BookSpinner extends StatefulWidget
{
  const BookSpinner({super.key, this.onCategorySelected});

  final ValueChanged<String>? onCategorySelected;

  @override
  State<BookSpinner> createState() => _BookSpinnerState();
}

class _BookSpinnerState extends State<BookSpinner> with SingleTickerProviderStateMixin
{
  static const categories =
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

  late final AnimationController _controller;

  String? _selectedCategory;
  double _rotation = 0;

  @override
  void initState()
  {
    super.initState();

    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 1800));
  }

  @override
  void dispose()
  {
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
        Stack(
          alignment: Alignment.topCenter,
          children:
          [
            Transform.rotate(
              angle: _rotation,
              child: _Wheel(categories: categories),
            ),
            const _Pointer(),
          ],
        ),
        const SizedBox(height: 32),
        if (_selectedCategory != null) ...[
          Text(
            'YOUR NEXT CATEGORY',
            style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.textSecondary,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _selectedCategory!,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(color: AppColors.textPrimary),
          ),
          const SizedBox(height: 24),
        ],
        FilledButton.icon(
          onPressed: _controller.isAnimating ? null : _spin,
          icon: const Icon(Icons.casino_rounded),
          label: const Text('SPIN IT'),
        ),
      ],
    );
  }

  void _spin()
  {
    if (_controller.isAnimating)
    {
      return;
    }

    final random = Random();

    final selectedIndex = random.nextInt(categories.length);
    final segmentAngle = 2 * pi / categories.length;

    // A kiválasztott szegmens középpontja.
    final segmentCenterAngle = -pi / 2 + (selectedIndex + 0.5) * segmentAngle;

    // A mutató a kerék tetején van (-pi / 2).
    // Olyan forgatást szeretnénk, hogy a kiválasztott
    // szegmens közepe pontosan a mutató alá kerüljön.
    final targetRotation = -pi / 2 - segmentCenterAngle;
    final currentRotation = _rotation;

    // Az aktuális forgás normalizált értéke.
    final currentNormalized = currentRotation % (2 * pi);

    // Kiszámoljuk, mennyit kell még fordulnia.
    var delta = targetRotation - currentNormalized;

    if (delta < 0)
    {
      delta += 2 * pi;
    }

    // 4-6 teljes extra fordulat.
    final extraTurns = 4 + random.nextInt(3);
    final totalRotation = extraTurns * 2 * pi + delta;

    final startRotation = currentRotation;
    final endRotation = currentRotation + totalRotation;

    final animation = Tween<double>(begin: startRotation, end: endRotation).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),);

    animation.addListener(()
    {
      setState(()
      {
        _rotation = animation.value;
      });
    });

    animation.addStatusListener((status)
    {
      if (status == AnimationStatus.completed)
      {
        setState(()
        {
          _rotation = endRotation;
          _selectedCategory = categories[selectedIndex];
        });

        widget.onCategorySelected?.call(categories[selectedIndex]);
      }
    });

    _controller..reset()..forward();
  }
}

class _Wheel extends StatelessWidget
{
  const _Wheel({required this.categories});

  final List<String> categories;

  @override
  Widget build(BuildContext context)
  {
    return SizedBox(
      width: 340,
      height: 340,
      child: CustomPaint(
        painter: _WheelPainter(categories: categories),
      ),
    );
  }
}

class _WheelPainter extends CustomPainter
{
  _WheelPainter({required this.categories});

  final List<String> categories;

  @override
  void paint(Canvas canvas, Size size)
  {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final segmentAngle = 2 * pi / categories.length;

    final paint = Paint()..style = PaintingStyle.fill;
    final borderPaint = Paint()..style = PaintingStyle.stroke..strokeWidth = 2..color = AppColors.border;

    for (var i = 0; i < categories.length; i++)
    {
      final startAngle = -pi / 2 + i * segmentAngle;

      paint.color = i.isEven ? AppColors.purple : AppColors.blue;

      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, segmentAngle, true, paint);
      canvas.drawArc(Rect.fromCircle(center: center, radius: radius), startAngle, segmentAngle, true, borderPaint);

      final textAngle = startAngle + segmentAngle / 2;
      final textPosition = Offset(center.dx + cos(textAngle) * radius * 0.62, center.dy + sin(textAngle) * radius * 0.62);

      final textPainter = TextPainter(
        text: TextSpan(
          text: categories[i],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 13,
            fontWeight: FontWeight.w600,
          ),
        ),
        textDirection: TextDirection.ltr,
      )..layout();

      canvas.save();
      canvas.translate(textPosition.dx, textPosition.dy);
      canvas.rotate(textAngle + pi / 2);

      textPainter.paint(canvas, Offset(-textPainter.width / 2, -textPainter.height / 2));
      canvas.restore();
    }

    canvas.drawCircle(center, radius, borderPaint);

    final centerPaint = Paint()..color = AppColors.background;

    canvas.drawCircle(center, 34, centerPaint);
    canvas.drawCircle(center, 34, borderPaint);
  }

  @override
  bool shouldRepaint(covariant _WheelPainter oldDelegate)
  {
    return oldDelegate.categories != categories;
  }
}

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
          top: BorderSide(color: AppColors.textPrimary, width: 18),
          left: BorderSide(color: Colors.transparent, width: 10),
          right: BorderSide(color: Colors.transparent, width: 10),
        ),
      ),
    );
  }
}