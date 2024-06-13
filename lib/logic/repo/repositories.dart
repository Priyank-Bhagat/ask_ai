import 'dart:convert';

import 'package:ask_ai/logic/model/open_ai_model.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import '../../api_key.dart';
import '../model/edan_ai_model.dart';

class Repositories {
  Future<OpenAiModel?> openAiRemoteService(String query) async {
    final Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $opeAiKey',
    };

    final Map<String, dynamic> rawBody = {
      "model": "gpt-3.5-turbo",
      "messages": [
        {"role": "user", "content": query},
      ]
    };

    try {
      final response = await http.post(
          Uri.parse(
            'https://api.openai.com/v1/chat/completions',
          ),
          headers: headers,
          body: jsonEncode(rawBody));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return OpenAiModel.fromJson(data);
      } else {
        debugPrint(
            "Something went wrong. STATUS CODE :-${response.statusCode}");
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }

  Future<EdanAiModel?> edanAiRemoteService(String query) async {
    final Map<String, dynamic> rawBody = {
      'providers': 'openai,cohere',
      'text': query.toString(),
      'temperature': 0.2,
      'max_tokens': 250,
    };

    final Map<String, String> header = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Authorization': 'Bearer $edanAiKey'
    };
    try {
      final response = await http.post(
          Uri.parse(
            'https://api.edenai.run/v2/text/generation',
          ),
          headers: header,
          body: jsonEncode(rawBody));

      if (response.statusCode == 200) {
        var data = jsonDecode(response.body);
        return EdanAiModel.fromJson(data);
      } else {
        debugPrint(
            "Something went wrong. STATUS CODE :-${response.statusCode}");
        return null;
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
