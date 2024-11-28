import '../entities/grocery_entity.dart';
import '../repositories/grocery_repository.dart';

class AddGroceryUsecase {
  GroceryRepository groceryRepository;

  AddGroceryUsecase(this.groceryRepository);

  Future<void> call(GroceryEntity grocery) async {
    await groceryRepository.addGrocery(grocery);
  }
}
