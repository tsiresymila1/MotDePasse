import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_storage/get_storage.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:motdepasse/di.dart';
import 'package:motdepasse/presentation/bloc/loading/loading_bloc.dart';
import 'package:motdepasse/presentation/bloc/word/word_bloc.dart';
import 'package:motdepasse/presentation/bloc/word_step/word_step_bloc.dart';
import 'package:motdepasse/presentation/pages/detail.dart';
import 'package:motdepasse/presentation/pages/home_page.dart';
import 'package:motdepasse/presentation/pages/scene_page.dart';
import 'package:motdepasse/presentation/pages/score_page.dart';
import 'package:motdepasse/presentation/pages/settings.dart';
import 'package:motdepasse/presentation/pages/start_page.dart';
import 'package:motdepasse/presentation/widgets/appwrite.dart';
import 'package:motdepasse/presentation/widgets/audio_player.dart';
import 'package:motdepasse/presentation/widgets/storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  setupDependency();
  await GetStorage.init();
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final GoRouter _router = GoRouter(initialLocation: "/", routes: [
    GoRoute(path: "/", builder: (context, state) => const HomePage()),
    GoRoute(path: "/home", builder: (context, state) => const StartPage()),
    GoRoute(path: "/scene", builder: (context, state) => const ScenePage()),
    GoRoute(path: "/detail", builder: (context, state) => const DetailScreen()),
    GoRoute(path: "/score", builder: (context, state) => const ScorePage()),
    GoRoute(path: "/setting", builder: (context, state) => const SettingPage())
  ]);

  @override
  Widget build(BuildContext context) {
    return AppWriteProvider(
      client: Client()
          .setEndpoint('https://cloud.appwrite.io/v1')
          .setProject(dotenv.get("APPWRITE_PROJECT_ID", fallback: ""))
          .setSelfSigned(status: true),
      child: AudioPlayerProvider(
        child: Builder(builder: (context) {
          return StorageProvider(
            storage: GetStorage(),
            child: MultiBlocProvider(
              providers: [
                BlocProvider<LoadingBloc>(
                    create: (context) => sl.get<LoadingBloc>()),
                BlocProvider<WordBloc>(create: (context) => sl.get<WordBloc>()),
                BlocProvider<WordStepBloc>(
                    create: (context) => sl.get<WordStepBloc>())
              ],
              child: MaterialApp.router(
                title: 'Mot de passe',
                debugShowCheckedModeBanner: false,
                theme: ThemeData(
                    colorScheme:
                        ColorScheme.fromSeed(seedColor: Colors.deepOrange),
                    useMaterial3: true,
                    fontFamily: 'AkayaTelivigala',
                    buttonTheme: Theme.of(context)
                        .buttonTheme
                        .copyWith(buttonColor: Colors.deepOrange)),
                routerConfig: _router,
              ),
            ),
          );
        }),
      ),
    );
  }
}
