import 'dart:io';

import 'package:ask_ai/logic/bloc/Gemini%20Ai%20Bloc/gemini_ai_events.dart';
import 'package:ask_ai/logic/bloc/Gemini%20Ai%20Bloc/gemini_ai_states.dart';
import 'package:ask_ai/logic/repo/repo_with_media.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_gemini/flutter_gemini.dart';

class GeminiAiBloc extends Bloc<GeminiAiEvents, GeminiAiStates> {
  RepoWithMedia repo = RepoWithMedia();

  GeminiAiBloc() : super(InitialState()) {
    on<GeminiAiEvents>(_sendQuery);
  }

  void _sendQuery(event, emit) async {
    if (event is SendQueryWithPDF) {
      emit.call(LoadingState());

      // Gemini ai logic for PDF
      final gemini = Gemini.instance;

      await gemini
          .text(
              "'${event.pdfExtract}', this text is extracted from PDF.${event.query} ")
          .then((value) {
        debugPrint(value?.output);
        emit.call(SuccessState(response: value?.output));
      }).catchError((e) {
        emit.call(FailureState());
        debugPrint('Error while requesting for Gemini response:--- $e');
      });
    } else if (event is SendQueryWithImage) {
      emit.call(LoadingState());

      // Gemini ai logic for Image
      final gemini = Gemini.instance;

      final file = File(event.imageFile!.path);
      await gemini.textAndImage(
          text: event.query, images: [file.readAsBytesSync()]).then((value) {
        emit.call(SuccessState(response: value?.output));
        debugPrint(value?.content?.parts?.last.text ?? '');
      }).catchError((e) {
        emit.call(FailureState());
        debugPrint('Error while requesting for Gemini response:--- $e');
      });
    }
  }
}
