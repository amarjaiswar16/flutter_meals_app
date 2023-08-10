import 'package:flutter/material.dart';
import 'package:meals/data/dummy_data.dart';
import 'package:meals/models/meal.dart';
import 'package:meals/screens/category_screen.dart';
import 'package:meals/screens/filters_screen.dart';
import 'package:meals/screens/meals_screen.dart';
import 'package:meals/widgets/main_drawer.dart';


const kInitialFilters = {
    Filter.glutenFree: false,
    Filter.lactoseFree: false,
    Filter.vegetarian: false,
    Filter.vegan: false,
  };

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
  Map<Filter,bool> _selectedFilters = kInitialFilters;

  void _showInfoMessage(String message) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
      ),
    );
  }

  void _toggleMealFavoritesStatus(Meal meal) {
    final isExisting = _favoritesMeal.contains(meal);

    if (isExisting == true) {
      setState(() {
        _favoritesMeal.remove(meal);
        _showInfoMessage('Meal is no longer a favorite.');
      });
    } else {
      setState(() {
        _favoritesMeal.add(meal);
        _showInfoMessage('Marked as a favorite.');
      });
    }
  }

  void _selectScreen(int index) {
    setState(() {
      _selectedScreenIndex = index;
    });
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
     final result = await Navigator.of(context).push<Map<Filter,bool>>(
        MaterialPageRoute(
          builder: (ctx) =>  FiltersScreen(currentFilter: _selectedFilters,),
        ),
      );
      setState(() {
         _selectedFilters = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(context) {
    final availableMeals = dummyMeals.where((meal) {
      if(_selectedFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if(_selectedFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if(_selectedFilters[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if(_selectedFilters[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();

    Widget activeScreen = CategoryScreen(
      onToggleFavorite: _toggleMealFavoritesStatus,
      availableMeals: availableMeals,
    );
    var activeScreenTitle = 'Categories';

    if (_selectedScreenIndex == 1) {
      activeScreen = MealsScreen(
        meals: _favoritesMeal,
        onToggleFavorite: _toggleMealFavoritesStatus,
      );
      activeScreenTitle = 'Your favorites';
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(activeScreenTitle),
      ),
      drawer: MainDrawer(onSelectedScreen: _setScreen),
      body: activeScreen,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedScreenIndex,
        onTap: _selectScreen,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.set_meal), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
