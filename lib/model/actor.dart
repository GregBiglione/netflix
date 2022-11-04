class Actor {
  final String? imageUrl;
  final String name;
  final String characterName;

//<editor-fold desc="Data Methods">

  const Actor({
    this.imageUrl,
    required this.name,
    required this.characterName,
  });

  Actor copyWith({
    String? imageUrl,
    String? name,
    String? characterName,
  }) {
    return Actor(
      imageUrl: imageUrl ?? this.imageUrl,
      name: name ?? this.name,
      characterName: characterName ?? this.characterName,
    );
  }

  factory Actor.fromJson(Map<String, dynamic> map) {
    return Actor(
      imageUrl: map['profile_path'],
      name: map['name'],
      characterName: map['character'],
    );
  }

//</editor-fold>
}