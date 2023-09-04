import 'package:geolocator/geolocator.dart';

class AppDeviceSettings {
  Future<void> openSettings() {
    return Geolocator.openAppSettings();
  }
}
