class Category {
  final int id;
  final String name;
  final String description;

  Category({
    required this.id,
    required this.name,
    required this.description,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

    Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'description': description,
      };

      @override
      bool operator ==(Object other) =>
          identical(this, other) ||
          other is Category && runtimeType == other.runtimeType && id == other.id;

      @override
      int get hashCode => id.hashCode;
}
