import 'package:get/get.dart';
import 'package:recipes_solid/features/grocery_items_listing/domain/entities/grocery_entity.dart';
import 'package:recipes_solid/features/grocery_items_listing/domain/usecases/delete_grocery_usecase.dart';
import 'package:recipes_solid/features/grocery_items_listing/domain/usecases/get_grocery_usecase.dart';
import 'package:recipes_solid/features/grocery_items_listing/domain/usecases/update_grocery_usecase.dart';
import '../../domain/usecases/add_grocery_usecase.dart';

class GroceryController extends GetxController {
  final GetGroceryUsecase getGroceryUseCase;
  final AddGroceryUsecase addGroceryUseCase;
  final DeleteGroceryUsecase deleteGroceryUseCase;
  final UpdateGroceryUsecase updateGroceryUsecase;

  var grocery = <GroceryEntity>[].obs;

  GroceryController({
    required this.getGroceryUseCase,
    required this.addGroceryUseCase,
    required this.deleteGroceryUseCase,
    required this.updateGroceryUsecase,
  });

  @override
  void onInit() {
    super.onInit();
    loadGrocery();
  }

  void loadGrocery() async {
    grocery.value = await getGroceryUseCase.call();
  }

  void addGrocery(GroceryEntity grocery) async {
    await addGroceryUseCase.call(grocery);
    loadGrocery(); // Reload the list after adding
  }

  void deleteGrocery(String id) async {
    await deleteGroceryUseCase.call(id);
    loadGrocery(); // Reload the list after deletion
  }

  void toggleCheckbox(int index, bool? value) {
    // Check if the value is null; if so, default it to false
    final bool isChecked = value ?? false;
    final currentItem = grocery[index];
    // Update the 'isChecked' property of the current item
    currentItem.isChecked = isChecked;
    // Create a new GroceryEntity with the updated state
    final updatedGrocery = GroceryEntity(
      id: currentItem.id,
      name: currentItem.name,
      isChecked: isChecked,
    );
    // Call the update use case to update the item in the repository
    updateGroceryUsecase.call(currentItem.id, updatedGrocery);
    // Reload grocery items to reflect the changes
    loadGrocery();
  }
}
