import 'package:flutter_meals_apps/models/meals.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavouriteMealsProvider extends StateNotifier<List<Meal>> {
  FavouriteMealsProvider() : super([]);

  bool toggleMealFavouriteStatus(Meal meal) {
    final mealIsFavourite = state.contains(meal);

    if (mealIsFavourite) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      state = [...state, meal];
      return true;
    }
  }
}

final favouriteMeal = StateNotifierProvider<FavouriteMealsProvider, List<Meal>>(
    (ref) => FavouriteMealsProvider());
