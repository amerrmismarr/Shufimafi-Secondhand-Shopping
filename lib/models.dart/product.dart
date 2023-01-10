class Product {
  String? name;
  final String? description;
  final String? category;
  final String? brand;
  final String? condition;
  final String? color;
  final String? originalPrice;
  final String? price;
  final String? productId;
  final String? token;
  final String? userId;
  final String? image;

  Product(
      {this.name,
      this.description,
      this.category,
      this.brand,
      this.condition,
      this.color,
      this.originalPrice,
      this.price,
      this.productId,
      this.token,
      this.userId,
      this.image});

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'category': category,
      'brand': brand,
      'condition': condition,
      'color': color,
      'origianPrice': originalPrice,
      'price': price,
      'productId': productId,
      'token': token,
      'userId': userId,
      'image': image
    };
  }

  Product.fromFirestore(Map<String, dynamic> firestore)
      : name = firestore['title'],
        description = firestore['description'],
        category = firestore['category'],
        brand = firestore['brand'],
        condition = firestore['condition'],
        color = firestore['color'],
        originalPrice = firestore['origianPrice'],
        price = firestore['price'],
        productId = firestore['productId'],
        token = firestore['token'],
        userId = firestore['userId'],
        image = firestore['image'];
}
