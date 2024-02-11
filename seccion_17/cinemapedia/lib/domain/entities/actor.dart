class Actor {
  final int id;

  final String name, profilePath;
  final String? character;
  final double? popularity;

  Actor({
    required this.id,
    required this.name,
    required this.profilePath,
    this.character,
    this.popularity,
  });
}
