/// Player model. Used by GameService.
/// Add fields here; update copyWith if needed.
class Player {
  final String id;
  final String name;
  final bool isImposter;

  const Player({
    required this.id,
    required this.name,
    this.isImposter = false,
  });

  Player copyWith({String? id, String? name, bool? isImposter}) {
    return Player(
      id: id ?? this.id,
      name: name ?? this.name,
      isImposter: isImposter ?? this.isImposter,
    );
  }
}
