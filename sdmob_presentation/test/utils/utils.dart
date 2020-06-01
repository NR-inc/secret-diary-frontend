import 'dart:async';
import 'package:test/test.dart';

Future<void> wait(Duration duration) async {
  await Future.delayed(duration, () {});
}

bool compareEqual({dynamic actual, dynamic expected = true, String message}) {
  message ??= '';
  final bool result = expected == actual;
  if (!result) {
    expect(actual, expected, reason: message);
  }
  return result;
}

bool compareNotEqual(
    {dynamic actual, dynamic expected = true, String message}) {
  message ??= '';
  final bool result = expected != actual;
  if (!result) {
    expect(actual, expected, reason: message);
  }
  return result;
}

void verifyResult(String logResult,
    {dynamic expected = true, dynamic actual = true}) {
  final bool result = expected == actual;
  if (!result) {
    expect(actual, expected, reason: logResult);
  }
}
