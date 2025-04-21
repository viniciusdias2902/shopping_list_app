import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/dummy_items.dart';
import 'package:shopping_list_app/widgets/grocery.dart';

class GroceriesList extends StatelessWidget {
  const GroceriesList({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Your groceries')),
      body: ListView.builder(
        itemCount: groceryItems.length,
        itemBuilder: (ctx, index) => Grocery(groceryItem: groceryItems[index]),
      ),
    );
  }
}
