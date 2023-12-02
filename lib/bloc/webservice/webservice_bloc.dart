import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:mobilestock/core/service_locator.dart';
import 'package:mobilestock/repository/webservice_repository.dart';

part 'webservice_event.dart';
part 'webservice_state.dart';

class WebserviceBloc extends Bloc<WebserviceEvent, WebserviceState> {
  WebserviceBloc() : super(WebserviceInitial()) {
    on<WebserviceLoad>(_onWebServiceLoad);
  }

  void _onWebServiceLoad(WebserviceLoad event, Emitter<WebserviceState> emit) async {
    emit(WebserviceLoading());
    try {
      final result = await serviceLocator<WebServiceRepository>().querySelect(event.query);
      if (result.success) {
        emit(WebserviceLoadSuccess(result.data));
      } else {
        emit(WebserviceLoadError(result.message));
      }
    } catch (e) {
      emit(WebserviceLoadError(e.toString()));
    }
  }
}
