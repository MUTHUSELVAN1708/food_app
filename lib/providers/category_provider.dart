import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/category.dart';
import '../services/api_service.dart';

final categoriesProvider = FutureProvider<List<Category>>((ref) async {
  return await ApiService.fetchCategories();
});

final categoryByIdProvider = Provider.family<Category?, String>((ref, id) {
  final categoriesAsync = ref.watch(categoriesProvider);
  return categoriesAsync.when(
    data: (categories) => categories.firstWhere((cat) => cat.id == id),
    loading: () => null,
    error: (_, __) => null,
  );
});
