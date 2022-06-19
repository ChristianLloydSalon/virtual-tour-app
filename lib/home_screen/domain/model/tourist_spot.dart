class TouristSpot {
  final String contactNumber;
  final String description;
  final String email;
  final List<String> expenditures;
  final int id;
  final String image;
  final String location;
  final String name;
  final String openHours;
  final List<String> preparations;
  final List<String> restrictions;

  TouristSpot({
    required this.contactNumber,
    required this.description,
    required this.email,
    required this.expenditures,
    required this.id,
    required this.image,
    required this.location,
    required this.name,
    required this.openHours,
    required this.preparations,
    required this.restrictions,
  });

  factory TouristSpot.fromJson(Map<String, dynamic> json) {
    final expendentitures = json['expenditures'] as List? ?? [];
    final preparations = json['preparations'] as List? ?? [];
    final restrictions = json['restrictions'] as List? ?? [];

    return TouristSpot(
      contactNumber: json['contactNumber'] as String? ?? '',
      description: json['description'] as String? ?? '',
      email: json['email'] as String? ?? '',
      id: json['id'] as int? ?? 0,
      image: json['image'] as String? ?? '',
      location: json['location'] as String? ?? '',
      name: json['name'] as String? ?? '',
      openHours: json['openHours'] as String? ?? '',
      expenditures: expendentitures.map((e) => e as String).toList(),
      preparations: preparations.map((e) => e as String).toList(),
      restrictions: restrictions.map((e) => e as String).toList(),
    );
  }
}
