import 'package:ask_ai/logic/model/open_ai_model.dart';
import 'package:equatable/equatable.dart';

abstract class OpenAiState extends Equatable {}

class InitialState extends OpenAiState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends OpenAiState {
  @override
  List<Object?> get props => [];
}

class SuccessState extends OpenAiState {
  final OpenAiModel? dataResponse;

  SuccessState({required this.dataResponse});

  @override
  List<Object?> get props => [dataResponse];
}

class FailureState extends OpenAiState {
  @override
  List<Object?> get props => [];
}
