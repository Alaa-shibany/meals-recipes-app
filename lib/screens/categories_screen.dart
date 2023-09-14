import 'package:flutter/material.dart';
import 'package:meals_recipes/data/dummy_data.dart';
import 'package:meals_recipes/screens/meals_screen.dart';
import 'package:meals_recipes/widgets/categories_screen_widgets/category_widget.dart';

import '../models/category.dart';
import '../models/meal.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(
      {super.key, required this.onToggelFavorit, required this.availabelMeals});
  final List<Meal> availabelMeals;

  final void Function(Meal meal) onToggelFavorit;

  void _selectCategory(
      {required Category category, required BuildContext context}) {
    final filterdMeals = availabelMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => MealsScreen(
          title: category.title,
          meals: filterdMeals,
          onToggelFavorit: onToggelFavorit,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final category in availableCategories)
          CategoryWidget(
            category: category,
            onTap: () => _selectCategory(category: category, context: context),
          )
      ],
    );
  }
}
