import '../flavor/env.dart';
import '../flavor/flavor_config.dart';

void main() => Staging();

class Staging extends Env {
  @override
  final Flavor flavor = Flavor.staging;

  @override
  final FlavorValues environmentValues = FlavorValues(
    baseUrl: 'stagingBaseUrl',
    socketUrl: 'socketUrl',
    webUrl: 'webUrl',
  );
}
