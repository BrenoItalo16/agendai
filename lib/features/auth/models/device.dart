class Device {
  final String id;
  final String? fcmToken;
  final String platform;
  final int buildNumber;
  final String locale;
  Device({
    required this.id,
    this.fcmToken,
    required this.platform,
    required this.buildNumber,
    required this.locale,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'deviceId': id,
      'fcmToken': fcmToken,
      'platform': platform,
      'buildNumber': buildNumber,
      'locale': locale,
    };
  }
}
