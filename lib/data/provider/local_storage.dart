import 'package:get_storage/get_storage.dart';

import '../../constants/keys.dart';

class LocalStorage {
  // #region helper
  void _write<T>(String key, T? value) {
    if (value == null) {
      GetStorage().remove(key);
    } else {
      GetStorage().write(key, value);
    }
  }

  T _read<T>(String key) {
    return GetStorage().read(key);
  }
  // #endregion helper

  set accessToken(String? value) {
    _write(Keys.token, value);
  }

  String get accessToken {
    return _read(Keys.token);
  }
}
