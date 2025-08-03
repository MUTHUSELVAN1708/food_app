import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_app/core/constants.dart';
import '../providers/food_items_provider.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends ConsumerWidget {
  const CategoryMealsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    final categoryTitle = routeArgs['title'];
    final categoryId = routeArgs['id'];

    final categoryMealsAsync = ref.watch(mealsByCategoryProvider(categoryId!));

    return Scaffold(
      appBar: AppBar(
        title: Text(
          categoryTitle!,
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Constants.brown,
      ),
      body: categoryMealsAsync.when(
        data: (meals) => meals.isEmpty
            ? const Center(
                child: Text(
                  'No meals found for this category!',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return MealItem(meal: meals[index]);
                },
                itemCount: meals.length,
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text(
            'Error loading meals: $error',
            style: TextStyle(fontSize: 18, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
