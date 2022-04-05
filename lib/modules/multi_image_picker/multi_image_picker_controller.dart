import 'package:flutter/material.dart';
import 'package:flutter_struture/constants/button_style.dart';
import 'package:flutter_struture/constants/response_code.dart';
import 'package:flutter_struture/data/model/remote/response/service_response.dart';
import 'package:flutter_struture/generated/l10n.dart';
import 'package:flutter_struture/global_widgets/dialog_helper.dart';
import 'package:flutter_struture/modules/multi_image_picker/multi_image_picker_config.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

const int _itemPerPage = 60;

class MultiImagePickerController extends GetxController {
  MultiImagePickerController();

  final albums = ServiceResponse<List<AssetPathEntity>>.loading().obs;
  final selectedAlbum = 0.obs;
  final assets = ServiceResponse<List<AssetEntity>>.loading().obs;
  final selectedAssets = List<AssetEntity>.empty(growable: true).obs;

  MultiImagePickerConfig config = MultiImagePickerConfig();
  int page = 0;
  final canLoadMore = false.obs;

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments.length > 0) {
      config = Get.arguments[0] as MultiImagePickerConfig;
      selectedAssets.addAll(config.lastSelectedEnity ?? []);
    }
  }

  @override
  void onReady() {
    super.onReady();
    getData();
  }

  Future<void> getData() async {
    if (await checkPermission() == false) {
      albums.value = ServiceResponse.error(ResponseCodes.noPermission, '');
      assets.value = ServiceResponse.error(ResponseCodes.noPermission, '');
      return;
    }
    await getAlbums();

    if (albums.value.data == null || albums.value.data!.isEmpty) {
      assets.value = ServiceResponse.completed(null);
      return;
    }

    await getAssets();
  }

  Future<bool> checkPermission() async {
    final PermissionState ps = await PhotoManager.requestPermissionExtend();
    switch (ps) {
      case PermissionState.authorized:
      case PermissionState.limited:
        return true;
      default:
        Get.dialog(
          DialogHelper.errorDialog(
            content: const Text(
                'Permission denied. This app needs permission to use this feature. You can grant them in app settings.'),
            actions: [
              ElevatedButton(
                onPressed: () => Get.back(),
                child: Text(S.current.ok),
                style: AppButtonStyle.generalButtonStyle,
              ),
              ElevatedButton(
                onPressed: () => PhotoManager.openSetting(),
                child: const Text('Settings'),
                style: AppButtonStyle.generalButtonStyle,
              ),
            ],
          ),
        );
        return false;
    }
  }

  Future<void> getAlbums() async {
    albums.value = ServiceResponse.completed(
      await PhotoManager.getAssetPathList(
        type: config.type,
        filterOption: config.filterOptionGroup,
      ),
    );
  }

  Future<void> getAssets() async {
    final data = assets.value.data;
    if (page == 0) {
      assets.value = ServiceResponse.loading();
    }

    final response = await albums.value.data?[selectedAlbum.value]
        .getAssetListPaged(page: page, size: _itemPerPage);

    if (page > 0) {
      assets.value = ServiceResponse.completed(data!..addAll(response ?? []));
    } else {
      assets.value = ServiceResponse.completed(response);
    }
    canLoadMore.value = response?.isNotEmpty == true;
  }

  Future<void> loadMore() {
    page++;
    return getAssets();
  }

  void chooseAlbum(int index) {
    selectedAlbum.value = index;
    page = 0;
    selectedAssets.clear();
    getAssets();
  }

  bool canChoose(int index) {
    if (selectedAssets.contains(assets.value.data![index])) {
      return true;
    }

    if (selectedAssets.length < config.maxSelect) {
      return true;
    }

    return false;
  }

  void chooseAsset(int index) {
    final asset = assets.value.data![index];
    final isSelected = selectedAssets.contains(asset);
    if (isSelected == true) {
      selectedAssets.remove(asset);
    } else {
      selectedAssets.add(asset);
    }
  }
}
