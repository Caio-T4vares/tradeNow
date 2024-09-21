class Product {
  String? id;
  List<String>? imgsUrl;
  double? price;
  String? name;
  String? description;
  String? condition;
  String? category;
  String? userId;
  Product({
    this.userId,
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
      id: json["id"],
      userId: json["userId"],
      imgsUrl: List<String>.from(json['imgUrls']),
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
