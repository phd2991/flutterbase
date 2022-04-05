import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';

import 'application.dart';
import 'flavor_config.dart';

class Env {
  Env() {
    instance = this;
    _init();
  }

  static late Env instance;

  Flavor? flavor;
  FlavorValues? environmentValues;

  _init() async {
    WidgetsFlutterBinding.ensureInitialized();

    _initFlavor();

    await GetStorage().initStorage;

    //Main app
    runApp(const Application());
  }

  _initFlavor() {
    FlavorConfig(flavor: flavor!, values: environmentValues!);
  }
}
