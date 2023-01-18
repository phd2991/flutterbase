import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:photo_manager/photo_manager.dart';

import '../../constants/button_style.dart';
import '../../constants/images.dart';
import '../../data/model/remote/response/service_response.dart';
import '../../global_widgets/bottom_sheet_helper.dart';
import '../../global_widgets/full_scroll_view.dart';
import '../../helpers/duration_helper.dart';
import 'multi_image_picker_controller.dart';

class MultiImagePicker extends GetView<MultiImagePickerController> {
  const MultiImagePicker({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Obx(() => _buildAlbumButton(context)),
        actions: [
          ElevatedButton(
            onPressed: () => Get.back(result: controller.selectedAssets),
            child: const Text('Confirm'),
            style: AppButtonStyle.generalButtonStyle,
          ),
        ],
      ),
      body: SafeArea(
        child: Obx(
          () {
            if (controller.assets.value.status == ServiceStatus.loading) {
              return Center(child: Image.asset(Images.loading, scale: 2));
            }
            final images = controller.assets.value.data;
            return FullScrollView(
              placeholderChecker: () => images == null || images.isEmpty,
              onPullToRefresh: controller.getAssets,
              onLoadMore: controller.loadMore,
              canLoadMore: controller.canLoadMore.value,
              child: SliverGrid(
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 150,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                ),
                delegate: SliverChildBuilderDelegate(
                  (context, index) => _buildItem(context, index),
                  childCount: images?.length,
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildAlbumButton(BuildContext context) {
    if (controller.albums.value.status == ServiceStatus.loading) {
      return const SizedBox.shrink();
    }
    if (controller.albums.value.data == null ||
        controller.albums.value.data!.isEmpty) {
      return const SizedBox.shrink();
    }
    return ElevatedButton(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            controller.albums.value.data![controller.selectedAlbum.value].name,
          ),
          const Icon(Icons.arrow_drop_down)
        ],
      ),
      style: AppButtonStyle.generalButtonStyle,
      onPressed: showAlbumPicker,
    );
  }

  Widget _buildItem(BuildContext context, int index) {
    final assets = controller.assets.value.data!;
    return GestureDetector(
      onTap: controller.canChoose(index)
          ? () => controller.chooseAsset(index)
          : null,
      child: Stack(
        children: [
          AssetEntityImage(
            assets[index],
            isOriginal: false,
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          if (assets[index].type == AssetType.video)
            Positioned.fill(child: _buildDurationText(context, index)),
          Positioned(
            top: 0,
            right: 0,
            child: _buildSelectBox(context, index),
          ),
          if (controller.canChoose(index) == false)
            Positioned.fill(child: _buildDisableMask(context)),
        ],
      ),
    );
  }

  Widget _buildSelectBox(BuildContext context, int index) {
    final assets = controller.assets.value.data!;
    if (controller.config.maxSelect == 1) {
      return Obx(
        () => Radio(
          value: assets[index],
          groupValue: controller.selectedAssets.isEmpty
              ? null
              : controller.selectedAssets.first,
          onChanged: controller.canChoose(index)
              ? (_) => controller.chooseAsset(index)
              : null,
        ),
      );
    } else {
      return Obx(
        () => Checkbox(
          value: controller.selectedAssets.contains(assets[index]),
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          visualDensity: VisualDensity.compact,
          onChanged: controller.canChoose(index)
              ? (_) => controller.chooseAsset(index)
              : null,
        ),
      );
    }
  }

  Widget _buildDurationText(BuildContext context, int index) {
    final assets = controller.assets.value.data!;
    return Container(
      decoration: const BoxDecoration(
        gradient: RadialGradient(
          colors: [Colors.grey, Colors.transparent],
          radius: 0.7,
          center: Alignment(0.8, 1.8),
        ),
      ),
      alignment: Alignment.bottomRight,
      padding: const EdgeInsets.all(5),
      child: Text(
        assets[index].videoDuration.toFormatString(),
        style: Theme.of(context).textTheme.caption?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
      ),
    );
  }

  Widget _buildDisableMask(BuildContext context) {
    return Container(color: Colors.black54);
  }

  void showAlbumPicker() {
    BottomSheetHelper.showScrollableBottomSheet(
      title: 'Choose Album',
      builder: (context, scrollController) => ListView.builder(
        controller: scrollController,
        itemBuilder: (context, index) => ListTile(
          title: Text(controller.albums.value.data![index].name),
          onTap: () {
            controller.chooseAlbum(index);
            Get.back();
          },
        ),
        itemCount: controller.albums.value.data?.length,
      ),
    );
  }
}
