import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/book_provider.dart';
import 'book_detail.dart';
import 'book_form.dart';

class BookTable extends StatefulWidget {
  const BookTable({super.key});

  @override
  State<BookTable> createState() => _BookTableState();
}

class _BookTableState extends State<BookTable> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final bookProvider = Provider.of<BookProvider>(context);
    final books = bookProvider.books.where((book) {
      final query = _searchController.text.toLowerCase();
      return book.title.toLowerCase().contains(query) ||
          book.author.toLowerCase().contains(query);
    }).toList();

    return LayoutBuilder(
      builder: (context, constraints) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 37,
                  child: TextField(
                    controller: _searchController,
                    decoration: const InputDecoration(  
                      labelText: 'Search Books',
                      prefixIcon: Icon(Icons.search),
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (_) => setState(() {}),
                  ),
                ),
              ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  icon: const Icon(Icons.add),
                  label: const Text('Add Book'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.deepPurple, // Warna ungu
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6), // kurangin dari default (20)
                    ),
                  ),
                  //     padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                  //     minimumSize: const Size(150, 55), // Lebar & tinggi minimum tombol
                  //   ),
                  
                onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const BookForm()),
                    );
                  },
                ),
              ],
            ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: ConstrainedBox(
                  constraints: BoxConstraints(minWidth: constraints.maxWidth),
                  child: DataTable(
                    columnSpacing: 24,
                    columns: const [
                      DataColumn(label: Text('ID')),
                      DataColumn(label: Text('Title')),
                      DataColumn(label: Text('Author')),
                      DataColumn(label: Text('Year')),
                      DataColumn(label: Text('Category')),
                      DataColumn(label: Text('Actions')),
                    ],
                    rows: books.map((book) {
                      return DataRow(cells: [
                        DataCell(Text(book.id.toString())),
                        DataCell(Text(book.title)),
                        DataCell(Text(book.author)),
                        DataCell(Text(book.publishedYear.toString())),
                        DataCell(Text(book.category?.name ?? '-')),
                        DataCell(Row(
                          children: [
                            IconButton(
                              icon: const Icon(Icons.visibility),
                              tooltip: 'See More',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BookDetailPage(book: book),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit),
                              tooltip: 'Edit',
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => BookForm(book: book),
                                  ),
                                );
                              },
                            ),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              tooltip: 'Delete',
                              color: Colors.red,
                              onPressed: () {
                                bookProvider.deleteBook(book.id);
                              },
                            ),
                          ],
                        )),
                      ]);
                    }).toList(),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
