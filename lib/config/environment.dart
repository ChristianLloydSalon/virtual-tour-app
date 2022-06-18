class AppConfig {
  static const String apiBaseUrl =
      'https://buenavista-virtual-tour-app.herokuapp.com';
}

enum ApiType {
  health,
  touristSpot,
  picture,
  feature,
}

extension ApiTypeExtension on ApiType {
  String get type {
    switch (this) {
      case ApiType.health:
        return 'health';
      case ApiType.touristSpot:
        return 'tourist-spot';
      case ApiType.picture:
        return 'picture';
      case ApiType.feature:
        return 'feature';
      default:
        return 'health';
    }
  }
}
