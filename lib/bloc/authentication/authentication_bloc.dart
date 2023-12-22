import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobilestock/core/service_locator.dart';
import 'package:mobilestock/repository/authentication_repository.dart';
import 'package:mobilestock/global.dart' as global;

part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationInitial()) {
    on<AuthenticationLoggedIn>(_onLoggedIn);
    on<AuthenticationLoggedOut>(_onLoggedOut);
  }

  void _onLoggedIn(AuthenticationLoggedIn event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationInProgress());
    try {
      final result = await serviceLocator<AuthRepository>().authenUser(event.username, event.password, event.provider, event.dbName);
      if (result.success) {
        global.appStorage.write("usercode", event.username);
        global.appStorage.write("provider", event.provider);
        global.appStorage.write("dbname", event.dbName);
        global.appStorage.write("username", event.username);
        emit(AuthenticationSuccess(result.data));
      } else {
        emit(AuthenticationError(result.message));
      }
    } catch (e) {
      emit(AuthenticationError(e.toString()));
      return;
    }
  }

  void _onLoggedOut(AuthenticationLoggedOut event, Emitter<AuthenticationState> emit) async {
    emit(AuthenticationInProgress());
    try {
      global.appStorage.write("usercode", "");
      global.appStorage.write("username", "");
      global.appStorage.write("provider", "");
      global.appStorage.write("dbname", "");
      emit(AuthenticationLogout());
    } catch (e) {
      emit(AuthenticationError(e.toString()));
      return;
    }
  }
}
