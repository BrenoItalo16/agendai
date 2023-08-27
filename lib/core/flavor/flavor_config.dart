class FlavorConfig {
  FlavorConfig(
      {required this.baseUrl,
      required this.flavor,
      required this.appId,
      required this.restKey});
  final AppFlavor flavor;
  final String baseUrl;
  final String appId;
  final String restKey;
}

enum AppFlavor { dev, prod }
