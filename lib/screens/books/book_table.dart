import 'package:books/providers/book_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'book_form.dart';
import 'book_detail.dart';


class BookTable extends StatelessWidget {
  const BookTable({super.key});

    void editBook(BuildContext context, book) {
    Navigator.of(context).push(MaterialPageRoute(
      builder: (_) => BookForm(book: book),
    ));
  }

    void deleteBook(BuildContext context, int id) async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Hapus Buku"),
        content: const Text("Yakin ingin menghapus buku ini?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context, false), child: const Text("Batal")),
          TextButton(onPressed: () => Navigator.pop(context, true), child: const Text("Hapus")),
        ],
      ),
    );

    if (confirm ?? false) {
      await Provider.of<BookProvider>(context, listen: false).deleteBook(id);
    }
  }

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);

    if (bookProvider.isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (bookProvider.error.isNotEmpty) {
      return Center(child: Text('Error: ${bookProvider.error}'));
    }

    if (bookProvider.books.isEmpty) {
      return const Center(child: Text('Tidak ada data buku.'));
    }

    return ListView.builder(
      itemCount: bookProvider.books.length,
      itemBuilder: (context, index) {
        final book = bookProvider.books[index];
        return ListTile(
          title: Text(book.title),
          subtitle: Text(
            '${book.author} (${book.publishedYear})\nKategori: ${book.category?.name ?? "-"}',
          ),
          isThreeLine: true,
          trailing: Wrap(
            spacing: 8,
            children: [
              IconButton(
                icon: const Icon(Icons.visibility),
                tooltip: 'Lihat Detail',
                onPressed: () => Navigator.of(context).push(
                  MaterialPageRoute(builder: (_) => BookDetailPage(book: book)),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.edit),
                onPressed: () => editBook(context, book),
              ),
              IconButton(
                icon: const Icon(Icons.delete),
                onPressed: () => deleteBook(context, book.id),
              ),
            ],
          ),
        );
      },
    );
  }
}
