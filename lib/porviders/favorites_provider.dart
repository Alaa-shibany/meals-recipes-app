import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_recipes/models/meal.dart';

class FavoritesMealsNotifire extends StateNotifier<List<Meal>> {
  FavoritesMealsNotifire() : super([]);

  bool toggleMealFavoriteStatus(Meal meal) {
    final mealIsFavorite = state.contains(meal);

    if (mealIsFavorite) {
      state = state.where((element) => element.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favoritesMealsProvider =
    StateNotifierProvider<FavoritesMealsNotifire, List<Meal>>(
  (ref) {
    return FavoritesMealsNotifire();
  },
);
