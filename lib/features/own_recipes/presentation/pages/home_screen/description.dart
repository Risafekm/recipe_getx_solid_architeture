// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:recipes_solid/features/own_recipes/domain/entities/recipe.dart';

class DescriptionScreen extends StatelessWidget {
  Recipe recipeModel;
  DescriptionScreen({super.key, required this.recipeModel});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Get.back(),
          child: const Icon(Icons.arrow_back_ios),
        ),
        automaticallyImplyLeading: false,
        title: Text('description'.tr),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),
            // Center(
            //   child: Image.network(
            //     recipeModel.imageUrl,
            //     height: 250,
            //     width: double.infinity,
            //     errorBuilder: (context, error, stackTrace) => Container(
            //       height: 250,
            //       width: 300,
            //       decoration: BoxDecoration(
            //         color: Colors.grey,
            //         borderRadius: BorderRadius.circular(20),
            //       ),
            //       child: Container(
            //         height: 80,
            //         width: 80,
            //         decoration: const BoxDecoration(
            //           color: Colors.white,
            //           image: DecorationImage(
            //               image: AssetImage('assets/no_image.png'),
            //               scale: .5,
            //               fit: BoxFit.fitHeight),
            //         ),
            //       ),
            //     ), // Display if network fails
            //   ),
            // ),
            const SizedBox(height: 20),
            Center(
              child: Text(
                recipeModel.title,
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),
            const Padding(
              padding: EdgeInsets.only(left: 20.0),
              child: Text('Cooking Time',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 10),
            // Padding(
            //   padding: const EdgeInsets.only(left: 20.0),
            //   child: Text(recipeModel.cookingTime,
            //       style: const TextStyle(
            //           fontSize: 16, fontWeight: FontWeight.w300)),
            // ),
            // const SizedBox(height: 20),
            // const Padding(
            //   padding: EdgeInsets.only(left: 20.0),
            //   child: Text('ingredients',
            //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            // ),
            // const SizedBox(height: 7),
            // Padding(
            //   padding: const EdgeInsets.only(left: 20.0),
            //   child: Text("${recipeModel.ingredients}",
            //       style: const TextStyle(
            //           fontSize: 16, fontWeight: FontWeight.w300)),
            // ),
            // const SizedBox(height: 30),
            // const Padding(
            //   padding: EdgeInsets.only(left: 20.0),
            //   child: Text('Making',
            //       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            // ),
            // SizedBox(height: 7),
            // Padding(
            //   padding: const EdgeInsets.only(left: 20.0),
            //   child: Text("${recipeModel.description}",
            //       style: const TextStyle(
            //           fontSize: 16, fontWeight: FontWeight.w300)),
            // ),
          ],
        ),
      ),
    );
  }
}
