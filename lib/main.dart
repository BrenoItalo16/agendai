import 'app.dart';
import 'core/flavor/flavor_config.dart';

void main() {
  bootstrap(
    FlavorConfig(
      flavor: AppFlavor.prod,
      baseUrl: 'https://parseapi.back4app.com/functions',
      appId: 'pMj4YPGpT0siyfKD6bQ2mmRcoap72YqH2vU5eASO',
      restKey: 'qbcWgvgTY3kjbrDVLBmhs3oM9qFtUEVJkWUELRhg',
    ),
  );
}
