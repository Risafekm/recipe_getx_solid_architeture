import '../repositories/grocery_repository.dart';

class DeleteGroceryUsecase {
  GroceryRepository groceryRepository;

  DeleteGroceryUsecase(this.groceryRepository);

  Future<void> call(String id) async {
    await groceryRepository.deleteGrocery(id);
  }
}
