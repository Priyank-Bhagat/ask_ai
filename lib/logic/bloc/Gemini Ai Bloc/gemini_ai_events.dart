import 'dart:io';
import 'package:equatable/equatable.dart';

abstract class GeminiAiEvents extends Equatable {}

class SendQueryWithPDF extends GeminiAiEvents {
  String query;
  String pdfExtract;
  SendQueryWithPDF({required this.query, required this.pdfExtract});

  @override
  List<Object?> get props => [query, pdfExtract];
}

class SendQueryWithImage extends GeminiAiEvents {
  String query;
  File? imageFile;
  SendQueryWithImage({required this.query, required this.imageFile});

  @override
  List<Object?> get props => [query, imageFile];
}
