class Favorite {
  final String? name;
  final String? price;
  final String? image;
  final bool? isFavorite;

  Favorite({
    this.name,
    this.price,
    this.image,
    this.isFavorite,
  });

  Map<String, dynamic> toMap() {
    return {
      'Name': name,
      'Price': price,
      'Image': image,
      'IsFavorite': isFavorite,
    };
  }

  Favorite.fromFirestore(Map<String, dynamic> firestore)
      : name = firestore['Name'],
        price = firestore['Price'],
        image = firestore['Image'],
        isFavorite = firestore['IsFavorite'];
}
