import '../flavor/env.dart';
import '../flavor/flavor_config.dart';

void main() => Production();

class Production extends Env {
  @override
  final Flavor flavor = Flavor.product;

  @override
  final FlavorValues environmentValues = FlavorValues(
    baseUrl: 'productBaseUrl',
    socketUrl: 'socketUrl',
    webUrl: 'webUrl',
  );
}
