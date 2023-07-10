import 'package:flutter_meals_apps/providers/meals_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegetarianFree,
  veganFree,
}

class FilterNotifier extends StateNotifier<Map<Filter, bool>> {
  FilterNotifier()
      : super({
          Filter.glutenFree: false,
          Filter.lactoseFree: false,
          Filter.vegetarianFree: false,
          Filter.veganFree: false,
        });

  void setFilters(Map<Filter, bool> choosenFilter) {
    state = choosenFilter;
  }

  void setFilter(Filter filter, bool isActive) {
    state = {
      ...state,
      filter: isActive,
    };
  }
}

final filterProvider = StateNotifierProvider<FilterNotifier, Map<Filter, bool>>(
    (ref) => FilterNotifier());

final filterMealProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final activeFilter = ref.watch(filterProvider);

  return meals.where((meal) {
    if (activeFilter[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }

    if (activeFilter[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }

    if (activeFilter[Filter.vegetarianFree]! && !meal.isVegetarian) {
      return false;
    }

    if (activeFilter[Filter.veganFree]! && !meal.isVegan) {
      return false;
    }

    return true;
  }).toList();
});
