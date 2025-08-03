import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foods_app/core/constants.dart';
import 'package:foods_app/providers/favorite_provider.dart';
import 'home_screen.dart';
import 'favorites_screen.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;

  final List<Map<String, Object>> _pages = [
    {
      'page': const HomeScreen(showDrawer: false),
      'title': 'Categories',
    },
    {
      'page': const FavoritesScreen(showDrawer: false),
      'title': 'Your Favorites',
    },
  ];

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    initialLoad();
  }

  Future<void> initialLoad() async {
    await Future.delayed(Duration.zero);
    ref.read(favoritesProvider.notifier).loadFavorites();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _pages[_selectedPageIndex]['title'] as String,
          style: TextStyle(color: Colors.white),
        ),
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        backgroundColor: Constants.brown,
      ),
      drawer: const MainDrawer(),
      body: _pages[_selectedPageIndex]['page'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Constants.brown,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.pinkAccent,
        currentIndex: _selectedPageIndex,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
