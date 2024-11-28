import 'package:recipes_solid/features/online_recipes/domain/entities/fetch_entity.dart';

abstract class FetchRepository {
  Future<List<FetchEntity>> getFetchRecipe();
}
