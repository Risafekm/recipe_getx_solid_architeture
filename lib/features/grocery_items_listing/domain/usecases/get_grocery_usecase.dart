// ignore_for_file: camel_case_types

import 'package:recipes_solid/features/grocery_items_listing/domain/entities/grocery_entity.dart';
import 'package:recipes_solid/features/grocery_items_listing/domain/repositories/grocery_repository.dart';

class GetGroceryUsecase {
  GroceryRepository groceryRepository;

  GetGroceryUsecase(this.groceryRepository);

  Future<List<GroceryEntity>> call() async {
    return await groceryRepository.loadingGroceries();
  }
}
