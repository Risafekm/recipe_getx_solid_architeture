// lib/domain/models/grocery_model/grocery_model.dart
import 'package:hive/hive.dart';
import '../../domain/entities/grocery_entity.dart';
part 'grocery_model.g.dart';

@HiveType(typeId: 2)
class GroceryModel extends GroceryEntity {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final bool isChecked;

  GroceryModel({
    required this.id,
    required this.name,
    bool? isChecked, // Optional
  })  : isChecked = isChecked ?? false, // Default to false if null
        super(
          id: id,
          name: name,
          isChecked: isChecked ?? false, // Default in entity as well
        );

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'isChecked': isChecked,
    };
  }

  // Convert from JSON
  factory GroceryModel.fromJson(Map<String, dynamic> json) {
    return GroceryModel(
      id: json['id'],
      name: json['name'],
      isChecked: json['isChecked'] ?? false,
    );
  }

  // Convert from GroceryEntity to GroceryModel
  factory GroceryModel.fromEntity(GroceryEntity entity) {
    return GroceryModel(
      id: entity.id,
      name: entity.name,
      isChecked: entity.isChecked,
    );
  }

  // Convert GroceryModel to GroceryEntity
  GroceryEntity toEntity() {
    return GroceryEntity(
      id: id,
      name: name,
      isChecked: isChecked,
    );
  }
}
