import '../../../constants/keys.dart';

class AuthenData {
  String? accessToken;

  AuthenData({
    this.accessToken,
  });

  AuthenData.fromJson(Map<String, dynamic> json) {
    accessToken = json[Keys.token];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[Keys.token] = accessToken;
    return data;
  }
}
