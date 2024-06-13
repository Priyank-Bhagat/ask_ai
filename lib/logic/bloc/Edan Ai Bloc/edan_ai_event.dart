import 'package:equatable/equatable.dart';

abstract class EdanAiEvents extends Equatable {}

class SendQueryEvent extends EdanAiEvents {
  String query;
  SendQueryEvent({required this.query});

  @override
  List<Object?> get props => [query];
}
