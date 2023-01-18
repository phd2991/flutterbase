import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../helpers/iterable_helper.dart';
import 'home_controller.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: ListView(
        children: [
          Obx(() => ListTile(
                title: const Text('Multi image picker'),
                subtitle: Text('${controller.images.length} selected'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                onTap: controller.pickImages,
              )),
          Obx(() => ListTile(
                title: const Text('Multi video picker'),
                subtitle: Text('${controller.videos.length} selected'),
                trailing: const Icon(Icons.arrow_forward_ios, size: 14),
                onTap: controller.pickVideos,
              ))
        ].addGap(gap: const Divider()),
      ),
    );
  }
}
