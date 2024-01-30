class Actor {
  final int id;

  final String name, profilePath;
  final String? character;

  Actor({
    required this.id,
    required this.name,
    required this.profilePath,
    this.character,
  });
}
