import 'package:equatable/equatable.dart';
import '../../model/edan_ai_model.dart';

abstract class EdanAiState extends Equatable {}

class InitialState extends EdanAiState {
  @override
  List<Object?> get props => [];
}

class LoadingState extends EdanAiState {
  @override
  List<Object?> get props => [];
}

class SuccessState extends EdanAiState {
  final EdanAiModel? dataResponse;

  SuccessState({required this.dataResponse});

  @override
  List<Object?> get props => [dataResponse];
}

class FailureState extends EdanAiState {
  @override
  List<Object?> get props => [];
}
