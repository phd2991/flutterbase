import 'package:flutter_struture/config/flavor/env.dart';
import 'package:flutter_struture/config/routes/route_name.dart';
import 'package:flutter_struture/modules/multi_image_picker/multi_image_picker_config.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

class HomeController extends GetxController {
  final images = List<AssetEntity>.empty().obs;
  final videos = List<AssetEntity>.empty().obs;

  Future<void> pickImages() async {
    final result = await Get.toNamed(
      RouteNames.multiImagePicker,
      arguments: [
        MultiImagePickerConfig(
          lastSelectedEnity: images,
          type: RequestType.image,
          maxSelect: 5,
        )
      ],
    );
    if (result == null) return;
    images.value = result;
  }

  Future<void> pickVideos() async {
    final result = await Get.toNamed(
      RouteNames.multiImagePicker,
      arguments: [
        MultiImagePickerConfig(
          lastSelectedEnity: videos,
          type: RequestType.video,
          filterOptionGroup: FilterOptionGroup(containsLivePhotos: false),
        )
      ],
    );
    if (result == null) return;
    videos.value = result;
  }
}
