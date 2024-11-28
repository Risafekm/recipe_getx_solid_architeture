import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipes_solid/features/own_recipes/presentation/widgets/button.dart';
import 'package:recipes_solid/features/own_recipes/presentation/widgets/text_area.dart';
import 'package:uuid/uuid.dart';
import '../../../domain/entities/recipe.dart';
import '../../controller/recipe_controller.dart';

class AddRecipeScreen extends StatelessWidget {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _cookingTimeController = TextEditingController();
  final _ingredientsController = TextEditingController();

  AddRecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final RecipeController recipeController = Get.find();

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: Text('new_recipe'.tr),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextArea(
              controller: _titleController,
              keyboardType: TextInputType.text,
              name: 'Recipe Name',
              prefixIcon: const Icon(Icons.restaurant),
              validator: (value) {},
              suffixIcon: const Icon(Icons.abc, color: Colors.transparent),
              obscureText: false,
              lines: 1,
            ),
            const SizedBox(height: 10),
            TextArea(
              controller: _imageUrlController,
              keyboardType: TextInputType.text,
              name: 'Image Url',
              prefixIcon: const Icon(Icons.image),
              validator: (value) {},
              suffixIcon: const Icon(Icons.abc, color: Colors.transparent),
              obscureText: false,
              lines: 1,
            ),
            const SizedBox(height: 10),
            TextArea(
              controller: _descriptionController,
              keyboardType: TextInputType.multiline,
              name: 'Recipe Description',
              prefixIcon: const Icon(Icons.description),
              validator: (value) {},
              suffixIcon: const Icon(Icons.abc, color: Colors.transparent),
              obscureText: false,
              lines: 10,
            ),
            const SizedBox(height: 10),
            TextArea(
              controller: _cookingTimeController,
              keyboardType: TextInputType.text,
              name: 'Cooking Time',
              prefixIcon: const Icon(Icons.timelapse),
              validator: (value) {},
              suffixIcon: const Icon(Icons.abc, color: Colors.transparent),
              obscureText: false,
              lines: 1,
            ),
            const SizedBox(height: 10),
            TextArea(
              controller: _ingredientsController,
              keyboardType: TextInputType.multiline,
              name: 'Ingredients',
              prefixIcon: const Icon(Icons.food_bank),
              validator: (value) {},
              suffixIcon: const Icon(Icons.abc, color: Colors.transparent),
              obscureText: false,
              lines: 10,
            ),
            const SizedBox(height: 20),
            Button(
              text: 'Save',
              onTap: () async {
                final recipe = Recipe(
                  id: Uuid().v4(),
                  title: _titleController.text,
                  description: _descriptionController.text,
                  imageUrl: _imageUrlController.text,
                  cookingTime: _cookingTimeController.text,
                  ingredients: _ingredientsController.text,
                );
                recipeController.addRecipe(recipe);
//
                Get.back(); // Close the current screen
              },
            ),
          ],
        ),
      ),
    );
  }
}
