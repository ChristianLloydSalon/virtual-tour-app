class FeaturePicture {
  final int id;
  final int relatedFeatureId;
  final int touristSpotId;
  final String url;

  FeaturePicture({
    required this.id,
    required this.relatedFeatureId,
    required this.touristSpotId,
    required this.url,
  });

  factory FeaturePicture.fromJson(Map<String, dynamic> json) {
    return FeaturePicture(
      id: json['id'] as int? ?? 0,
      relatedFeatureId: json['relatedFeatureId'] as int? ?? 0,
      touristSpotId: json['touristSpotId'] as int? ?? 0,
      url: json['url'] as String? ?? '',
    );
  }
}
