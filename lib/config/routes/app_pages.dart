import 'package:get/get.dart';

import '../../modules/home/home_binding.dart';
import '../../modules/home/home_page.dart';
import '../../modules/multi_image_picker/multi_image_picker.dart';
import '../../modules/multi_image_picker/multi_image_picker_binding.dart';
import 'route_name.dart';

class AppPages {
  static List<GetPage> appPages = [
    GetPage(
      name: RouteNames.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: RouteNames.multiImagePicker,
      page: () => const MultiImagePicker(),
      binding: MultiImagePickerBinding(),
    ),
  ];
}
