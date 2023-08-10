import 'package:flutter/material.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/category_screen.dart';
import 'package:meals/screens/meals_screen.dart';

class TabsScreen extends StatefulWidget {

  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {

  int _selectedScreenIndex = 0;

  final List<Meal> _favoritesMeal = [];

  void _toggleMealFavoritesStatus(Meal meal) {

    final isExisting = _favoritesMeal.contains(meal);

    if(isExisting == true) {
      _favoritesMeal.remove(meal);
    }else {
      _favoritesMeal.add(meal);
    }

  }

  void _selectScreen(int index) {
    setState(() {
       _selectedScreenIndex = index;
    });
  } 

  @override
  Widget build(context) {

    Widget activeScreen = CategoryScreen(onToggleFavorite: _toggleMealFavoritesStatus,);
    var activeScreenTitle = 'Categories';

    if(_selectedScreenIndex == 1) {
       activeScreen =  MealsScreen(meals: [], onToggleFavorite: _toggleMealFavoritesStatus,);
       activeScreenTitle = 'Your favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activeScreenTitle),
      ),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedScreenIndex,
        onTap: _selectScreen,
        items: const  [
          BottomNavigationBarItem(icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}