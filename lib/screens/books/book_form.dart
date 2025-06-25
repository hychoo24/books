import 'package:books/models/book_model.dart';
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
  Category? _selectedCategory;
  late TextEditingController _publishedYearController;
  
  

@override
void initState() {
  super.initState();

  _titleController = TextEditingController();
  _authorController = TextEditingController();
  _publishedYearController = TextEditingController();

  if (widget.book != null) {
    _titleController.text = widget.book!.title;
    _authorController.text = widget.book!.author;
    _publishedYearController.text = widget.book!.publishedYear.toString();
    _selectedCategory = widget.book!.category;
  }

    WidgetsBinding.instance.addPostFrameCallback((_) {
    Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
  });
}


  void _submit() async {
    if (_formKey.currentState!.validate()) {
      final book = Book(
        id: widget.book?.id ?? 0,
        title: _titleController.text,
        author: _authorController.text,
        publishedYear: _publishedYearController.text.isEmpty
            ? 0
            : int.parse(_publishedYearController.text),
        categoryId: _selectedCategory!.id,
        category: _selectedCategory,
      );

    final provider = Provider.of<BookProvider>(context, listen: false);
    if (widget.book != null) {
      await provider.updateBook(book.id, book);
    } else {
      await provider.addBook(book);
    }
  
    await Provider.of<BookProvider>(context, listen: false).fetchBooks();

    if (mounted) {
      Navigator.pop(context, true);
    }
  }
}
  

    @override
    Widget build(BuildContext context) {
      final categoryProvider = Provider.of<CategoryProvider>(context);
      final categories = categoryProvider.categories;

      return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.book == null ? 'Add Book' : 'Edit Book',
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Card(
            elevation: 0,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: _titleController,
                      decoration: const InputDecoration(labelText: 'Title'),
                      validator: (value) => value!.isEmpty ? 'Wajib diisi' : null,
                    ),
                    TextFormField(
                      controller: _authorController,
                      decoration: const InputDecoration(labelText: 'Author'),
                      validator: (value) => value!.isEmpty ? 'Required Field' : null,
                    ),
                    TextFormField(
                      controller: _publishedYearController,
                      decoration: const InputDecoration(labelText: 'Year'),
                      keyboardType: TextInputType.number,
                      validator: (value) => value!.isEmpty ? 'Required Field' : null,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<Category>(
                      value: _selectedCategory,
                      decoration: const InputDecoration(
                        labelText: 'Category',
                        border: UnderlineInputBorder(),
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(vertical: 10),
                      ),
                      isExpanded: true,
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
                      validator: (value) => value == null ? 'Choose Category' : null,
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: Colors.deepPurple, // Warna ungu
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6), // kurangin dari default (20)
                      ),
                    ),
                      child: Text(widget.book != null ? 'Save Changes' : 'Add Book'),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
