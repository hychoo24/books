import 'package:books/models/books_model.dart';
import 'package:flutter/material.dart';
import '../services/book_service.dart';

class BookProvider with ChangeNotifier {

  List<Book> _books = [];
  bool _isLoading = false;
  String _error = '';

  List<Book> get books => _books;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchBooks({String search = "", int page = 1}) async {
    _isLoading = true;
    notifyListeners();

    try {
      final response = await BookService.getBooks(search: search, page: page);
      _books = response.results;
      _error = '';
    } catch (e) {
      _error = e.toString();
    }

    _isLoading = false;
    notifyListeners();
  }

    Future<void> addBook(Book book) async {
    try {
      final newBook = await BookService.addBook(book);
      _books.add(newBook);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
    }
  }

  Future<void> updateBook(int id, Book book) async {
    try {
      final updated = await BookService.updateBook(id, book);
      final index = _books.indexWhere((b) => b.id == id);
      if (index != -1) {
        _books[index] = updated;
        notifyListeners();
      }
    } catch (e) {
      _error = e.toString();
    }
  }

  Future<void> deleteBook(int id) async {
    try {
      await BookService.deleteBook(id);
      _books.removeWhere((b) => b.id == id);
      notifyListeners();
    } catch (e) {
      _error = e.toString();
    }
  }

}
