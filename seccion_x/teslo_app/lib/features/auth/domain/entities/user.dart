class User {
  final String id, email, fullName, token;

  final List<String> roles;

  User({
    required this.id,
    required this.email,
    required this.fullName,
    required this.token,
    required this.roles,
  });
}
