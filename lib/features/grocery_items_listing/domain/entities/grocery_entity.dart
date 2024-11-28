class GroceryEntity {
  String id;
  String name;
  bool isChecked;

  GroceryEntity({
    required this.id,
    required this.name,
    bool? isChecked, // Optional
  }) : isChecked = isChecked ?? false; // Default to false if null
}
