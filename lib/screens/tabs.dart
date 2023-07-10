import 'package:flutter/material.dart';
import 'package:flutter_meals_apps/providers/favourites_provider.dart';
import 'package:flutter_meals_apps/providers/filters_provider.dart';
import 'package:flutter_meals_apps/providers/meals_provider.dart';
import 'package:flutter_meals_apps/screens/category_screen.dart';
import 'package:flutter_meals_apps/screens/filters_screen.dart';
import 'package:flutter_meals_apps/screens/meals_screen.dart';
import 'package:flutter_meals_apps/widgets/main_drawer.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

const kInitialFilter = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegetarianFree: false,
  Filter.veganFree: false,
};

class TabScreen extends ConsumerStatefulWidget {
  const TabScreen({super.key});

  @override
  ConsumerState<TabScreen> createState() => _TabScreenState();
}

class _TabScreenState extends ConsumerState<TabScreen> {
  int _selectedIndex = 0;

  void _selectedPage(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.pop(context);
    if (identifier == 'filters') {
      await Navigator.push<Map<Filter, bool>>(context,
          MaterialPageRoute(builder: (context) {
        return const FilterScreen();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    final meals = ref.watch(mealsProvider);
    final activeFilter = ref.watch(filterProvider);
    final availableMeals = ref.watch(filterMealProvider);

    Widget activePage = CategoriesScreen(
      availableMeals: availableMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectedIndex == 1) {
      final favouriteMeals = ref.watch(favouriteMeal);
      activePage = MealsScreen(
        meals: favouriteMeals,
      );
      activePageTitle = 'Your Favourites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GNav(
              tabMargin: const EdgeInsets.symmetric(horizontal: 10),
              tabBorderRadius: 12,
              curve: Curves.easeInCubic,
              duration: const Duration(milliseconds: 700),
              rippleColor: Theme.of(context).colorScheme.background,
              color: Theme.of(context).colorScheme.onPrimaryContainer,
              activeColor: Theme.of(context).colorScheme.primary,
              tabBackgroundGradient: LinearGradient(
                colors: [
                  Theme.of(context).colorScheme.background,
                  Theme.of(context)
                      .colorScheme
                      .primaryContainer
                      .withOpacity(0.2),
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              iconSize: 20,
              gap: 8,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              onTabChange: _selectedPage,
              tabs: const [
                GButton(
                  icon: Icons.set_meal,
                  text: 'Categories',
                ),
                GButton(
                  icon: Icons.star,
                  text: 'Favourites',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
