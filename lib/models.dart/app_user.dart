class AppUser {
  final String? email;
  final String? password;
  final String? token;
  final String? username;
  final List? favorites;
  final List? followList;
  final String? phoneNumber;

  AppUser(
      {this.email,
      this.password,
      this.token,
      this.username,
      this.favorites,
      this.followList,
      this.phoneNumber});

  Map<String, dynamic> toMap() {
    return {
      'Email': email,
      'Password': password,
      'Token': token,
      'Username': username,
      'favorites': favorites,
      'followList': followList,
      'phoneNumber': phoneNumber,
    };
  }

  AppUser.fromFireStore(Map<String, dynamic>? firestore)
      : email = firestore!['Email'],
        password = firestore['Password'],
        token = firestore['Token'],
        username = firestore['Username'],
        favorites = firestore['favorites'],
        followList = firestore['followList'],
        phoneNumber = firestore['phoneNumer'];
}
