import 'package:book_spinner/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main()
{
  runApp(const BookSpinnerApp());
}

class BookSpinnerApp extends StatelessWidget
{
  const BookSpinnerApp({super.key});

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp(
      title: 'BookSpinner',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      home: const ThemePreviewPage(),
    );
  }
}

class ThemePreviewPage extends StatelessWidget
{
  const ThemePreviewPage({super.key});

  @override
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BookSpinner'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children:
          [
            Text(
              'DISCOVER YOUR\nNEXT CHAPTER',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            const SizedBox(height: 16),
            Text(
              'Your next book is one spin away.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: () {},
              child: const Text('SPIN IT'),
            ),
          ],
        ),
      ),
    );
  }
}