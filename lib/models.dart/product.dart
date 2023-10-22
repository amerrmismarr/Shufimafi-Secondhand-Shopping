class Product {
  String? name;
  final String? description;
  final String? mainCategory;
  final String? middleCategory;
  final String? subCategory;
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
      this.mainCategory,
      this.middleCategory,
      this.subCategory,
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
      'mainCategory': mainCategory,
      'middleCategory': middleCategory,
      'subCategory': subCategory,
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
        mainCategory = firestore['mainCategory'],
        middleCategory = firestore['middleCategory'],
        subCategory = firestore['subCategory'],
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
