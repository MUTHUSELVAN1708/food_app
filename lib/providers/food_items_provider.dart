import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/food_item.dart';
import '../services/api_service.dart';

class FiltersState {
  final bool isGlutenFree;
  final bool isLactoseFree;
  final bool isVegan;
  final bool isVegetarian;

  const FiltersState({
    this.isGlutenFree = false,
    this.isLactoseFree = false,
    this.isVegan = false,
    this.isVegetarian = false,
  });

  FiltersState copyWith({
    bool? isGlutenFree,
    bool? isLactoseFree,
    bool? isVegan,
    bool? isVegetarian,
  }) {
    return FiltersState(
      isGlutenFree: isGlutenFree ?? this.isGlutenFree,
      isLactoseFree: isLactoseFree ?? this.isLactoseFree,
      isVegan: isVegan ?? this.isVegan,
      isVegetarian: isVegetarian ?? this.isVegetarian,
    );
  }
}

class FiltersNotifier extends StateNotifier<FiltersState> {
  FiltersNotifier() : super(const FiltersState());

  void setGlutenFree(bool value) {
    state = state.copyWith(isGlutenFree: value);
  }

  void setLactoseFree(bool value) {
    state = state.copyWith(isLactoseFree: value);
  }

  void setVegan(bool value) {
    state = state.copyWith(isVegan: value);
  }

  void setVegetarian(bool value) {
    state = state.copyWith(isVegetarian: value);
  }
}

final filtersProvider =
    StateNotifierProvider<FiltersNotifier, FiltersState>((ref) {
  return FiltersNotifier();
});

final foodItemsProvider = FutureProvider<List<FoodItem>>((ref) async {
  return await ApiService.fetchFoods();
});

final filteredFoodItemsProvider = Provider<AsyncValue<List<FoodItem>>>((ref) {
  final mealsAsync = ref.watch(foodItemsProvider);
  final filters = ref.watch(filtersProvider);

  return mealsAsync.when(
    data: (meals) => AsyncValue.data(
      meals.where((meal) {
        if (filters.isGlutenFree && !meal.isGlutenFree) {
          return false;
        }
        if (filters.isLactoseFree && !meal.isLactoseFree) {
          return false;
        }
        if (filters.isVegan && !meal.isVegan) {
          return false;
        }
        if (filters.isVegetarian && !meal.isVegetarian) {
          return false;
        }
        return true;
      }).toList(),
    ),
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

final mealsByCategoryProvider =
    Provider.family<AsyncValue<List<FoodItem>>, String>((ref, categoryId) {
  final filteredMealsAsync = ref.watch(filteredFoodItemsProvider);

  return filteredMealsAsync.when(
    data: (meals) => AsyncValue.data(
      meals.where((meal) => meal.categories.contains(categoryId)).toList(),
    ),
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});

final mealByIdProvider =
    Provider.family<AsyncValue<FoodItem?>, String>((ref, id) {
  final mealsAsync = ref.watch(foodItemsProvider);

  return mealsAsync.when(
    data: (meals) {
      try {
        final meal = meals.firstWhere((meal) => meal.id == id);
        return AsyncValue.data(meal);
      } catch (e) {
        return const AsyncValue.data(null);
      }
    },
    loading: () => const AsyncValue.loading(),
    error: (error, stack) => AsyncValue.error(error, stack),
  );
});
