import 'package:books/screens/books/book_content.dart';
import 'package:books/screens/category/category_content.dart';
import 'package:books/screens/home/home_page.dart';
import 'package:books/screens/inventory/inventory_content.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  final String currentRoute;

  const AppDrawer({super.key, required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurple),
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 24),
            ),
          ),
          _buildDrawerItem(
            context,
            icon: Icons.home,
            text: 'Home',
            destination: const HomePage(),
            routeName: '/home',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.book,
            text: 'Book',
            destination: const BookContent(),
            routeName: '/book',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.inventory,
            text: 'Inventory',
            destination: const InventoryContent(),
            routeName: '/inventory',
          ),
          _buildDrawerItem(
            context,
            icon: Icons.category,
            text: 'Category',
            destination: const CategoryContent(),
            routeName: '/category',
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String text,
    required Widget destination,
    required String routeName,
  }) {
    final isSelected = currentRoute == routeName;

    return ListTile(
      leading: Icon(icon, color: isSelected ? Colors.deepPurple : null),
      title: Text(
        text,
        style: TextStyle(
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          color: isSelected ? Colors.deepPurple : null,
        ),
      ),
      onTap: () {
        if (!isSelected) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => destination),
          );
        } else {
          Navigator.pop(context); // Close drawer
        }
      },
    );
  }
}
