// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Có lỗi xảy ra! Vui lòng kiểm tra kết nối mạng hoặc thử lại sau.`
  String get system_error {
    return Intl.message(
      'Có lỗi xảy ra! Vui lòng kiểm tra kết nối mạng hoặc thử lại sau.',
      name: 'system_error',
      desc: '',
      args: [],
    );
  }

  /// `Hệ thống không phản hồi. Vui lòng thử lại sau.`
  String get timeout_error {
    return Intl.message(
      'Hệ thống không phản hồi. Vui lòng thử lại sau.',
      name: 'timeout_error',
      desc: '',
      args: [],
    );
  }

  /// `Thông báo`
  String get notification {
    return Intl.message(
      'Thông báo',
      name: 'notification',
      desc: '',
      args: [],
    );
  }

  /// `Đồng ý`
  String get accept {
    return Intl.message(
      'Đồng ý',
      name: 'accept',
      desc: '',
      args: [],
    );
  }

  /// `Từ chối`
  String get deny {
    return Intl.message(
      'Từ chối',
      name: 'deny',
      desc: '',
      args: [],
    );
  }

  /// `Hủy bỏ`
  String get cancel {
    return Intl.message(
      'Hủy bỏ',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Có lỗi xảy ra! Vui lòng thử lại sau.`
  String get common_error {
    return Intl.message(
      'Có lỗi xảy ra! Vui lòng thử lại sau.',
      name: 'common_error',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'vi'),
      Locale.fromSubtags(languageCode: 'en'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
