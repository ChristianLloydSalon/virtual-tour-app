class Video {
  final String url;
  final int id;
  final int touristSpotId;

  Video({
    required this.url,
    required this.id,
    required this.touristSpotId,
  });

  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      url: json['url'] as String? ?? '',
      id: json['id'] as int? ?? 0,
      touristSpotId: json['touristSpotId'] as int? ?? 0,
    );
  }
}
