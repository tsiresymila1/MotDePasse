class WordState {
  final int currentIndex;
  final List<List<String>> words;

  WordState({
    this.currentIndex = 0,
    this.words = const [],
  });

  WordState copyWith({int? currentIndex,List<List<String>>? words}){
    return WordState(currentIndex: currentIndex ?? this.currentIndex,words: words ?? this.words);
  }
}
