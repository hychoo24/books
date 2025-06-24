import 'package:books/providers/book_provider.dart';
import 'package:books/providers/category_provider.dart';
import 'package:books/providers/inventory_provider.dart';
import 'package:books/providers/stat_provider.dart';
import 'package:books/screens/category/category_content.dart';
import 'package:books/screens/inventory/inventory_content.dart';
import 'package:books/screens/stats/book_stat.dart';
import 'package:books/screens/stats/inventory_stat.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../books/book_content.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final contextRead = context;
      Provider.of<BookProvider>(contextRead, listen: false).fetchBooks();
      Provider.of<InventoryProvider>(contextRead, listen: false).fetchInventories();
      Provider.of<CategoryProvider>(contextRead, listen: false).fetchCategories();
      Provider.of<StatProvider>(context, listen: false).fetchStats();
    });
  }


  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);
    final totalBooks = bookProvider.books.length;
    final inventoryProvider = Provider.of<InventoryProvider>(context);
    final totalInventories = inventoryProvider.inventories.length;
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final totalCategories = categoryProvider.categories.length;

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
            Text(
              "What do you need to be done...?",
              style: TextStyle(
                fontSize: 24, 
                color: Colors.black,
                fontWeight: FontWeight.w600,
                ),
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
                        subtitle: 'Total Books: $totalBooks',
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const BookContent()));
                        },
                        width: cardWidth,
                      ),
                      _buildMenuCard(
                        context,
                        title: 'Inventory',
                        color: Colors.blue,
                        subtitle: 'Total Inventory: $totalInventories',
                        onTap: () {
                          Navigator.push(context, MaterialPageRoute(builder: (_) => const InventoryContent()));
                        },
                        width: cardWidth,
                      ),
                      _buildMenuCard(
                        context,
                        title: 'Category',
                        color: Colors.orange,
                        subtitle: 'Total Categories: $totalCategories',
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
            const SizedBox(height: 16),
            const BookStat(),
            const InventoryStat(),
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
    String? subtitle,
    double width = 250,
  }) {
    return SizedBox(
      width: width,
      height: 100,
      child: GestureDetector(
        onTap: onTap,
        child: Card(
          elevation: 3,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                CircleAvatar(radius: 6, backgroundColor: color),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Colors.blue,
                      ),
                    ),
                    if (subtitle != null)
                      Text(
                        subtitle,
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
