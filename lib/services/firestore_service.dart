import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dolabi/models.dart/favorites.dart';
import 'package:dolabi/models.dart/product.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../models.dart/app_user.dart';

class FireStoreService {
  FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<void> addFavorite(Favorite favorite, String userId) {
    var options = SetOptions(merge: true);
    return _db
        .collection('Users')
        .doc(_auth.currentUser!.uid.toString())
        .collection('Favorites')
        .doc()
        .set(favorite.toMap(), options);
  }

  Future<AppUser> fetchUser(String userId) {
    return _db
        .collection('Users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((snapshot) => AppUser.fromFireStore(snapshot.data()));
  }

  Future<void> addProduct(Product product, String title) {
    var options = SetOptions(merge: true);
    return _db.collection('Products').doc(title).set(product.toMap(), options);
  }

  Stream<List<Favorite>> fetchFavoritesByUserId(String userId) {
    return _db
        .collection('users')
        .doc(userId)
        .collection('Favorites')
        .snapshots()
        .map((favorites) => favorites.docs)
        .map((snapshot) => snapshot
            .map((favorite) => Favorite.fromFirestore(favorite.data()))
            .toList());
  }

  Stream<List<Product>> fetchProducts() {
    return _db
        .collection('Products')
        .snapshots()
        .map((products) => products.docs)
        .map((snapshot) => snapshot
            .map((product) => Product.fromFirestore(product.data()))
            .toList());
  }

  Future<void> saveFavorite(
      String name, String price, String image, bool isFavorite) async {
    var favorite = Favorite(
        name: name, price: price, image: image, isFavorite: isFavorite);

    return addFavorite(favorite, _auth.currentUser!.uid.toString());
    /*.then((value) => _predictionSaved.sink.add(true))
   .catchError((error) => _predictionSaved.sink.add(false));*/
  }

  Future<void> saveProduct(
      String name,
      String description,
      String category,
      String brand,
      String condition,
      String color,
      String originalPrice,
      String price,
      String productId) async {
    var product = Product(
        name: name,
        description: description,
        category: category,
        brand: brand,
        condition: condition,
        color: color,
        originalPrice: originalPrice,
        price: price,
        productId: productId);

    return addProduct(product, name);
    /*.then((value) => _predictionSaved.sink.add(true))
   .catchError((error) => _predictionSaved.sink.add(false));*/
  }
}
