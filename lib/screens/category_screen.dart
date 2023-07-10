import 'package:flutter/material.dart';
import 'package:flutter_meals_apps/data/dummy_data.dart';
import 'package:flutter_meals_apps/models/categories.dart';
import 'package:flutter_meals_apps/models/meals.dart';
import 'package:flutter_meals_apps/screens/meals_screen.dart';
import 'package:flutter_meals_apps/widgets/categories_grid_items.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key,required this.availableMeals});


  final List<Meal> availableMeals;

  void _selectCategory(BuildContext context, Category category) {
    final filterMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();

    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return MealsScreen(
          title: category.title,
          meals: filterMeals,

        );
      },
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      children: availableCategories
          .map((category) => CategoryGridItem(
                category: category,
                ontap: () => _selectCategory(context, category),
              ))
          .toList(),
      // for (var category in availableCategories)
      //   CategoryGridItem(category: category)
    ));
  }
}
