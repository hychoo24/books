import 'package:books/providers/book_provider.dart';
import 'package:books/screens/category/category_content.dart';
import 'package:books/screens/home/home_page.dart';
import 'package:books/screens/inventory/inventory_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'book_table.dart';

class BookContent extends StatefulWidget {
  const BookContent({super.key});

  @override
  State<BookContent> createState() => _BookContentState();
}

class _BookContentState extends State<BookContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<BookProvider>(context, listen: false).fetchBooks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Book"),
      ),
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (_) => const HomePage()),
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Book'),
              onTap: () {
                Navigator.pop(context);
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
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: BookTable(),
      ),
    );
  }
}
