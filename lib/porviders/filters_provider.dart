import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_recipes/porviders/meals_provider.dart';

enum Filter {
  gluetenFree,
  loctoseFree,
  vegetarianFree,
  vegan,
}

class FiltersNotifire extends StateNotifier<Map<Filter, bool>> {
  FiltersNotifire()
      : super({
          Filter.gluetenFree: false,
          Filter.loctoseFree: false,
          Filter.vegan: false,
          Filter.vegetarianFree: false,
        });

  void setFilters(Map<Filter, bool> chosenFilters) {
    state = chosenFilters;
  }

  void setFilter(Filter filter, bool isAcitve) {
    state = {
      ...state,
      filter: isAcitve,
    };
  }
}

final filterProvider =
    StateNotifierProvider<FiltersNotifire, Map<Filter, bool>>(
        (ref) => FiltersNotifire());

final filterdMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilters = ref.watch(filterProvider);
  return meals.where(
    (meal) {
      if (activeFilters[Filter.gluetenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (activeFilters[Filter.loctoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (activeFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      if (activeFilters[Filter.vegetarianFree]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    },
  ).toList();
});
