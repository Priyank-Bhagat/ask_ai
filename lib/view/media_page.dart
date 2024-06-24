import 'dart:io';
import 'dart:ui';

import 'package:ask_ai/logic/bloc/Gemini%20Ai%20Bloc/gemini_ai_events.dart';
import 'package:ask_ai/logic/bloc/Gemini%20Ai%20Bloc/gemini_ai_states.dart';
import 'package:ask_ai/view/home_page.dart';
import 'package:ask_ai/view/widgets/glitch_effect.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import '../logic/bloc/Gemini Ai Bloc/gemini_ai_bloc.dart';
import '../logic/bloc/Internet cubits/internet_cubit.dart';

class MediaPage extends StatefulWidget {
  String? pdfExtract;
  String? pdfPath;
  File? imgFile;
  String queryWithWhat;
  bool textFieldReadonly = true;

  MediaPage(
      {super.key,
      this.pdfExtract,
      this.imgFile,
      required this.queryWithWhat,
      this.pdfPath});

  @override
  State<MediaPage> createState() => _MediaPageState();
}

class _MediaPageState extends State<MediaPage> {
  final TextEditingController _query = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: const Color(0xff343541),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if (widget.queryWithWhat == 'image') {
              await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Image.file(
                        widget.imgFile!,
                        height: 200,
                        width: 200,
                      ),
                    );
                  });
            } else if (widget.queryWithWhat == 'pdf') {
              await showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return Stack(
                      children: [
                        SfPdfViewer.file(
                          File(widget.pdfPath!),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: IconButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    Colors.lightBlue, // This is what you need!
                              ),
                              icon: const Icon(
                                Icons.fullscreen_exit_sharp,
                                size: 45,
                              )),
                        ),
                      ],
                    );
                  });
            }
          },
          backgroundColor: const Color(0xff343541),
          shape: RoundedRectangleBorder(
              side: const BorderSide(width: 2, color: Colors.lightBlueAccent),
              borderRadius: BorderRadius.circular(50)),
          child: const Icon(
            Icons.preview,
            color: Colors.white,
          ),
        ),
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          leading: IconButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => HomePage(),
                  ),
                  (route) =>
                      false, //if you want to disable back feature set to false
                );
              },
              icon: const Icon(
                Icons.home,
                color: Colors.white,
                size: 30,
              )),
          backgroundColor: const Color(0xff343541),
          centerTitle: true,
          title: GlithEffect(
              child: RichText(
            text: const TextSpan(
              text: 'Ask Ai ',
              children: [
                TextSpan(
                    text: 'with media',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500))
              ],
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 40,
                  fontWeight: FontWeight.bold),
            ),
          )),
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
      ),
    );
  }

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
    return Column(
      children: [
        Container(
          height: MediaQuery.of(context).size.height / 1.26,
          color: const Color(0xff434654),
          child: Align(
            alignment: Alignment.bottomLeft,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                child: BlocBuilder<GeminiAiBloc, GeminiAiStates>(
                    builder: (context, state) {
                  if (state is InitialState) {
                    return const Center(
                      child: Text(
                        'Write you\'r query .....',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    );
                  } else if (state is LoadingState) {
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
                      state.response.toString(),
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
        ),
      ],
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
                controller: _query,
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
                    if (widget.queryWithWhat == 'pdf') {
                      context.read<GeminiAiBloc>().add(SendQueryWithPDF(
                          query: _query.text,
                          pdfExtract: widget.pdfExtract.toString()));
                    } else if (widget.queryWithWhat == 'image') {
                      context.read<GeminiAiBloc>().add(SendQueryWithImage(
                          query: _query.text, imageFile: widget.imgFile));
                    }
                    FocusScope.of(context).unfocus();
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                  )),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }
}
