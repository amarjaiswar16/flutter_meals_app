import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/category.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/category_grid_item.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key, required this.onToggleFavorite, required this.availableMeals});

  final void Function(Meal meal) onToggleFavorite;
  final List<Meal> availableMeals;

  void _selectCategory(BuildContext context, iCategory category) {

    final filteredMeals = availableMeals.where((meal) => meal.categories.contains(category.id)).toList();

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealsScreen(
          title: category.title,
          meals: filteredMeals,
          onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (ctx) => MealsScreen(
    //       title: 'Some title',
    //       meals: [],
    //     ),
    //   ),
    // );
  }

  @override
  Widget build(context) {
    return  GridView(
        padding: const EdgeInsets.all(24),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(category: category,onSelectCategory: (){
              _selectCategory(context, category);
            },)
          //availableCategories.map((category) => CategoryGridItem(category: category)).toList(),
        ],
      );
  }
}
