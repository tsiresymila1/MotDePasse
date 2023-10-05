import 'package:flutter/material.dart';

abstract class WordEvent {}

class WordInitEvent extends WordEvent {}

class WordUpdateIndexEvent extends WordEvent {
  final int index;
  WordUpdateIndexEvent({required this.index});
}

class WordGenerateWordEvent extends WordEvent {
  final BuildContext context;
  WordGenerateWordEvent({required this.context});
}

class WordGeneratedWordEvent extends WordEvent {
  final List<List<String>> words;

  WordGeneratedWordEvent({required this.words});
}
