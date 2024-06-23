import 'package:flutter/material.dart';
import 'package:proj6_meals_app/data/dummy_data.dart';
import 'package:proj6_meals_app/models/category.dart';
import 'package:proj6_meals_app/models/meal.dart';
import 'package:proj6_meals_app/screens/meals.dart';
import 'package:proj6_meals_app/widgets/category_grid_item.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.onToggleFavorite,
    required this.availableMeals,
    required this.ismealfavorite,
  });
  
  final bool Function(Meal meal) ismealfavorite;
  final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeals;


  void _selectCategory(BuildContext context, Category category) {
    final filteredMeals = availableMeals
        .where((meal) => meal.categories.contains(category.id))
        .toList();
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (ctx) => MealsScreen(
                title: category.title,
                meals: filteredMeals,
                onToggleFavorite: onToggleFavorite,
                ismealfavorite: ismealfavorite,
              )),
    );
  }

  @override
  Widget build(context) {
    return GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          /* 
          note: using for in loop is just an alternative 
           to using the list.map() function:
            
            availableCategories.map((category) =>
               CategoryGridItem(category: category)
            ).toList()
          */
          for (final cateogry in availableCategories)
            CategoryGridItem(
              category: cateogry,
              onSelectCategory: () {
                _selectCategory(context, cateogry);
              },
            )
        ]);
  }
}
