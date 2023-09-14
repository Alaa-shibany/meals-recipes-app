// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:meals_recipes/data/dummy_data.dart';
import 'package:meals_recipes/main_drawer.dart';
import 'package:meals_recipes/models/meal.dart';
import 'package:meals_recipes/screens/categories_screen.dart';
import 'package:meals_recipes/screens/filters_screen.dart';
import 'package:meals_recipes/screens/meals_screen.dart';

const kInitialFilters = {
  Filter.gluetenFree: false,
  Filter.loctoseFree: false,
  Filter.vegan: false,
  Filter.vegetarianFree: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectPageIndex = index;
    });
  }

  Map<Filter, bool> selectedFilters = kInitialFilters;
  final List<Meal> _favoriteMeals = [];

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
        ),
      ),
    );
  }

  void _toggelMealFavoriteStatus(Meal meal) {
    final isExisting = _favoriteMeals.contains(meal);
    if (isExisting) {
      setState(() {
        _favoriteMeals.remove(meal);
      });
      _showInfoMessage('Meal is no longer a favorite.');
    } else {
      setState(
        () {
          _favoriteMeals.add(meal);
          _showInfoMessage('Marked as favorite.');
        },
      );
    }
  }

  void _setScreens(String identifire) async {
    Navigator.of(context).pop();
    if (identifire == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (context) => FiltersScreen(currentFilters: selectedFilters),
        ),
      );
      setState(() {
        selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final availabelMeals = dummyMeals.where(
      (meal) {
        if (selectedFilters[Filter.gluetenFree]! && !meal.isGlutenFree) {
          return false;
        }
        if (selectedFilters[Filter.loctoseFree]! && !meal.isLactoseFree) {
          return false;
        }
        if (selectedFilters[Filter.vegan]! && !meal.isVegan) {
          return false;
        }
        if (selectedFilters[Filter.vegetarianFree]! && !meal.isVegetarian) {
          return false;
        }
        return true;
      },
    ).toList();

    Widget activePage = CategoriesScreen(
      availabelMeals: availabelMeals,
      onToggelFavorit: _toggelMealFavoriteStatus,
    );
    var activePageTitle = 'Categories';

    if (_selectPageIndex == 1) {
      activePage = MealsScreen(
        meals: _favoriteMeals,
        onToggelFavorit: _toggelMealFavoriteStatus,
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
