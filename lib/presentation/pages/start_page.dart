import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:motdepasse/core/utils/logger.dart';
import 'package:motdepasse/presentation/bloc/word/word_bloc.dart';
import 'package:motdepasse/presentation/bloc/word/word_event.dart';
import 'package:motdepasse/presentation/bloc/word/word_state.dart';
import 'package:motdepasse/presentation/bloc/word_step/word_step_bloc.dart';
import 'package:motdepasse/presentation/bloc/word_step/word_step_event.dart';
import 'package:motdepasse/presentation/widgets/button_icon.dart';

import '../widgets/step_item.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange.withOpacity(0.8),
      body: BlocListener<WordBloc, WordState>(
        listenWhen: (oldState, newState) => oldState.words != newState.words,
        listener: (context, state) {
          if (state.words.isNotEmpty) {
            logger.i("Init words :: ${state.words}");
            context.read<WordStepBloc>().add(InitWordStepEvent(
                words: state.words[state.currentIndex],
                maxStep: 9 - state.currentIndex));
            context.replace('/scene');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<WordBloc, WordState>(builder: (context, state) {
            return Column(
              children: [
                Expanded(
                    child: Center(
                        child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: ["100", "250", "500", "1000", "2000"]
                      .asMap()
                      .entries
                      .map<Widget>((e) {
                    return StepItem(
                      title: e.value,
                      index: e.key,
                      isActive: state.currentIndex == e.key,
                    );
                  }).toList(),
                ))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ButtonIcon(
                        onPressed: () {
                          if (state.currentIndex == 0) {
                            context
                                .read<WordBloc>()
                                .add(WordGenerateWordEvent(context: context));
                          } else {
                            logger.i("Words :: ${state.words}");
                            context.read<WordStepBloc>().add(InitWordStepEvent(
                                words: state.words[state.currentIndex],
                                maxStep: 9 - state.currentIndex));
                            context.replace('/scene');
                          }
                        },
                        icon: const Icon(
                          Icons.play_circle,
                          color: Colors.white,
                        ),
                        title: "Start"),
                    Visibility(
                        visible: state.currentIndex == 4,
                        child: ButtonIcon(
                            onPressed: () {
                              context.replace('/score');
                            },
                            icon: const Icon(
                              Icons.skip_next,
                              color: Colors.white,
                            ),
                            title: "Skip"))
                  ],
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
