import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:appwrite/appwrite.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:motdepasse/core/utils/logger.dart';
import 'package:motdepasse/presentation/widgets/storage.dart';
import 'package:motdepasse/presentation/widgets/appwrite.dart';
import 'word_event.dart';
import 'word_state.dart';

class WordBloc extends Bloc<WordEvent, WordState> {
  WordBloc() : super(WordState()) {
    on<WordInitEvent>((_, emit) => emit(WordState()));
    on<WordUpdateIndexEvent>(
        (event, emit) => emit(state.copyWith(currentIndex: event.index)));
    on<WordGenerateWordEvent>((event, emit) async {
      List<List<String>> words = [];
      List<String> savedWords = [];
      List<String> nouns = [];
      try {
        final databases = Databases(event.context.appWrite);
        final  words = await databases.listDocuments(databaseId: dotenv.get("APPWRITE_DATABASE_ID"), collectionId: dotenv.get("APPWRITE_COLLECTION_ID"));
        nouns = words.documents.map((e) => e.data["word"].toString()).toList();
        logger.i(nouns.length);
        event.context.storage.write("words", nouns);
      }
      catch(e){
        nouns = (event.context.storage.read<List<dynamic>>("words") ?? []).map((e) => e.toString()).toList();
        logger.e(e);
      }
      for (int i = 0; i < 5; i++) {
        List<String> tmp = nouns
            .where((element) => !savedWords.contains(element))
            .toList();
        tmp.shuffle();
        List<String> take = tmp.take(9 - i).toList();
        words.add(take);
        savedWords.addAll(take);
      }
      add(WordGeneratedWordEvent(words: words));
    });
    on<WordGeneratedWordEvent>(
        (event, emit) => emit(WordState(words: event.words)));
  }
}
