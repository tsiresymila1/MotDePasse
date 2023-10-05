abstract class WordStepEvent {}

class InitWordStepEvent extends WordStepEvent {
  final List<String> words;
  final int maxStep ;
  InitWordStepEvent({required this.words, required this.maxStep, });
}

class UpdateWordStepEvent  extends WordStepEvent {
  final int step;
  final String? wordFound;
  final String? notFoundWord;
  UpdateWordStepEvent({required this.step, this.wordFound, this.notFoundWord});
}