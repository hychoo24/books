import 'package:books/api/dio_client.dart';
import 'package:books/models/book_model.dart';

class BookService {
  static const String groupApi = '/books';
  
  static Future<BookResponse> getBooks({String search = "", int page = 1}) async {
    try {
      final response = await DioClient.dio.get(
        groupApi,
        queryParameters: {
          'search': search,
          'page': page,
        },
      );
      // print('Response: ${response.data}');
      return BookResponse.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load books: $e');
    }
  }

   static Future<Book> addBook(Book book) async {
    final response = await DioClient.dio.post('/books', data: book.toJson());
    return Book.fromJson(response.data);
  }

  static Future<Book> updateBook(int id, Book book) async {
    final response = await DioClient.dio.put('/books/$id', data: book.toJson());
    return Book.fromJson(response.data);
  }

  static Future<void> deleteBook(int id) async {
    await DioClient.dio.delete('/books/$id');
  }

  static Future<Book> getBookById(int id) async {
    try {
      final response = await DioClient.dio.get('$groupApi/$id');
      return Book.fromJson(response.data);
    } catch (e) {
      throw Exception('Failed to load book detail: $e');
    }
  }
}
