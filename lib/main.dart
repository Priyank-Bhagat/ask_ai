import 'package:ask_ai/logic/bloc/Gemini%20Ai%20Bloc/gemini_ai_bloc.dart';
import 'package:ask_ai/view/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gemini/flutter_gemini.dart';
import 'logic/bloc/Edan Ai Bloc/edan_ai_bloc.dart';
import 'logic/bloc/Internet cubits/internet_cubit.dart';

void main() {
  Gemini.init(apiKey: 'AIzaSyBKZaD-paEr9bq3bvE8EnpjvaZyQ0X8Zag');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        //   BlocProvider(create: (_) => OpenAiBloc()),
        BlocProvider(create: (_) => InternetCubit()),
        BlocProvider(create: (_) => GeminiAiBloc()),
        BlocProvider(create: (_) => EdanAiBloc()),
      ],
      child: MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: HomePage(),
      ),
    );
  }
}
