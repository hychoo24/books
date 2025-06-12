import 'package:books/providers/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'book_form.dart';
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

  void _navigateToForm() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const BookForm()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Daftar Buku")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton.icon(
              onPressed: _navigateToForm,
              icon: const Icon(Icons.add),
              label: const Text('Tambah Buku'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),
            const SizedBox(height: 20),
             Expanded(child: BookTable()),
          ],
        ),
      ),
    );
  }
}
