import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_app/core/constants.dart';
import '../providers/food_items_provider.dart';
import '../widgets/main_drawer.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});

  Widget _buildSwitchListTile(
    String title,
    String description,
    bool currentValue,
    Function(bool) updateValue,
  ) {
    return SwitchListTile(
      title: Text(
        title,
        style: TextStyle(color: Colors.white),
      ),
      value: currentValue,
      subtitle: Text(
        description,
        style: TextStyle(color: Colors.white),
      ),
      onChanged: updateValue,
      trackOutlineColor: WidgetStatePropertyAll(Colors.white),
      inactiveThumbColor: Colors.white,
      inactiveTrackColor: Constants.brown,
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(filtersProvider);
    final filtersNotifier = ref.read(filtersProvider.notifier);

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Your Filter',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Constants.brown,
        iconTheme: const IconThemeData(color: Colors.white),
        // leading: IconButton(
        //     onPressed: () => Navigator.of(context).pop(),
        //     icon: Icon(Icons.arrow_back)),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                _buildSwitchListTile(
                  'Gluten-free',
                  'Only include gluten-free meals.',
                  filters.isGlutenFree,
                  filtersNotifier.setGlutenFree,
                ),
                _buildSwitchListTile(
                  'Lactose-free',
                  'Only include lactose-free meals.',
                  filters.isLactoseFree,
                  filtersNotifier.setLactoseFree,
                ),
                _buildSwitchListTile(
                  'Vegetarian',
                  'Only include vegetarian meals.',
                  filters.isVegetarian,
                  filtersNotifier.setVegetarian,
                ),
                _buildSwitchListTile(
                  'Vegan',
                  'Only include vegan meals.',
                  filters.isVegan,
                  filtersNotifier.setVegan,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
