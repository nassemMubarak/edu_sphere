import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class FileUtils {
  /// Function to pick PDF files
  static Future<List<PlatformFile>?> pickPdfFiles(BuildContext context) async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: true,
        allowedExtensions: ['pdf'],
      );

      return result?.files.where((file) => file.extension == 'pdf').toList();
    } catch (e) {
      print('Error picking files: $e');
      return null;
    }
  }
}
