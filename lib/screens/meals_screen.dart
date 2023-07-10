// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import 'package:flutter_meals_apps/models/meals.dart';
import 'package:flutter_meals_apps/screens/meal_details_screen.dart';
import 'package:flutter_meals_apps/widgets/meals_item.dart';

class MealsScreen extends StatelessWidget {
  final String? title;
  final List<Meal> meals;

  const MealsScreen({
    Key? key,
    this.title,
    required this.meals,
  }) : super(key: key);

  void _navigateMealDetails(BuildContext context, Meal meals) {
    print('Navigating to MealDetailScreen');
    Navigator.push(context, MaterialPageRoute(builder: (context) {
      return MealDetailScreen(
        meal: meals,
      );
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title == null ? '' : title!),
      ),
      body: meals.isEmpty
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'There no data here for now',
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(
                    'Please pick other category',
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: Theme.of(context).colorScheme.onBackground),
                  ),
                ],
              ),
            )
          : ListView.builder(
              itemCount: meals.length,
              itemBuilder: (context, index) {
                return MealItems(
                  meal: meals[index],
                  onSelectedMeal: (Meal meal) {
                    _navigateMealDetails(context, meal);
                  },
                );
              }),
    );
  }
}
