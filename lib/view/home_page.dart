import 'dart:ui';
import 'package:ask_ai/logic/bloc/Open%20Ai%20Bloc/open_ai_state.dart';
import 'package:ask_ai/view/widgets/glitch_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import '../logic/bloc/Internet cubits/internet_cubit.dart';
import '../logic/bloc/Open Ai Bloc/open_ai_bloc.dart';
import '../logic/bloc/Open Ai Bloc/open_ai_event.dart';

// Change imports if you've changed AI api, at the moment it's for OpenAi api

class HomePage extends StatefulWidget {
  bool textFieldReadonly = false;
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController queryController;

  @override
  void initState() {
    queryController = TextEditingController();
    context.read<OpenAiBloc>().add(SendQueryEvent(query: 'Hi'));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff343541),
      appBar: AppBar(
        backgroundColor: const Color(0xff343541),
        centerTitle: true,
        title: GlithEffect(
          child: const Text(
            'Ask Ai',
            style: TextStyle(
                color: Colors.white, fontSize: 40, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: BlocBuilder<InternetCubit, InternetState>(
        builder: (context, state) {
          if (state is InternetGainedState) {
            widget.textFieldReadonly = false;
            return mainWidget(blurFilter: false);
          } else {
            widget.textFieldReadonly = false;
            return mainWidget(blurFilter: true);
          }
        },
      ),
    );
  }

  // Widget's in the parts :-
  Widget mainWidget({required bool blurFilter}) {
    return Stack(
      fit: StackFit.expand,
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [middleText(), queryField()],
          ),
        ),
        BackdropFilter(
          filter: blurFilter
              ? ImageFilter.blur(sigmaY: 10, sigmaX: 10)
              : ImageFilter.blur(sigmaY: 0, sigmaX: 0),
          child: Visibility(
            visible: blurFilter,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.mobiledata_off,
                  size: 100,
                  color: Colors.red,
                ),
                Container(
                  alignment: Alignment.center,
                  child: const Text(
                    'No Internet',
                    style: TextStyle(
                        fontSize: 50,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget middleText() {
    return Container(
      height: MediaQuery.of(context).size.height / 1.26,
      color: const Color(0xff434654),
      child: Align(
        alignment: Alignment.bottomLeft,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child:
                BlocBuilder<OpenAiBloc, OpenAiState>(builder: (context, state) {
              if (state is LoadingState) {
                return Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.green,
                    size: 200,
                  ),
                );
              } else if (state is FailureState) {
                return const Center(
                  child: Text(
                    'Something went wrong, \n Try to reopen app with internet connection.',
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.red),
                  ),
                );
              } else if (state is SuccessState) {
                return Text(
                  state.dataResponse!.choices![0].message!.content
                      .toString(), // EdanAi---> state.dataResponse!.cohere!.generatedText.toString()
                  style: const TextStyle(fontSize: 25, color: Colors.white),
                  textAlign: TextAlign.start,
                );
              } else {
                return Container();
              }
            }),
          ),
        ),
      ),
    );
  }

  Widget queryField() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 10,
        ),
        child: Row(
          children: [
            Flexible(
              child: TextFormField(
                readOnly: widget.textFieldReadonly,
                cursorColor: Colors.white,
                controller: queryController,
                autofocus: true,
                style: const TextStyle(color: Colors.white, fontSize: 20),
                decoration: InputDecoration(
                  focusedBorder: OutlineInputBorder(
                    borderSide: const BorderSide(color: Color(0xff444653)),
                    borderRadius: BorderRadius.circular(5.5),
                  ),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(
                      color: Color(0xff444653),
                    ),
                  ),
                  filled: true,
                  fillColor: const Color(0xff444653),
                  hintText: 'Tell me your query',
                  hintStyle: const TextStyle(color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: IconButton(
                  onPressed: () {
                    if (queryController.text.isNotEmpty &&
                        !widget.textFieldReadonly) {
                      context.read<OpenAiBloc>().add(SendQueryEvent(
                          query: queryController.text.toString()));
                    }
                    FocusScope.of(context).unfocus();
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  )),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    queryController.dispose();
    super.dispose();
  }
}
