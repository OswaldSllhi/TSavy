import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:travel_savy/controllers/CategoryController.dart';

class CategoriesPage extends StatelessWidget {
  final CategoryController categoryController = Get.put(CategoryController());

  CategoriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
      ),
      body: Obx(() {
        if (categoryController.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (categoryController.categories.isEmpty) {
          return const Center(child: Text('Tidak ada kategori tersedia.'));
        }

        return ListView.builder(
          itemCount: categoryController.categories.length,
          itemBuilder: (context, index) {
            final category = categoryController.categories[index];
            return Card(
              margin: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: CircleAvatar(
                  child: Text('${category['id']}'),
                ),
                title: Text(category['name']),
              ),
            );
          },
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => categoryController.fetchCategories(),
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
