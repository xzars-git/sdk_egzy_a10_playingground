import 'package:flutter/services.dart';

class PrinterService {
  static const platform = MethodChannel('com.example.your_app/printer');

  Future<Map<String, dynamic>> getPrinterInfo() async {
    try {
      final result = await platform.invokeMethod('getPrinterInfo');
      return Map<String, dynamic>.from(result);
    } on PlatformException catch (e) {
      throw Exception('Failed to get printer info: ${e.message}');
    }
  }

  Future<bool> printText(String text) async {
    try {
      final result = await platform.invokeMethod('printText', {
        'text': text,
      });
      return result;
    } on PlatformException catch (e) {
      throw Exception('Failed to print: ${e.message}');
    }
  }
}
