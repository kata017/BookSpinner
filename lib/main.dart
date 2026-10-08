import 'package:book_spinner/core/navigation/app_router.dart';
import 'package:book_spinner/core/theme/app_theme.dart';
import 'package:book_spinner/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:flutter/material.dart';

void main() async
{
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  usePathUrlStrategy();
  runApp(const BookSpinnerApp());
}

class BookSpinnerApp extends StatelessWidget
{
  const BookSpinnerApp({super.key});

  @override
  Widget build(BuildContext context)
  {
    return MaterialApp.router(
      title: 'BookSpinner',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.dark,
      routerConfig: AppRouter.router,
    );
  }
}