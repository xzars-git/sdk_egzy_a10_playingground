// lib/screens/printer_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_aar/printer_service.dart';

class PrinterScreen extends StatefulWidget {
  @override
  _PrinterScreenState createState() => _PrinterScreenState();
}

class _PrinterScreenState extends State<PrinterScreen> {
  final _printerService = PrinterService();
  final _textController = TextEditingController();

  Future<void> _checkPrinter() async {
    try {
      final info = await _printerService.getPrinterInfo();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Printer version: ${info['version']}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Future<void> _printText() async {
    try {
      await _printerService.printText(_textController.text);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Print successful')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Printer Demo')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            ElevatedButton(
              onPressed: _checkPrinter,
              child: Text('Check Printer'),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _textController,
              decoration: InputDecoration(
                labelText: 'Text to print',
                border: OutlineInputBorder(),
              ),
              maxLines: 4,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _printText,
              child: Text('Print Text'),
            ),
          ],
        ),
      ),
    );
  }
}
