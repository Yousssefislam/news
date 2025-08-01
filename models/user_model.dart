class UserModel {
  final String id;
  final String firstName;
  final String lastName;
  final String email;
  final String passwordHash;
  final DateTime createdAt;

  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.passwordHash,
    required this.createdAt,
  });
}
