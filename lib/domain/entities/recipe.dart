class Recipe {
  final String id;
  final String title;
  final String description;
  final String imageUrl;
  final String cookingTime;
  final String ingredients;

  Recipe({
    this.id = '',
    this.title = '',
    this.description = '',
    this.imageUrl = '', // Default to empty string
    this.cookingTime = '', // Default to empty string
    this.ingredients = '', // Default to empty list
  });
}
