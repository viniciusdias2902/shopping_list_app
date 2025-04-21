import 'package:flutter/material.dart';
import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:shopping_list_app/screens/new_item.dart';
import 'package:shopping_list_app/widgets/grocery.dart';

class GroceriesList extends StatefulWidget {
  const GroceriesList({super.key});

  @override
  State<GroceriesList> createState() => _GroceriesListState();
}

class _GroceriesListState extends State<GroceriesList> {
  final List<GroceryItem> _groceryItems = [];
  void addItem() async {
    final newItem = await Navigator.of(
      context,
    ).push<GroceryItem>(MaterialPageRoute(builder: (ctx) => NewItem()));
    if (newItem == null) {
      return;
    }
    setState(() {
      _groceryItems.add(newItem);
    });
  }

  @override
  Widget build(BuildContext context) {
    final content =
        _groceryItems.isEmpty
            ? Center(
              child: const Text(
                'No items added',
                style: TextStyle(fontSize: 24),
              ),
            )
            : ListView.builder(
              itemCount: _groceryItems.length,
              itemBuilder:
                  (ctx, index) => Grocery(groceryItem: _groceryItems[index]),
            );
    return Scaffold(
      appBar: AppBar(
        title: Text('Your groceries'),
        actions: [IconButton(onPressed: addItem, icon: Icon(Icons.add))],
      ),
      body: content,
    );
  }
}
