// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:meals_recipes/main_drawer.dart';
import 'package:meals_recipes/porviders/favorites_provider.dart';
import 'package:meals_recipes/screens/categories_screen.dart';
import 'package:meals_recipes/screens/filters_screen.dart';
import 'package:meals_recipes/screens/meals_screen.dart';

import '../porviders/filters_provider.dart';

const kInitialFilters = {
  Filter.gluetenFree: false,
  Filter.loctoseFree: false,
  Filter.vegan: false,
  Filter.vegetarianFree: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  void _setScreens(String identifire) async {
    Navigator.of(context).pop();
    if (identifire == 'filters') {
      await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (context) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availabelMeals = ref.watch(filterdMealsProvider);

    Widget activePage = CategoriesScreen(
      availabelMeals: availabelMeals,
    );
    var activePageTitle = 'Categories';

    if (_selectPageIndex == 1) {
      final favoritesMeals = ref.watch(favoritesMealsProvider);
      activePage = MealsScreen(
        meals: favoritesMeals,
      );
      activePageTitle = 'Your Favorites';
    }

    return Scaffold(
      drawer: MainDrawer(onSelectScren: _setScreens),
      appBar: AppBar(
        title: Text(activePageTitle),
      ),
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectPageIndex,
        onTap: _selectPage,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
