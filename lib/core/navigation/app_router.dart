import 'package:book_spinner/core/navigation/app_navigation_shell.dart';
import 'package:book_spinner/features/about/presentation/about_page.dart';
import 'package:book_spinner/features/home/presentation/home_page.dart';
import 'package:book_spinner/features/library/presentation/library_page.dart';
import 'package:book_spinner/repositories/mock_book_repository.dart';

import 'package:go_router/go_router.dart';

abstract final class AppRouter
{
  static final router = GoRouter(
      initialLocation: '/', 
      routes:
      [
        ShellRoute(
          builder: (context, state, child)
          {
            return AppNavigationShell(child: child);
          },
          routes:
          [
            GoRoute(path: '/', builder: (context, state) => const HomePage(repository: MockBookRepository())),
            GoRoute(path: '/library', builder: (context, state) => const LibraryPage()),
            GoRoute(path: '/about', builder: (context, state) => const AboutPage()),
          ],
        ),
      ],
  );
}