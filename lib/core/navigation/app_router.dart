import 'package:book_spinner/features/about/presentation/about_page.dart';
import 'package:book_spinner/features/home/presentation/home_page.dart';
import 'package:book_spinner/features/library/presentation/library_page.dart';
import 'package:go_router/go_router.dart';

abstract final class AppRouter
{
  static final router = GoRouter(
      initialLocation: '/', 
      routes:
      [
        GoRoute(path: '/', builder: (context, state) => const HomePage()),
        GoRoute(path: '/about', builder: (context, state) => const AboutPage()),
        GoRoute(path: '/library', builder: (context, state) => const LibraryPage()),
      ],
  );
}