package com.example.flutter_aar

import android.content.Context
import com.common.apiutil.printer.ThermalPrinter
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result

class PrinterChannel(private val context: Context) : MethodCallHandler {
    override fun onMethodCall(call: MethodCall, result: Result) {
        when (call.method) {
            "getPrinterInfo" -> {
                try {
                    val printer = ThermalPrinter(context)
                    val version = printer.version
                    result.success(mapOf(
                        "version" to version,
                        "status" to "ready"
                    ))
                } catch (e: Exception) {
                    result.error("PRINTER_ERROR", e.message, null)
                }
            }
            "printText" -> {
                try {
                    val text = call.argument<String>("text") ?: ""
                    val printer = ThermalPrinter(context)
                    
                    printer.reset()
                    printer.setGray(3)
                    printer.addString(text)
                    printer.printString()
                    printer.walkPaper(10)
                    
                    result.success(true)
                } catch (e: Exception) {
                    result.error("PRINT_ERROR", e.message, null)
                }
            }
            else -> result.notImplemented()
        }
    }
}