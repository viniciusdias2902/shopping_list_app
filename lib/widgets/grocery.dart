import 'package:flutter/material.dart';
import 'package:shopping_list_app/models/grocery_item.dart';

class Grocery extends StatelessWidget {
  const Grocery({super.key, required this.groceryItem});
  final GroceryItem groceryItem;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        width: 24,
        height: 24,
        color: groceryItem.category.color,
      ),
      title: Text(groceryItem.name),
      trailing: Text(groceryItem.quantity.toString()),
    );
  }
}
