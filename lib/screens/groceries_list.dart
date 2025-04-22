import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shopping_list_app/data/categories.dart';
import 'package:shopping_list_app/data/dummy_items.dart';
import 'package:shopping_list_app/models/grocery_item.dart';
import 'package:shopping_list_app/screens/new_item.dart';
import 'package:shopping_list_app/widgets/grocery.dart';
import 'package:http/http.dart' as http;

class GroceriesList extends StatefulWidget {
  const GroceriesList({super.key});

  @override
  State<GroceriesList> createState() => _GroceriesListState();
}

class _GroceriesListState extends State<GroceriesList> {
  List<GroceryItem> _groceryItems = [];
  void _loadItems() async {
    final url = Uri.https(
      'dummy-backend-27d29-default-rtdb.firebaseio.com',
      'shopping-list.json',
    );
    final response = await http.get(url);
    final Map<String, dynamic> listData = json.decode(response.body);
    final List<GroceryItem> _loadedItems = [];
    for (final item in listData.entries) {
      final category =
          categories.entries
              .firstWhere(
                (catItem) => catItem.value.name == item.value['category'],
              )
              .value;
      _loadedItems.add(
        GroceryItem(
          id: item.key,
          name: item.value['name'],
          quantity: item.value['quantity'],
          category: category,
        ),
      );
    }
    setState(() {
      _groceryItems = _loadedItems;
    });
  }

  void addItem() async {
    await Navigator.of(
      context,
    ).push<GroceryItem>(MaterialPageRoute(builder: (ctx) => NewItem()));

    _loadItems();
  }

  @override
  void initState() {
    super.initState();
    _loadItems();
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
                  (ctx, index) => Dismissible(
                    onDismissed: (direction) {
                      setState(() {
                        _groceryItems.remove(_groceryItems[index]);
                      });
                    },
                    key: ValueKey(_groceryItems[index].id),
                    child: Grocery(groceryItem: _groceryItems[index]),
                  ),
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
