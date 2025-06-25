import 'package:books/screens/menu_bar.dart/drawer_menu.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/category_provider.dart';
import 'category_table.dart';

class CategoryContent extends StatefulWidget {
  const CategoryContent({super.key});

  @override
  State<CategoryContent> createState() => _CategoryContentState();
}

class _CategoryContentState extends State<CategoryContent> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Category",
          style: const TextStyle(color: Colors.white),
          ),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
        ),
      drawer: const AppDrawer(currentRoute: '/category'),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: const [
            Expanded(child: CategoryTable()),
          ],
        ),
      ),
    );
  }
}