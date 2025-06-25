import 'package:books/providers/book_provider.dart';
import 'package:books/screens/menu_bar.dart/drawer_menu.dart';
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
        title: Text(
          "Book",
          style: const TextStyle(color: Colors.white),
          ),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      drawer: const AppDrawer(currentRoute: '/book'),
      body: const Padding(
        padding: EdgeInsets.all(16),
        child: BookTable(),
      ),
    );
  }
}
