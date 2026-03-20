class Character {
  final int    id;
  final String name;
  final String status;
  final String species;
  final String type;
  final String gender;
  final String image;
  final String origin;
  final String location;
  final int    episodeCount;

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
    return Character(
      id:           json['id']      as int,
      name:         json['name']    as String,
      status:       json['status']  as String,
      species:      json['species'] as String,
      type:         (json['type']   as String?) ?? '',
      gender:       json['gender']  as String,
      image:        json['image']   as String,
      origin:       (json['origin']   as Map<String, dynamic>)['name'] as String,
      location:     (json['location'] as Map<String, dynamic>)['name'] as String,
      episodeCount: (json['episode']  as List).length,
    );
  }
}