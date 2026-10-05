import 'package:book_spinner/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigationShell extends StatelessWidget
{
  const AppNavigationShell({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context)
  {
    final location = GoRouterState.of(context).uri.path;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children:
        [
          _DesktopNavigation(currentLocation: location),
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }
}

class _DesktopNavigation extends StatelessWidget
{
  const _DesktopNavigation({required this.currentLocation});

  final String currentLocation;

  @override
  Widget build(BuildContext context)
  {
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.background,
        border: Border(
          bottom: BorderSide(color: AppColors.border),
        ),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 32),
      height: 76,
      child: Row(
        children:
        [
          _Brand(),
          const Spacer(),
          _NavigationItem(label: 'Discover', location: '/', currentLocation: currentLocation),
          _NavigationItem(label: 'Library', location: '/library', currentLocation: currentLocation),
          _NavigationItem(label: 'About', location: '/about', currentLocation: currentLocation),
        ],
      ),
    );
  }
}

class _Brand extends StatelessWidget
{
  @override
  Widget build(BuildContext context)
  {
    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () => context.go('/'),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children:
          [
            _BrandIcon(),
            SizedBox(width: 12),
            Text(
              'BookSpinner',
              style: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                letterSpacing: -0.5,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BrandIcon extends StatelessWidget
{
  const _BrandIcon();

  @override
  Widget build(BuildContext context)
  {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.purple,
      ),
      width: 38,
      height: 38,
      child: const Icon(
        Icons.auto_stories_rounded,
        color: Colors.white,
        size: 21,
      ),
    );
  }
}

class _NavigationItem extends StatelessWidget
{
  const _NavigationItem({required this.label, required this.location, required this.currentLocation});

  final String label;
  final String location;
  final String currentLocation;

  @override
  Widget build(BuildContext context)
  {
    final isActive = currentLocation == location;

    return Padding(
      padding: const EdgeInsets.only(left: 8),
      child: TextButton(
        onPressed: () => context.go(location),
        style: TextButton.styleFrom(
          foregroundColor: isActive ? AppColors.textPrimary : AppColors.textSecondary,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}