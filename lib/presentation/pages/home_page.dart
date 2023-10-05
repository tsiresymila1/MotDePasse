import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:motdepasse/presentation/bloc/word/word_bloc.dart';
import 'package:motdepasse/presentation/bloc/word/word_state.dart';
import "package:flutter_bloc/flutter_bloc.dart";
import 'package:motdepasse/presentation/bloc/word_step/word_step_bloc.dart';
import 'package:motdepasse/presentation/bloc/word_step/word_step_event.dart';
import '../bloc/word/word_event.dart';
import '../widgets/button_icon.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange.withOpacity(0.8),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
              child: Text(
                "MOT DE PASSE",
                style: TextStyle(color: Colors.white, fontSize: 32),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ButtonIcon(
                  title: "Play",
                  onPressed: () {
                    context
                        .read<WordStepBloc>()
                        .add(InitWordStepEvent(words: [], maxStep: 0));
                    context.read<WordBloc>().add(WordInitEvent());
                    context.push("/home");
                  },
                  icon: const Icon(Icons.play_circle, color: Colors.white),
                ),
                ButtonIcon(
                  title: "Setting",
                  onPressed: () {
                    context.push("/setting");
                  },
                  icon: const Icon(Icons.settings, color: Colors.white),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
