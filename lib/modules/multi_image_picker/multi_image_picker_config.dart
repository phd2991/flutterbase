import 'package:photo_manager/photo_manager.dart';

class MultiImagePickerConfig {
  final RequestType type;
  final FilterOptionGroup? filterOptionGroup;
  final int maxSelect;
  final List<AssetEntity>? lastSelectedEnity;

  MultiImagePickerConfig({
    this.type = RequestType.common,
    this.filterOptionGroup,
    this.maxSelect = 1,
    this.lastSelectedEnity,
  }) : assert(maxSelect > 0);
}
