import 'package:flutter/material.dart';
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

  void _selectScreen(int index) {
    setState(() {
       _selectedScreenIndex = index;
    });
  } 

  @override
  Widget build(context) {

    Widget activeScreen = const CategoryScreen();
    var activeScreenTitle = 'Categories';

    if(_selectedScreenIndex == 1) {
       activeScreen = const MealsScreen(meals: []);
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