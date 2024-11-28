import '../entities/grocery_entity.dart';

abstract class GroceryRepository {
  Future<List<GroceryEntity>> loadingGroceries();

  Future<void> addGrocery(GroceryEntity grocery);

  Future<void> deleteGrocery(String id);

  Future<void> updateGrocery(String id, GroceryEntity updatedGrocery);
}
