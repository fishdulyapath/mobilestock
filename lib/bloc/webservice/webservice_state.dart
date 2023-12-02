part of 'webservice_bloc.dart';

sealed class WebserviceState extends Equatable {
  const WebserviceState();

  @override
  List<Object> get props => [];
}

final class WebserviceInitial extends WebserviceState {}

final class WebserviceLoading extends WebserviceState {}

final class WebserviceLoadSuccess extends WebserviceState {
  final List<dynamic> data;

  const WebserviceLoadSuccess(this.data);

  @override
  List<Object> get props => [data];
}

final class WebserviceLoadError extends WebserviceState {
  final String message;

  const WebserviceLoadError(this.message);

  @override
  List<Object> get props => [message];
}
