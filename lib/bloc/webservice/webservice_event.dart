part of 'webservice_bloc.dart';

sealed class WebserviceEvent extends Equatable {
  const WebserviceEvent();

  @override
  List<Object> get props => [];
}

final class WebserviceLoad extends WebserviceEvent {
  final String query;

  const WebserviceLoad(this.query);

  @override
  List<Object> get props => [query];
}
