import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/food_item.dart';
import 'food_items_provider.dart';

class FavoritesNotifier extends StateNotifier<List<String>> {
  FavoritesNotifier() : super([]);

  Future<void> loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final favorites = prefs.getStringList('favorites') ?? [];
    state = favorites;
  }

  Future<void> toggleFavorite(String mealId) async {
    final currentFavorites = [...state];

    if (currentFavorites.contains(mealId)) {
      currentFavorites.remove(mealId);
    } else {
      currentFavorites.add(mealId);
    }

    state = currentFavorites;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('favorites', currentFavorites);
  }
}

final favoritesProvider =
    StateNotifierProvider<FavoritesNotifier, List<String>>((ref) {
  return FavoritesNotifier();
});

final favoriteMealsProvider = Provider<AsyncValue<List<FoodItem>>>((ref) {
  final favoriteIds = ref.watch(favoritesProvider);
  final allMealsAsync = ref.watch(foodItemsProvider);

  return allMealsAsync.when(
    data: (meals) => AsyncValue.data(
      meals.where((meal) => favoriteIds.contains(meal.id)).toList(),
    ),
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});
