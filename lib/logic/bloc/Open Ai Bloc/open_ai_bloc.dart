import 'package:bloc/bloc.dart';

import '../../repo/repositories.dart';
import 'open_ai_event.dart';
import 'open_ai_state.dart';

class OpenAiBloc extends Bloc<OpenAiEvent, OpenAiState> {
  Repositories repositories = Repositories();

  OpenAiBloc() : super(InitialState()) {
    on<OpenAiEvent>(_sendQuery);
  }
  void _sendQuery(event, emit) async {
    if (event is SendQueryEvent) {
      emit.call(LoadingState());
      await repositories.openAiRemoteService(event.query).then((value) {
        emit.call(SuccessState(dataResponse: value));
      }).onError((error, stacktrace) {
        emit.call(FailureState());
      });
    }
  }
}
