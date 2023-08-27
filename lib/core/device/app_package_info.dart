import 'package:package_info_plus/package_info_plus.dart';

class AppPackageInfo {
  Future<int> getBuildNumber() async {
    final packageInfo = await PackageInfo.fromPlatform();

    return int.parse(packageInfo.buildNumber);
  }
}
