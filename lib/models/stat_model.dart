class CategoryStat {
  final int categoryId;
  final String categoryName;
  final int total;

  CategoryStat({
    required this.categoryId,
    required this.categoryName,
    required this.total,
  });

  factory CategoryStat.fromJson(Map<String, dynamic> json) {
    return CategoryStat(
      categoryId: json['category_id'],
      categoryName: json['category_name'],
      total: json['total'],
    );
  }
}

class StatsAll {
  final int ttlBook;
  final int ttlInventory;
  final int ttlCategory;
  final List<CategoryStat> dataBook;
  final List<CategoryStat> dataInventory;

  StatsAll({
    required this.ttlBook,
    required this.ttlInventory,
    required this.ttlCategory,
    required this.dataBook,
    required this.dataInventory,
  });

  factory StatsAll.fromJson(Map<String, dynamic> json) {
    return StatsAll(
      ttlBook: json['ttlBook'],
      ttlInventory: json['ttlInventory'],
      ttlCategory: json['ttlCategory'],
      dataBook: (json['dataBook'] as List)
          .map((e) => CategoryStat.fromJson(e))
          .toList(),
      dataInventory: (json['dataInventory'] as List)
          .map((e) => CategoryStat.fromJson(e))
          .toList(),
    );
  }
}
