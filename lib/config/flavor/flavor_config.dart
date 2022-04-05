enum Flavor { development, staging, product }

class FlavorValues {
  FlavorValues({
    required this.baseUrl,
    required this.socketUrl,
    required this.webUrl,
  });

  final String baseUrl;
  final String socketUrl;
  final String webUrl;
}

class FlavorConfig {
  factory FlavorConfig({required Flavor flavor, required FlavorValues values}) {
    _instance ??= FlavorConfig._internal(flavor, values);
    return _instance!;
  }

  FlavorConfig._internal(this.flavor, this.values);

  final Flavor flavor;
  final FlavorValues values;
  static FlavorConfig? _instance;

  static FlavorConfig? get instance => _instance;

  static bool isProduct() => _instance!.flavor == Flavor.product;

  static bool isStaging() => _instance?.flavor == Flavor.staging;

  static bool isDev() => _instance?.flavor == Flavor.development;
}
