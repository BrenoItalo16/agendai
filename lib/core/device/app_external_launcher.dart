import 'package:store_redirect/store_redirect.dart';
import 'package:url_launcher/url_launcher_string.dart';

class AppExternalLauncher {
  Future<void> launchUrl(String url) {
    return launchUrlString(url);
  }

  Future<void> launchStore() {
    return StoreRedirect.redirect();
  }
}
