import 'package:books/screens/category/category_content.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/inventory_provider.dart';
import 'inventory_table.dart';
import '../books/book_content.dart';
import '../home/home_page.dart';

class InventoryContent extends StatefulWidget {
  const InventoryContent({super.key});

  @override
  State<InventoryContent> createState() => _InventoryContentState();
}

class _InventoryContentState extends State<InventoryContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<InventoryProvider>(context, listen: false).fetchInventories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Inventory")),
      
      // ⬇️ Drawer ditambahkan di sini
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
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const HomePage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.book),
              title: const Text('Book'),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const BookContent()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.inventory),
              title: const Text('Inventory'),
              onTap: () {
                Navigator.pop(context); // sudah di Inventory
              },
            ),
            ListTile(
              leading: const Icon(Icons.category),
              title: const Text('Category'),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => const CategoryContent()));
              },
            ),
          ],
        ),
      ),

      body: const Padding(
        padding: EdgeInsets.all(16),
        child: InventoryTable(),
      ),
    );
  }
}
