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
      appBar: AppBar(
        title: const Text('BookSpinner'),
        actions:
        [
          _NavigationItem(label: 'Discover', location: '/', currentLocation: location),
          _NavigationItem(label: 'Library', location: '/library', currentLocation: location),
          _NavigationItem(label: 'About', location: '/about', currentLocation: location),
          const SizedBox(width: 24),
        ],
      ),
      body: child,
    );
  }
}

class _NavigationItem extends StatelessWidget
{
  const _NavigationItem({required this.label, required this.location, required this.currentLocation,});

  final String label;
  final String location;
  final String currentLocation;

  @override
  Widget build(BuildContext context)
  {
    final isActive = currentLocation == location;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton(
        onPressed: ()
        {
          context.go(location);
        },
        child: Text(
          label,
          style: TextStyle(fontWeight: isActive ? FontWeight.w600 : FontWeight.w400),
        ),
      ),
    );
  }
}