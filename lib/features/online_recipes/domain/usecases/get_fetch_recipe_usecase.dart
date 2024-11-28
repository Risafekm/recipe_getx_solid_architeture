import 'package:recipes_solid/features/online_recipes/domain/entities/fetch_entity.dart';

import '../repositories/fetch_repository.dart';

class GetFetchRecipeUsecase {
  FetchRepository fetchRepository;

  GetFetchRecipeUsecase({required this.fetchRepository});

  Future<List<FetchEntity>> call() async {
    return await fetchRepository.getFetchRecipe();
  }
}
