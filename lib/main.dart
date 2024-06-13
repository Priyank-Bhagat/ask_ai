import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ask_ai/view/home_page.dart';

import 'logic/bloc/Edan Ai Bloc/edan_ai_bloc.dart';
import 'logic/bloc/Internet cubits/internet_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) => EdanAiBloc(),
          ),
          BlocProvider(
            create: (_) => InternetCubit(),
          ),
        ],
        child: HomePage(),
      ),
    );
  }
}
