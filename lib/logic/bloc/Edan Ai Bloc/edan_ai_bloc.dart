import 'package:bloc/bloc.dart';

import '../../repo/repositories.dart';
import 'edan_ai_event.dart';
import 'edan_ai_state.dart';

class EdanAiBloc extends Bloc<EdanAiEvents, EdanAiState> {
  Repositories repositories = Repositories();

  EdanAiBloc() : super(InitialState()) {
    on<EdanAiEvents>(_sendQuery);
  }
  void _sendQuery(event, emit) async {
    if (event is SendQueryEvent) {
      emit.call(LoadingState());
      await repositories.edanAiRemoteService(event.query).then((value) {
        emit.call(SuccessState(dataResponse: value));
      }).onError((error, stacktrace) {
        emit.call(FailureState());
      });
    }
  }
}
