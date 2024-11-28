import 'package:hive_flutter/hive_flutter.dart';
import 'package:recipes_solid/features/grocery_items_listing/data/models/grocery_model.dart';

abstract class GroceryLocalDataSource {
  Future<List<GroceryModel>> loadingGroceries();
  Future<void> addGroceries(GroceryModel grocery);
  Future<void> deleteGrocery(String id);
  Future<void> updateGrocery(String id, GroceryModel updatedGrocery);
}

class GroceryLocalDataSourceImpl implements GroceryLocalDataSource {
  final Box<GroceryModel> groceryBox;

  GroceryLocalDataSourceImpl(this.groceryBox);

  @override
  Future<void> addGroceries(GroceryModel grocery) async {
    await groceryBox.put(grocery.id, grocery);
  }

  @override
  Future<void> deleteGrocery(String id) async {
    await groceryBox.delete(id);
  }

  @override
  Future<List<GroceryModel>> loadingGroceries() async {
    return groceryBox.values.toList();
  }

  @override
  Future<void> updateGrocery(String id, GroceryModel updatedGrocery) async {
    if (groceryBox.containsKey(id)) {
      await groceryBox.put(id, updatedGrocery); // Update item
    } else {
      throw Exception("Grocery with id $id not found.");
    }
  }
}
