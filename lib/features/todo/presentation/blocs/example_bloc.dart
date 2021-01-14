import 'package:bloc/bloc.dart';
import 'package:todo/features/todo/domain/entities/entities.dart';
import 'package:todo/features/todo/domain/services/services.dart';

abstract class ExampleEvent {}

class GetExampleEvent extends ExampleEvent {}

abstract class ExampleState {}

class InitialExampleState extends ExampleState {}

class LoadingExampleState extends ExampleState {}

class LoadedExampleState extends ExampleState {
  final ExampleEntity entity;

  LoadedExampleState(this.entity);
}

class ErrorExampleState extends ExampleState {
  final String message;

  ErrorExampleState(this.message);
}

abstract class IExampleBloc extends Bloc<ExampleEvent, ExampleState> {
  final IExampleService service;

  IExampleBloc(ExampleState initialState, this.service) : super(initialState);
}

class ExampleBloc extends IExampleBloc {
  ExampleBloc(IExampleService service) : super(InitialExampleState(), service);

  @override
  Stream<ExampleState> mapEventToState(ExampleEvent event) async* {
    if (event is GetExampleEvent) {
      yield LoadingExampleState();
      await Future.delayed(Duration(seconds: 3)); // Simulate loading time
      final result = await service.getEntity();
      if (result.isOk) {
        yield LoadedExampleState(result.data);
      } else {
        yield ErrorExampleState(result.failure.message);
      }
    }
  }
}
