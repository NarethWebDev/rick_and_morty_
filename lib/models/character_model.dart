class Character {
  final int id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String image;
  final String origin;
  final String location;
  final int episodeCount;

  const Character({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.type,
    required this.gender,
    required this.image,
    required this.origin,
    required this.location,
    required this.episodeCount,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    final originRaw = json['origin'];
    final locationRaw = json['location'];

    String parseName(dynamic value) {
      if (value is String) return value;
      if (value is Map<String, dynamic>) {
        final name = value['name'];
        if (name is String) return name;
      }
      return '';
    }

    int parseEpisodeCount(dynamic value) {
      if (value is int) return value;
      if (value is String) {
        final parsed = int.tryParse(value);
        if (parsed != null) return parsed;
      }
      if (value is List) return value.length;
      if (json['episode'] is List) return (json['episode'] as List).length;
      return 0;
    }

    return Character(
      id: json['id'] is int
          ? json['id'] as int
          : int.tryParse(json['id'].toString()) ?? 0,
      name: json['name']?.toString() ?? '',
      status: json['status']?.toString() ?? '',
      species: json['species']?.toString() ?? '',
      type: json['type']?.toString() ?? '',
      gender: json['gender']?.toString() ?? '',
      image: json['image']?.toString() ?? '',
      origin: parseName(originRaw),
      location: parseName(locationRaw),
      episodeCount: parseEpisodeCount(json['episodeCount'] ?? json['episode']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'status': status,
      'species': species,
      'type': type,
      'gender': gender,
      'image': image,
      'origin': origin,
      'location': location,
      'episodeCount': episodeCount,
    };
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Character && runtimeType == other.runtimeType && id == other.id;

  @override
  int get hashCode => id.hashCode;
}
