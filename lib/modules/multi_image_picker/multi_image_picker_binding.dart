import 'package:get/get.dart';

import 'multi_image_picker_controller.dart';

class MultiImagePickerBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MultiImagePickerController>(() => MultiImagePickerController());
  }
}
