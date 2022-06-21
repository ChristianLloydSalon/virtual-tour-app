class Feature {
  Feature({
    required this.featureId,
    required this.touristSpotId,
    required this.feature,
    required this.details,
    required this.otherDetails,
    required this.price,
  });

  final int featureId;
  final int touristSpotId;
  final String feature;
  final String details;
  final String otherDetails;
  final String price;

  factory Feature.fromJson(Map<String, dynamic> json) {
    return Feature(
      featureId: json['id'] as int? ?? 0,
      touristSpotId: json['touristSpotId'] as int? ?? 0,
      feature: json['feature'] as String? ?? '',
      details: json['details'] as String? ?? '',
      otherDetails: json['otherDetails'] as String? ?? '',
      price: json['price'] as String? ?? '',
    );
  }
}
