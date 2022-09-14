import 'dart:async';
import 'dart:developer' show log;

import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void handleError(dynamic e, {StackTrace? stackTrace, bool fatal = false}) {
  if (kDebugMode) {
    log(
      ">>>>>>>>> $e",
      stackTrace: stackTrace ?? StackTrace.current,
      name: 'handleError',
      time: DateTime.now(),
    );
  } else {
    try {
      // FirebaseCrashlytics.instance.recordError(e, stackTrace, fatal: fatal);
    } catch (e) {}
  }
}

String twoDigits(int n) => n.toString().padLeft(2, "0");

String formatDate(DateTime? dateTime, {String format = 'MMM d, yyyy'}) {
  if (dateTime == null) return "$dateTime";
  return DateFormat(format).format(dateTime.toLocal());
}

extension Unfocus on BuildContext {
  void unfocus() => FocusScope.of(this).unfocus();
}

extension Capitalize on String? {
  String? capitalize() {
    if (this != null) {
      final string = this!;
      return "${string.substring(0, 1).toUpperCase()}${string.substring(1)}";
    } else {
      return this;
    }
  }
}

extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color? fromHex(String? hexString) {
    if (hexString == null) return null;
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}

void autoScroll(
  ScrollController controller, {
  Duration delay = const Duration(milliseconds: 100),
  Duration duration = const Duration(milliseconds: 500),
}) async {
  await Future.delayed(delay);
  controller.animateTo(
    controller.position.maxScrollExtent,
    duration: duration,
    curve: Curves.easeInOut,
  );
}
