import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../constants/button_style.dart';
import '../constants/images.dart';
import '../generated/l10n.dart';
import '../helpers/iterable_helper.dart';

class DialogHelper {
  static Widget generalDialog({
    Widget? icon,
    Widget? title,
    Widget? content,
    List<Widget>? actions,
    Widget? footer,
    Axis actionsAlign = Axis.horizontal,
    double contentSpacing = 16,
  }) {
    if (actions == null || actions.length == 0) {
      actions = [
        ElevatedButton(
          onPressed: () => Get.back(),
          child: Text(S.current.ok),
          style: AppButtonStyle.generalButtonStyle,
        ),
      ];
    }
    return AlertDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      insetPadding: const EdgeInsets.all(16),
      contentPadding: const EdgeInsets.only(
        top: 32,
        left: 24,
        right: 24,
        bottom: 24,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (icon != null) icon,
            if (title != null) title,
            if (content != null) content,
            if (content == null) SizedBox(height: contentSpacing),
            if (actionsAlign == Axis.horizontal)
              Row(
                children: actions.addGap(
                  gap: const SizedBox(width: 16),
                  itemBuilder: (item) => Expanded(child: item),
                ),
              ),
            if (actionsAlign == Axis.vertical)
              ...actions.map((item) => Expanded(child: item)),
            if (footer != null) footer,
          ].addGap(
            gap: SizedBox(height: contentSpacing),
            itemBuilder: (item) => item,
          ),
        ),
      ),
    );
  }

  static Widget errorDialog({
    Widget? content,
    List<Widget>? actions,
    Widget? footer,
    Axis actionsAlign = Axis.horizontal,
    double contentSpacing = 16,
  }) {
    return generalDialog(
      icon: Image.asset(Images.error),
      content: content,
      actions: actions,
      footer: footer,
      actionsAlign: actionsAlign,
      contentSpacing: contentSpacing,
    );
  }

  static Widget successDialog({
    Widget? content,
    List<Widget>? actions,
    Widget? footer,
    Axis actionsAlign = Axis.horizontal,
    double contentSpacing = 16,
  }) {
    return generalDialog(
      icon: Image.asset(Images.success),
      content: content,
      actions: actions,
      footer: footer,
      actionsAlign: actionsAlign,
      contentSpacing: contentSpacing,
    );
  }
}
