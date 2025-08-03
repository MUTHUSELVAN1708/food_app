import 'package:flutter/material.dart';
import 'package:foods_app/core/constants.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({super.key});

  Widget buildListTile(String title, IconData icon, VoidCallback tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
        color: Colors.white,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'RobotoCondensed',
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Constants.brown,
      child: Column(
        children: [
          Container(
            height: 120,
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Color(0xFF7A3B22),
            child: Row(
              children: [
                Icon(Icons.fastfood,
                    size: 35,
                    color:
                        Theme.of(context).primaryTextTheme.titleLarge?.color),
                const SizedBox(
                  width: 6,
                ),
                Text(
                  'Cooking Up!',
                  style: TextStyle(
                    fontWeight: FontWeight.w900,
                    fontSize: 26,
                    color: Theme.of(context).primaryTextTheme.titleLarge?.color,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          buildListTile('Meals', Icons.restaurant, () {
            Navigator.of(context).pushReplacementNamed('/');
          }),
          buildListTile('Filter', Icons.settings, () {
            Navigator.of(context).pushNamed('/filters');
          }),
        ],
      ),
    );
  }
}
