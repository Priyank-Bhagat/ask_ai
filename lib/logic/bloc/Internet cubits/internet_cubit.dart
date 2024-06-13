import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

part 'internet_state.dart';

class InternetCubit extends Cubit<InternetState> {
  final Connectivity _connect = Connectivity();

  InternetCubit() : super(InternetInitialState()) {
    _connect.onConnectivityChanged.listen((result) {
      if (result.contains(ConnectivityResult.mobile) ||
          result.contains(ConnectivityResult.wifi)) {
        emit(InternetGainedState());
      } else {
        emit(InternetLostState());
      }
    });
  }
}
