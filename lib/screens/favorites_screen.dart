import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_app/providers/favorite_provider.dart';
import '../widgets/meal_item.dart';
import '../widgets/main_drawer.dart';

class FavoritesScreen extends ConsumerWidget {
  final bool showDrawer;

  const FavoritesScreen({super.key, this.showDrawer = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMealsAsync = ref.watch(favoriteMealsProvider);

    return Scaffold(
      appBar: showDrawer
          ? AppBar(
              title: const Text('Your Favorites'),
              backgroundColor: Theme.of(context).primaryColor,
            )
          : null,
      drawer: showDrawer ? const MainDrawer() : null,
      body: favoriteMealsAsync.when(
        data: (favoriteMeals) => favoriteMeals.isEmpty
            ? const Center(
                child: Text(
                  textAlign: TextAlign.center,
                  'You have no favorites yet\n start adding some!',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return MealItem(meal: favoriteMeals[index]);
                },
                itemCount: favoriteMeals.length,
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error loading favorites: $error'),
        ),
      ),
    );
  }
}
