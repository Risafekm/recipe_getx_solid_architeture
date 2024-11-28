import '../entities/grocery_entity.dart';
import '../repositories/grocery_repository.dart';

class UpdateGroceryUsecase {
  final GroceryRepository groceryRepository;

  UpdateGroceryUsecase(this.groceryRepository);

  // Execute method to update a grocery item
  Future<void> call(String id, GroceryEntity updatedGrocery) async {
    try {
      await groceryRepository.updateGrocery(
          id, updatedGrocery); // Call the repository's update function
    } catch (e) {
      throw Exception('Failed to update grocery: $e'); // Handle errors
    }
  }
}
