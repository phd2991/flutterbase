import 'package:flutter_struture/constants/api_path.dart';
import 'package:flutter_struture/data/model/local/authen_data.dart';
import 'package:flutter_struture/data/model/remote/response/base_api_response.dart';
import 'package:flutter_struture/data/model/remote/response/service_response.dart';
import 'package:flutter_struture/data/provider/http_client.dart';
import 'package:flutter_struture/data/provider/local_storage.dart';

import '../../constants/keys.dart';

class AuthRepo {
  final HttpClient apiClient;
  final LocalStorage storage;

  AuthRepo(this.apiClient, this.storage);

  // Request Api
  Future<bool> signIn(String userName, String password) async {
    final response = await apiClient.requestPost(
      ApiPath.signIn,
      {Keys.userName: userName, Keys.password: password},
      (json) => BaseApiResponse.fromJson(
        json,
        (data) => AuthenData.fromJson(data),
      ),
    );
    switch (response.status) {
      case ServiceStatus.completed:
        saveAuthCredential(response.data);
        return true;
      default:
        return false;
    }
  }

  Future<void> signout() {
    return apiClient.requestPost(
      ApiPath.signOut,
      null,
      (json) => BaseApiResponse.fromJson(json),
    );
  }

  // Save to local
  void saveAuthCredential(AuthenData authData) {
    storage.accessToken = authData.accessToken;
  }

  void clearAuthCredential() {
    storage.accessToken = null;
  }

  // Get from local
  bool get isAuthen => storage.accessToken.isNotEmpty;
}
