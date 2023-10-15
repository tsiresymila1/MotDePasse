import "package:get_it/get_it.dart";
import "package:motdepasse/presentation/bloc/loading/loading_bloc.dart";
import "package:motdepasse/presentation/bloc/word/word_bloc.dart";
import "package:motdepasse/presentation/bloc/word_step/word_step_bloc.dart";

final sl = GetIt.instance;


setupDependency(){
  sl.registerSingleton<LoadingBloc>(LoadingBloc());
  sl.registerSingleton<WordBloc>(WordBloc(loadingBloc:sl.get<LoadingBloc>() ));
  sl.registerSingleton<WordStepBloc>(WordStepBloc());
}