import 'package:books/models/books_model.dart';
import 'package:flutter/material.dart';

class BookDetailPage extends StatelessWidget {
  final Book book;

  const BookDetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Buku'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Judul: ${book.title}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 8),
            Text('Penulis: ${book.author}'),
            SizedBox(height: 8),
            Text('Tahun Terbit: ${book.publishedYear}'),
            SizedBox(height: 8),
            Text('Kategori: ${book.category?.name ?? "-"}'),
          ],
        ),
      ),
    );
  }
}
