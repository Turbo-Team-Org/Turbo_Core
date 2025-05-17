import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/turbo_core_repositories/category_repository/interface/category_interface.dart';
import 'package:core/src/turbo_core_repositories/category_repository/model/category.dart';

/// Category service
class CategoryService implements CategoryInterface {
  /// Constructor
  CategoryService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Firestore instance
  final FirebaseFirestore _firestore;

  /// Collection reference
  CollectionReference<Map<String, dynamic>> get categoriesCollection =>
      _firestore.collection('categories');

  /// Get all categories
  Future<List<Category>> getAllCategories() async {
    final snapshot = await categoriesCollection.get();
    return snapshot.docs
        .map((doc) => Category.fromJson({'id': doc.id, ...doc.data()}))
        .toList();
  }

  /// Get category by id
  @override
  Future<Category> getCategoryById(String id) async {
    final doc = await categoriesCollection.doc(id).get();
    if (doc.exists) {
      return Category.fromJson({'id': doc.id, ...doc.data() ?? {}});
    }
    throw Exception('Category not found');
  }

  /// Add category
  @override
  Future<void> addCategory(Category category) async {
    await categoriesCollection
        .doc(category.id)
        .set(category.toJson()..remove('id'));
  }

  /// Update category
  @override
  Future<void> updateCategory(Category category) async {
    await categoriesCollection
        .doc(category.id)
        .update(category.toJson()..remove('id'));
  }

  /// Delete category
  @override
  Future<void> deleteCategory(String id) async {
    await categoriesCollection.doc(id).delete();
  }

  /// Get categories
  @override
  Future<List<Category>> getCategories() {
    return getAllCategories();
  }

  /// Get category by name
  @override
  Future<Category> getCategoryByName(String name) {
    return getCategoryByName(name);
  }
}
