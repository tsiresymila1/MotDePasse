class WordStepState {
  final int maxStep;
  final int currentStep;
  final List<String> words;
  final List<String> wordsFound;
  final List<String> wordsNotFound;

  WordStepState(
      {required this.maxStep,
      this.currentStep = 0,
      this.words = const [],
      this.wordsNotFound = const [],
      this.wordsFound = const []});

  WordStepState copyWith(
      {int? maxStep,
      int? currentStep,
      List<String>? words,
      List<String>? wordsFound,
      List<String>? wordsNotFound}) {
    return WordStepState(
        maxStep: maxStep ?? this.maxStep,
        currentStep: currentStep ?? this.currentStep,
        words: words ?? this.words,
        wordsFound: wordsFound ?? this.wordsFound,
        wordsNotFound: wordsNotFound ?? this.wordsNotFound);
  }
}
