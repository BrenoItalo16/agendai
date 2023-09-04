import 'package:geolocator/geolocator.dart';

enum AppLocationStatus { disabled, denied, deniedForever, allowed }

class AppLocation {
  Future<AppLocationStatus> checkStatus() async {
    final isEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isEnabled) return AppLocationStatus.disabled;

    final permission = await Geolocator.checkPermission();
    return permission.toApp();
  }

  Future<AppLocationStatus> requestPermission() async {
    final isEnabled = await Geolocator.isLocationServiceEnabled();
    if (!isEnabled) return AppLocationStatus.disabled;

    final permission = await Geolocator.requestPermission();
    return permission.toApp();
  }
}

extension LocationPermissionX on LocationPermission {
  AppLocationStatus toApp() {
    switch (this) {
      case LocationPermission.always:
      case LocationPermission.whileInUse:
        return AppLocationStatus.allowed;
      case LocationPermission.denied:
        return AppLocationStatus.denied;
      case LocationPermission.deniedForever ||
            LocationPermission.unableToDetermine:
        return AppLocationStatus.deniedForever;
    }
  }
}
