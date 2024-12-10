import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:travel_savy/constants/constants.dart';

class CategoryController extends GetxController {

  var categoryList = [].obs; // Menyimpan daftar kategori
  var isLoading = false.obs; // Indikator loading

  /// Ambil semua kategori
  Future<void> fetchCategories() async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        categoryList.value = json.decode(response.body); // Update data kategori
        print("Categories fetched: ${categoryList.value}");
      } else {
        Get.snackbar("Error", "Failed to fetch categories");
      }
    } catch (e) {
      print("Error fetching categories: $e");
      Get.snackbar("Error", "An error occurred while fetching categories");
    } finally {
      isLoading.value = false;
    }
  }

  /// Tambah kategori baru
  Future<void> addCategory(String name) async {
    isLoading.value = true;
    try {
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"name": name}),
      );

      if (response.statusCode == 201) {
        final newCategory = json.decode(response.body)['data'];
        categoryList.add(newCategory); // Tambahkan kategori baru ke list
        Get.snackbar("Success", "Category added successfully!");
      } else {
        final message = json.decode(response.body)['message'] ?? "Failed to add category";
        Get.snackbar("Error", message);
      }
    } catch (e) {
      print("Error adding category: $e");
      Get.snackbar("Error", "An error occurred while adding category");
    } finally {
      isLoading.value = false;
    }
  }

  /// Ambil detail kategori berdasarkan ID
  Future<void> fetchCategoryById(int id) async {
    isLoading.value = true;
    try {
      final response = await http.get(Uri.parse('$baseUrl/$id'));

      if (response.statusCode == 200) {
        final category = json.decode(response.body);
        print("Category details: $category");
      } else {
        Get.snackbar("Error", "Failed to fetch category details");
      }
    } catch (e) {
      print("Error fetching category by ID: $e");
      Get.snackbar("Error", "An error occurred while fetching category details");
    } finally {
      isLoading.value = false;
    }
  }

  /// Update kategori berdasarkan ID
  Future<void> updateCategory(int id, String name) async {
    isLoading.value = true;
    try {
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {"Content-Type": "application/json"},
        body: json.encode({"name": name}),
      );

      if (response.statusCode == 200) {
        final updatedCategory = json.decode(response.body)['data'];

        // Update kategori di list
        int index = categoryList.indexWhere((category) => category['id'] == id);
        if (index != -1) {
          categoryList[index] = updatedCategory;
        }

        Get.snackbar("Success", "Category updated successfully!");
      } else {
        final message = json.decode(response.body)['message'] ?? "Failed to update category";
        Get.snackbar("Error", message);
      }
    } catch (e) {
      print("Error updating category: $e");
      Get.snackbar("Error", "An error occurred while updating category");
    } finally {
      isLoading.value = false;
    }
  }

  /// Hapus kategori berdasarkan ID
  Future<void> deleteCategory(int id) async {
    isLoading.value = true;
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$id'));

      if (response.statusCode == 200) {
        // Hapus kategori dari list
        categoryList.removeWhere((category) => category['id'] == id);
        Get.snackbar("Success", "Category deleted successfully!");
      } else {
        final message = json.decode(response.body)['message'] ?? "Failed to delete category";
        Get.snackbar("Error", message);
      }
    } catch (e) {
      print("Error deleting category: $e");
      Get.snackbar("Error", "An error occurred while deleting category");
    } finally {
      isLoading.value = false;
    }
  }
}
