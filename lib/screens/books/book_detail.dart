import 'package:books/models/book_model.dart';
import 'package:flutter/material.dart';

class BookDetailPage extends StatelessWidget {
  final Book book;

  const BookDetailPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
            ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          "Detail Book",
          style: const TextStyle(color: Colors.white),
          ),
        centerTitle: false,
        backgroundColor: Colors.deepPurple,
        
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 6,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                DetailItem(icon: Icons.assignment_ind, label: "ID", value: book.id.toString()),
                DetailItem(icon: Icons.book, label: "Judul", value: book.title),
                DetailItem(icon: Icons.person, label: "Penulis", value: book.author),
                DetailItem(icon: Icons.calendar_today, label: "Tahun Terbit", value: book.publishedYear.toString()),
                DetailItem(icon: Icons.category, label: "Kategori", value: book.category?.name ?? "-"),
              ],
            ),
          ),
        ),
      ),
      backgroundColor: const Color(0xFFF3F0FF),
    );
  }
}

class DetailItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const DetailItem({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: Colors.deepPurple),
          const SizedBox(width: 12),
          Expanded(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black87, fontSize: 16),
                children: [
                  TextSpan(
                    text: "$label: ",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: value),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
