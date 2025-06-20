import 'package:books/models/book_model.dart';
import 'package:flutter/material.dart';

class BookDetailPage extends StatelessWidget {
  final Book book;

  const BookDetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('ID: ${book.id}', style: const TextStyle(fontSize: 18)),
            const SizedBox(height: 8),
            Text('Judul: ${book.title}', style: const TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Penulis: ${book.author}', style: const TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Tahun Terbit: ${book.publishedYear}', style: const TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Kategori: ${book.category?.name ?? "-"}', style: const TextStyle(fontSize: 18)),
          ],
        ),
      ),
    );
  }
}
