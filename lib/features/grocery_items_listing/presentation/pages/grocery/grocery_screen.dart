import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipes_solid/features/grocery_items_listing/domain/entities/grocery_entity.dart';
import 'package:uuid/uuid.dart';
import '../../../../own_recipes/presentation/widgets/text_area.dart';
import '../../controller/grocery_controller.dart';

class GroceryScreen extends StatelessWidget {
  final nameController = TextEditingController();
  GroceryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final GroceryController groceryController = Get.find();

    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios),
        ),
        title: Text('grocery_appbar'.tr),
        automaticallyImplyLeading: false,
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: const Text('Header'),
                    content: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.8,
                      child: SingleChildScrollView(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            TextArea(
                              keyboardType: TextInputType.name,
                              name: 'grocery name',
                              prefixIcon: const Icon(
                                Icons.local_grocery_store,
                              ),
                              controller: nameController,
                              validator: (value) {
                                return null;
                              },
                              suffixIcon: const Icon(
                                Icons.abc,
                                color: Colors.transparent,
                              ),
                              obscureText: false,
                              lines: 1,
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text('Close'),
                      ),
                      TextButton(
                        onPressed: () {
                          final grocery = GroceryEntity(
                              id: Uuid().v4(), name: nameController.text);
                          groceryController.addGrocery(grocery);
                          nameController.clear();
                          Get.back();
                        },
                        child: const Text('Save'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Obx(
        () {
          if (groceryController.grocery.isEmpty) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Center(
                child: Text(
                  'grocery'.tr,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            );
          }
          return ListView.builder(
            itemCount: groceryController.grocery.length,
            itemBuilder: (context, index) {
              final GroceryEntity grocery = groceryController.grocery[index];
              int currentIndex = index + 1;

              return Dismissible(
                key: ValueKey(
                    grocery.name + index.toString()), // Ensure unique key
                crossAxisEndOffset: 0.8,
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
                  groceryController.deleteGrocery(grocery.id);

                  Get.snackbar(
                    'Deleted',
                    '${grocery.name} has been removed from the list',
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
                  padding: const EdgeInsets.only(left: 8.0, top: 8, right: 8),
                  child: Card(
                    child: ListTile(
                      leading: CircleAvatar(
                        child: Text('$currentIndex'),
                      ),
                      title: Text(
                        grocery.name,
                        style: TextStyle(
                          decoration: grocery.isChecked
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                          color: grocery.isChecked ? Colors.grey : Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: Checkbox(
                        value: grocery.isChecked,
                        onChanged: (value) {
                          groceryController.toggleCheckbox(index, value);
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
