import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_app/providers/category_provider.dart';
import '../widgets/category_item.dart';
import '../widgets/main_drawer.dart';

class HomeScreen extends ConsumerWidget {
  final bool showDrawer;

  const HomeScreen({super.key, this.showDrawer = true});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categoriesAsync = ref.watch(categoriesProvider);

    return Scaffold(
      appBar: showDrawer
          ? AppBar(
              title: const Text('Categories'),
              backgroundColor: Theme.of(context).primaryColor,
            )
          : null,
      drawer: showDrawer ? const MainDrawer() : null,
      body: categoriesAsync.when(
        data: (categories) => GridView(
          padding: const EdgeInsets.all(25),
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
            maxCrossAxisExtent: 200,
            childAspectRatio: 3 / 2,
            crossAxisSpacing: 20,
            mainAxisSpacing: 20,
          ),
          children: categories.map((catData) => CategoryItem(catData)).toList(),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error loading categories: $error'),
        ),
      ),
    );
  }
}
