import 'package:books/models/category_model.dart';

class BookResponse {
  final int limit;
  final int page;
  final List<Book> results;
  final int total;

  BookResponse({
    required this.limit,
    required this.page,
    required this.results,
    required this.total,
  });

  factory BookResponse.fromJson(Map<String, dynamic> json) {
    return BookResponse(
      limit: json['limit'],
      page: json['page'],
      results: List<Book>.from(json['results'].map((x) => Book.fromJson(x))),
      total: json['total'],
    );
  }
}

class Book {
  final int id;
  final String title;
  final String author;
  final int categoryId;
  final Category? category;
  final int publishedYear;

  Book({
    required this.id,
    required this.title,
    required this.author,
    required this.categoryId,
    this.category,
    required this.publishedYear,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['title'],
      author: json['author'],

      categoryId: json['category_id'],
      category: json['Category'] != null
        ? Category.fromJson(json['Category'])
        : null,
      publishedYear: json['published_year'],
    );
  }

    Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'author': author,
        'published_year': publishedYear,
        'category_id': categoryId,
      };
}

