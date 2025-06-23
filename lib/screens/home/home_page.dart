import 'package:books/screens/category/category_content.dart';
import 'package:books/screens/inventory/inventory_content.dart';
import 'package:flutter/material.dart';
import '../books/book_content.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.deepPurple),
              child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Book'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const BookContent()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.inventory),
              title: const Text('Inventory'),
              onTap: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const InventoryContent()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Category'),
              onTap: () {
                  Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const CategoryContent()),
                );
              },
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "What do you need to be done...?",
              style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 32),
            const Text(
              "Operations",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double maxWidth = constraints.maxWidth;
                  int itemPerRow = (maxWidth / 250).floor();
                  double cardWidth = (maxWidth - ((itemPerRow - 1) * 16)) / itemPerRow;

                  return Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    children: [
                      _buildMenuCard(
                        context,
                        title: 'Book',
                        color: Colors.teal,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const BookContent()));
                        },
                        width: cardWidth,
                      ),
                      _buildMenuCard(
                        context,
                        title: 'Inventory',
                        color: Colors.blue,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const InventoryContent()));
                        },
                        width: cardWidth,
                      ),
                      _buildMenuCard(
                        context,
                        title: 'Category',
                        color: Colors.orange,
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const CategoryContent()));
                        },
                        width: cardWidth,
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

      Widget _buildMenuCard(
      BuildContext context, {
      required String title,
      required Color color,
      required VoidCallback onTap,
      double width = 250,
    }) {
      return SizedBox(
        width: width,
        height: 80,
        child: GestureDetector(
          onTap: onTap,
          child: Card(
            elevation: 2,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
              child: Row(
                children: [
                  CircleAvatar(radius: 5, backgroundColor: color),
                  const SizedBox(width: 10),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }