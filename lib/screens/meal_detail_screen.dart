import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_app/core/constants.dart';
import 'package:foods_app/providers/favorite_provider.dart';
import '../providers/food_items_provider.dart';

class MealDetailScreen extends ConsumerWidget {
  const MealDetailScreen({super.key});

  Widget buildSectionTitle(BuildContext context, String text) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        text,
        style: Theme.of(context)
            .textTheme
            .titleLarge
            ?.copyWith(color: Color(0xFFEFAF96)),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final selectedMealAsync = ref.watch(mealByIdProvider(mealId));
    final favoritesNotifier = ref.read(favoritesProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: selectedMealAsync.when(
          data: (meal) => Text(
            meal?.title ?? 'Meal not found',
            style: TextStyle(color: Colors.white),
          ),
          loading: () => const Text('Loading...'),
          error: (_, __) => const Text('Error'),
        ),
        centerTitle: true,
        backgroundColor: Constants.brown,
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
              onPressed: () async {
                await favoritesNotifier.toggleFavorite(mealId);
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    backgroundColor: Color(0xFFEACFC9),
                    duration: Duration(seconds: 2),
                    content: Text(
                        ref.watch(favoritesProvider).contains(mealId)
                            ? 'Meal added to favorites'
                            : 'Meal removed from favorites',
                        style: TextStyle(color: Colors.black))));
              },
              icon: Icon(ref.watch(favoritesProvider).contains(mealId)
                  ? Icons.star
                  : Icons.star_border_purple500_sharp))
        ],
      ),
      body: selectedMealAsync.when(
        data: (selectedMeal) {
          if (selectedMeal == null) {
            return const Center(
              child: Text('Meal not found!',
                  style: TextStyle(color: Colors.white)),
            );
          }

          return SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 300,
                  width: double.infinity,
                  child: Image.network(
                    selectedMeal.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Container(
                        color: Colors.grey[300],
                        child: const Icon(Icons.image_not_supported, size: 50),
                      );
                    },
                  ),
                ),
                buildSectionTitle(context, 'Ingredients'),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: selectedMeal.ingredients.length,
                  itemBuilder: (ctx, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      // vertical: 5,
                      horizontal: 10,
                    ),
                    child: Text(
                      selectedMeal.ingredients[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                buildSectionTitle(context, 'Steps'),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: selectedMeal.steps.length,
                  itemBuilder: (ctx, index) => Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 10,
                    ),
                    child: Text(
                      selectedMeal.steps[index],
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white, fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text(
            'Error loading meal: $error',
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
