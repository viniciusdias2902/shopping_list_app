import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/dummy_items.dart';
import 'package:shopping_list_app/widgets/grocery.dart';

class GroceriesScreen extends StatelessWidget {
  const GroceriesScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your groceries')),
      body: Column(
        children:
            groceryItems
                .map((groceryItem) => Grocery(groceryItem: groceryItem))
                .toList(),
      ),
    );
  }
}
