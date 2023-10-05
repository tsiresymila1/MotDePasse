import 'package:bloc/bloc.dart';

import 'word_step_event.dart';
import 'word_step_state.dart';

class WordStepBloc extends Bloc<WordStepEvent, WordStepState> {
  WordStepBloc() : super(WordStepState(maxStep: 0, words: [])) {
    on<InitWordStepEvent>((event, emit) =>
        emit(WordStepState(maxStep: event.maxStep, words: event.words)));
    on<UpdateWordStepEvent>((event, emit) => emit(state.copyWith(
        currentStep: event.step,
        wordsFound: event.wordFound != null
            ? [...state.wordsFound, event.wordFound!]
            : null,
        wordsNotFound: event.notFoundWord != null
            ? [...state.wordsNotFound, event.notFoundWord!]
            : null)));
  }
}
