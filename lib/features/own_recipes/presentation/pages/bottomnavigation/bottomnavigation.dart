// ignore_for_file: sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../home_screen/home_screen.dart';

class BottomNavigator extends StatelessWidget {
  const BottomNavigator({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> items = [
      {
        'icon': Icons.search,
        'title': 'add_from_internet'.tr,
        'pages': '',
      },
      {
        'icon': Icons.add,
        'title': 'new_recipe'.tr,
        'pages': '/add',
      },
      {
        'icon': Icons.document_scanner_rounded,
        'title': 'scan_recipe_beta'.tr,
        'pages': '',
      },
    ];

    return Scaffold(
      body: HomeScreen(),
      bottomNavigationBar: BottomAppBar(
        height: 67,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () => Get.toNamed('/fetch'),
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.restaurant_rounded, size: 24),
                      const SizedBox(height: 3),
                      Flexible(
                        child: Text(
                          'recipe'.tr,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) {
                      return Container(
                        padding: const EdgeInsets.all(16.0),
                        child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: items.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  color: Colors.purple,
                                  borderRadius: BorderRadius.circular(100),
                                ),
                                child: Icon(items[index]['icon'],
                                    color: Colors.white),
                              ),
                              title: Text(
                                items[index]['title'],
                                style: const TextStyle(fontSize: 16),
                              ),
                              onTap: () {
                                // Handle tap on item
                                Get.back(); // Close the bottom sheet
                                Get.toNamed(items[index]['pages']);
                                print('${items[index]['title']} tapped!');
                              },
                            );
                          },
                        ),
                      );
                    },
                  );
                },
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.add_box_outlined, size: 24),
                      const SizedBox(height: 3),
                      Flexible(
                        child: Text(
                          'add'.tr,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: GestureDetector(
                onTap: () => Get.toNamed('/grocery'),
                child: Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.local_grocery_store_rounded, size: 24),
                      const SizedBox(height: 3),
                      Flexible(
                        child: Text(
                          'grocery'.tr,
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.bold),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
