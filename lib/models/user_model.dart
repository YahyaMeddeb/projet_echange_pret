class UserModel {
  final String id;
  final String name;
  final String email;
  final double rating;

  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.rating = 0,
  });
}
