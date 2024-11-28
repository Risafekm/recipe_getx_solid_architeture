import 'package:recipes_solid/features/grocery_items_listing/data/datasources/grocery_local_data_source.dart';
import 'package:recipes_solid/features/grocery_items_listing/domain/entities/grocery_entity.dart';
import 'package:recipes_solid/features/grocery_items_listing/domain/repositories/grocery_repository.dart';

import '../models/grocery_model.dart';

class GroceryRepositoryImpl implements GroceryRepository {
  GroceryLocalDataSource groceryLocalDataSource;

  GroceryRepositoryImpl(this.groceryLocalDataSource);
  @override
  Future<void> addGrocery(GroceryEntity grocery) async {
    final groceryModel = GroceryModel.fromEntity(grocery); // Convert to model
    await groceryLocalDataSource
        .addGroceries(groceryModel); // Store in local data source
  }

  @override
  Future<void> deleteGrocery(String id) async {
    await groceryLocalDataSource.deleteGrocery(id);
  } // Delete from local data source}

  @override
  Future<List<GroceryEntity>> loadingGroceries() async {
    final groceryModel = await groceryLocalDataSource.loadingGroceries();
    return groceryModel.map((model) => model.toEntity()).toList();
  }

  @override
  Future<void> updateGrocery(String id, GroceryEntity updatedGrocery) async {
    final groceryModel =
        GroceryModel.fromEntity(updatedGrocery); // Convert to model
    await groceryLocalDataSource.updateGrocery(id, groceryModel);
  }
}
