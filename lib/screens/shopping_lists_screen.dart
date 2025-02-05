import 'package:flutter/material.dart';

class ShoppingListsScreen extends StatelessWidget {
  const ShoppingListsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Lists'),
      ),
      body: Center(
        child: Text('Manage your shopping lists here!'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Add new shopping list
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
