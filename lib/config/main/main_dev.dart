import '../flavor/env.dart';
import '../flavor/flavor_config.dart';

void main() => Development();

class Development extends Env {
  @override
  final Flavor flavor = Flavor.development;

  @override
  final FlavorValues environmentValues = FlavorValues(
    baseUrl: 'productBaseUrl',
    socketUrl: 'socketUrl',
    webUrl: 'webUrl',
  );
}
