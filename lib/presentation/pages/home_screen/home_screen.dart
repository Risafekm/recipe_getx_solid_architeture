import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../domain/entities/recipe.dart';
import '../../controller/recipe_controller.dart';
import 'description.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final RecipeController recipeController = Get.find();
    final List languages = [
      {"name": "english".tr, "locale": const Locale('en', 'US')},
      {"name": "malayalam".tr, "locale": const Locale('ml', 'IN')},
    ];

    void changeLanguage(Locale locale) {
      Get.back();
      final box = Hive.box('language');
      box.put('locale', '${locale.languageCode}_${locale.countryCode}');
      Get.updateLocale(locale);
    }

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('home_appbar'.tr),
        actions: [
          IconButton(
            onPressed: () {
              showDialogBox(context, languages, changeLanguage);
            },
            icon: const Icon(Icons.change_circle),
          ),
        ],
      ),
      body: Obx(() {
        if (recipeController.recipes.isEmpty) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25.0),
            child: Center(
              child: Text(
                'home_content'.tr,
                style: const TextStyle(
                  fontSize: 21,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        }

        return ReorderableListView.builder(
          itemCount: recipeController.recipes.length,
          onReorder: (int oldIndex, int newIndex) async {
            // if (newIndex > oldIndex) {
            //   newIndex -= 1;
            // }
            // final movedRecipe = recipeController.recipes.removeAt(oldIndex);
            // recipeController.recipes.insert(newIndex, movedRecipe);

            // recipeController
            //     .saveRecipesToHive(); // Save the new order after reordering
          },
          itemBuilder: (context, index) {
            final Recipe recipe = recipeController.recipes[index];
            return GestureDetector(
              key: Key(recipe.id),
              onTap: () => Get.to(() => DescriptionScreen(recipeModel: recipe)),
              child: Dismissible(
                key: ValueKey(recipe.id),
                background: Container(
                  color: Colors.red,
                  alignment: Alignment.centerRight,
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: const Icon(
                    Icons.delete,
                    color: Colors.white,
                  ),
                ),
                direction: DismissDirection.endToStart,
                onDismissed: (direction) {
                  recipeController.deleteRecipe(recipe.id);
                  Get.snackbar(
                    'Deleted',
                    '${recipe.title} has been removed from the list',
                    snackPosition: SnackPosition.BOTTOM,
                    duration: const Duration(seconds: 2),
                  );
                },
                confirmDismiss: (direction) async {
                  return await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Are you sure?'),
                      content: const Text('This will delete the item.'),
                      actions: [
                        TextButton(
                          onPressed: () => Get.back(result: false),
                          child: const Text('Cancel'),
                        ),
                        TextButton(
                          onPressed: () => Get.back(result: true),
                          child: const Text('Delete'),
                        ),
                      ],
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.only(left: 16.0, right: 16, top: 6),
                  child: Card(
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(8.0),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            flex: 2,
                            child: recipe.imageUrl.isNotEmpty
                                ? Image.network(
                                    recipe.imageUrl,
                                    height: 100,
                                    width: 100,
                                    fit: BoxFit.fill,
                                    errorBuilder:
                                        (context, error, stackTrace) =>
                                            Container(
                                      height: 80,
                                      width: 80,
                                      decoration: BoxDecoration(
                                        color: Colors.grey,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child:
                                          const Center(child: Text('No image')),
                                    ),
                                  )
                                : Container(
                                    height: 80,
                                    width: 80,
                                    decoration: const BoxDecoration(
                                      color: Colors.white,
                                      image: DecorationImage(
                                          image:
                                              AssetImage('assets/no_image.png'),
                                          scale: .5,
                                          fit: BoxFit.fitHeight),
                                    ),
                                  ),
                          ),
                          const SizedBox(width: 10),
                          Expanded(
                            flex: 4,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(left: 20.0, top: 30),
                              child: Text(recipe.title,
                                  style: const TextStyle(fontSize: 18)),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Future<dynamic> showDialogBox(BuildContext context, List<dynamic> languages,
      void Function(Locale locale) changeLanguage) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('languages'.tr),
          content: SizedBox(
            width: double.maxFinite,
            child: ListView.separated(
              itemCount: languages.length,
              shrinkWrap: true,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () => changeLanguage(languages[index]['locale']),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      languages[index]['name'],
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => const Divider(),
            ),
          ),
        );
      },
    );
  }
}
