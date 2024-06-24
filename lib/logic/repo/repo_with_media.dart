import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';

class RepoWithMedia {
  Future<Map<String, String>> selectPDFandExtractText() async {
    Map<String, String> finalOutput;
    String filePath;
    String extractedString;

    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null) {
      filePath = result.files.single.path!;

      extractedString = _extractTextFromPdf(filePath);

      finalOutput = {
        'Filepath': result.files.single.path!,
        'Extractedstring': extractedString,
      };

      return finalOutput;
    } else {
      finalOutput = {
        'Filepath': '',
        'Extractedstring': '',
      };
      return finalOutput;
    }
  }

  String _extractTextFromPdf(String path) {
    String bufferString;

    try {
      //Load PDF document.
      final PdfDocument document =
          PdfDocument(inputBytes: File(path).readAsBytesSync());

      //Extract the text from all the pages.
      String text = PdfTextExtractor(document).extractText();

      //Dispose the document.
      document.dispose();

      bufferString = text.toString();

      // Dispose the document
      document.dispose();

      return bufferString;
    } catch (e) {
      debugPrint('Error in _extraxtTextFormPDF class :- $e');
      bufferString = '';
      return bufferString;
    }
  }

  Future<File?> imagePicker() async {
    File? imgFile;

    final ImagePicker picker = ImagePicker();
    final XFile? img = await picker.pickImage(
      source: ImageSource.gallery,
    );

    if (img != null) {
      imgFile = File(img.path);
      return imgFile;
    } else {
      return null;
    }
  }

  String? geminiAiForPDF(String pdfExtract, String query) {
    String? geminiResponse;

    return geminiResponse;
  }
}
