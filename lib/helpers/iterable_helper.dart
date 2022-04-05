import 'package:flutter/material.dart';

extension IterableExtension<E> on Iterable<E> {
  Iterable<T> mapIndexed<T>(T Function(E e, int i) f) {
    var i = 0;
    return map((e) => f(e, i++));
  }
}

extension IterableWidgetExtension<E extends Widget> on Iterable<E> {
  List<Widget> addGap({
    required Widget gap,
    Widget Function(E)? itemBuilder,
    bool addAtTop = false,
    bool addAtLast = false,
  }) {
    itemBuilder ??= (_) => _;

    var result = expand((item) sync* {
      yield gap;
      yield itemBuilder!(item);
    }).skip(addAtTop ? 0 : 1).toList();

    if (addAtLast) result.add(gap);

    return result;
  }
}
