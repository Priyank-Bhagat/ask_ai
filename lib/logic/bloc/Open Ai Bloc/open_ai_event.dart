import 'package:equatable/equatable.dart';

abstract class OpenAiEvent extends Equatable {}

class SendQueryEvent extends OpenAiEvent {
  String query;
  SendQueryEvent({required this.query});

  @override
  List<Object?> get props => [query];
}
