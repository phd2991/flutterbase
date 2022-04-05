import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_struture/constants/colors.dart';
import 'package:get/get.dart';

class BottomSheetHelper {
  static Future showBottomSheet({
    required String title,
    required Widget body,
    bool? isScrollControlled,
  }) async {
    return Get.bottomSheet(
      _CommonBottomSheet(
        title: title,
        body: body,
      ),
      backgroundColor: Colors.transparent,
      isScrollControlled: isScrollControlled ?? true,
    );
  }

  static Future showScrollableBottomSheet({
    required String title,
    required Widget Function(BuildContext, ScrollController) builder,
  }) async {
    return showModalBottomSheet(
      context: Get.context!,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return DraggableScrollableSheet(
          expand: false,
          maxChildSize: 0.95,
          builder: (_, controller) {
            return _ScrollableBottomSheet(
              title: title,
              body: builder(_, controller),
            );
          },
        );
      },
    );
  }
}

class _CommonBottomSheet extends StatelessWidget {
  final String title;
  final Widget body;

  const _CommonBottomSheet({
    required this.title,
    required this.body,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: LayoutBuilder(builder: (context, constraints) {
          return Container(
            constraints: BoxConstraints(
              maxHeight: constraints.maxHeight -
                  MediaQueryData.fromWindow(window).padding.top,
            ),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(24),
                topRight: Radius.circular(24),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Text(
                    title,
                    style: Theme.of(Get.context!).textTheme.bodyText1,
                    textAlign: TextAlign.center,
                  ),
                ),
                const Divider(height: 0.5),
                body,
              ],
            ),
          );
        }),
      ),
    );
  }
}

class _ScrollableBottomSheet extends StatelessWidget {
  final String title;
  final Widget body;

  const _ScrollableBottomSheet({
    required this.title,
    required this.body,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(24),
              topRight: Radius.circular(24),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const SizedBox(height: 8),
              Container(
                height: 4,
                width: 50,
                decoration: ShapeDecoration(
                  shape: const StadiumBorder(),
                  color: AppColors.grayscale[300],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  title,
                  style: Theme.of(Get.context!).textTheme.bodyText1,
                  textAlign: TextAlign.center,
                ),
              ),
              const Divider(height: 0.5),
              Expanded(child: body),
            ],
          ),
        ),
      ),
    );
  }
}
