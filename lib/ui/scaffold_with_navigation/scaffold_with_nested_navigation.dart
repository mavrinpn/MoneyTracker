import 'package:diploma/ui/scaffold_with_navigation/scaffold_with_navigation_bar.dart';
import 'package:diploma/ui/scaffold_with_navigation/scaffold_with_navigation_rail.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ScaffoldWithNestedNavigation extends StatelessWidget {
  const ScaffoldWithNestedNavigation({
    Key? key,
    required this.navigationShell,
  }) : super(
            key: key ?? const ValueKey<String>('ScaffoldWithNestedNavigation'));
  final StatefulNavigationShell navigationShell;

  void _goBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavigationBarItems = [
      BottomNavigationBarItem(
        icon: const Icon(
          Icons.credit_card,
          key: Key('barItem1'),
        ),
        label: AppLocalizations.of(context)!.spendings_tab,
      ),
      BottomNavigationBarItem(
        icon: const Icon(
          Icons.person,
          key: Key('barItem2'),
        ),
        label: AppLocalizations.of(context)!.profile_tab,
      ),
    ];

    final navigationRailDestinations = [
      NavigationRailDestination(
        label: Text(AppLocalizations.of(context)!.spendings_tab),
        icon: const Icon(Icons.credit_card),
      ),
      NavigationRailDestination(
        label: Text(AppLocalizations.of(context)!.profile_tab),
        icon: const Icon(Icons.person),
      ),
    ];

    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth < 450) {
        return ScaffoldWithNavigationBar(
          body: navigationShell,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _goBranch,
          items: bottomNavigationBarItems,
        );
      } else {
        return ScaffoldWithNavigationRail(
          body: navigationShell,
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: _goBranch,
          items: navigationRailDestinations,
        );
      }
    });
  }
}
