import 'package:books/models/books_model.dart';
import 'package:books/models/category_model.dart';
import 'package:books/providers/book_provider.dart';
import 'package:books/providers/category_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BookForm extends StatefulWidget {
  final Book? book;
  const BookForm({super.key, this.book,});

  @override
  State<BookForm> createState() => _BookFormState();
}

class _BookFormState extends State<BookForm> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _authorController;
  late TextEditingController _yearController;
  Category? _selectedCategory;
  late TextEditingController _publishedYearController;
  
  

@override
void initState() {
  super.initState();

  _titleController = TextEditingController();
  _authorController = TextEditingController();
  _yearController = TextEditingController();
  _publishedYearController = TextEditingController();

  if (widget.book != null) {
    _titleController.text = widget.book!.title;
    _authorController.text = widget.book!.author;
    _yearController.text = widget.book!.year.toString();
    _publishedYearController.text = widget.book!.publishedYear.toString();
    _selectedCategory = widget.book!.category;
  }
}


  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final book = Book(
        id: widget.book?.id ?? 0,
        title: _titleController.text,
        author: _authorController.text,
        year: 0,
        publishedYear: int.parse(_yearController.text),
        categoryId: 1,
        category: null,
      );

    final provider = Provider.of<BookProvider>(context, listen: false);
    if (widget.book != null) {
      await provider.updateBook(book.id, book);
    } else {
      await provider.addBook(book);
    }
  
    Provider.of<BookProvider>(context, listen: false).fetchBooks();
    if (context.mounted) Navigator.pop(context, true);
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final categories = categoryProvider.categories;
  }
}
  

  @override
  Widget build(BuildContext context) {
    final categoryProvider = Provider.of<CategoryProvider>(context);
    final categories = categoryProvider.categories;
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Judul Buku'),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
              ),
              TextFormField(
                controller: _authorController,
                decoration: const InputDecoration(labelText: 'Penulis'),
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
              ),
              TextFormField(
                controller: _yearController,
                decoration: const InputDecoration(labelText: 'Tahun'),
                keyboardType: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
              ),
              DropdownButtonFormField<Category>(
                value: _selectedCategory,
                decoration: const InputDecoration(
                  labelText: 'Kategori',
                  border: OutlineInputBorder(),
                ),
                items: categories.map((category) {
                  return DropdownMenuItem<Category>(
                    value: category,
                    child: Text(category.name),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCategory = value!;
                  });
                },
                validator: (value) => value == null ? 'Pilih kategori' : null,
              ),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: _submit,
                child: Text(widget.book != null ? 'Simpan Perubahan' : 'Tambah Buku'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
