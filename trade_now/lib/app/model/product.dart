class Product {
  String? id;
  List<String>? imgsUrl;
  double? price;
  String? name;
  String? description;
  String? condition;
  String? category;

  Product({
    this.id,
    required this.imgsUrl,
    this.price,
    this.name,
    this.description,
    this.condition,
    this.category,
  });
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      imgsUrl: List<String>.from(json['imgsUrl']),
      price: json['price']?.toDouble(),
      name: json['name'],
      description: json['description'],
      condition: json['condition'],
      category: json['category'],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      "imgsUrl": imgsUrl,
      "price": price,
      "name": name,
      "description": description,
      "condition": condition,
      "category": category
    };
  }
}
