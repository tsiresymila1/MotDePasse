import 'package:bloc/bloc.dart';

import 'loading_event.dart';
import 'loading_state.dart';

class LoadingBloc extends Bloc<LoadingEvent, LoadingState> {
  LoadingBloc() : super(LoadingState(isLoading: false)) {
    on<UpdateLoadingEvent>(_update);
  }

  void _update(UpdateLoadingEvent event, Emitter<LoadingState> emit) async {
    emit(LoadingState(isLoading: event.isLoading));
  }
}
