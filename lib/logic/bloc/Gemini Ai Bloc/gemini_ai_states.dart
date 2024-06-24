import 'package:equatable/equatable.dart';

abstract class GeminiAiStates extends Equatable {}

class InitialState extends GeminiAiStates {
  @override
  List<Object?> get props => [];
}

class LoadingState extends GeminiAiStates {
  @override
  List<Object?> get props => [];
}

class SuccessState extends GeminiAiStates {
  String? response;

  SuccessState({required this.response});

  @override
  List<Object?> get props => [response];
}

class FailureState extends GeminiAiStates {
  @override
  List<Object?> get props => [];
}
