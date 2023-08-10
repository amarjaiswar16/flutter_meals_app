import 'package:flutter/material.dart';

class CategoryScreen extends StatelessWidget {
  const CategoryScreen({super.key});

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pick your category'),
      ),
      body: GridView(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          ),
          children: const [
            Text('1', style: TextStyle(color: Colors.white),),
            Text('1', style: TextStyle(color: Colors.white),),
            Text('1', style: TextStyle(color: Colors.white),),
            Text('1', style: TextStyle(color: Colors.white),),
            Text('1', style: TextStyle(color: Colors.white),),
            Text('1', style: TextStyle(color: Colors.white),),
            Text('1', style: TextStyle(color: Colors.white),),
            Text('1', style: TextStyle(color: Colors.white),),
            
          ],
      ),
    );
  }

}