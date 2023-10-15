import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:motdepasse/core/utils/audio.dart';
import 'package:motdepasse/core/utils/logger.dart';
import 'package:motdepasse/presentation/bloc/loading/loading_bloc.dart';
import 'package:motdepasse/presentation/bloc/loading/loading_state.dart';
import 'package:motdepasse/presentation/bloc/word/word_bloc.dart';
import 'package:motdepasse/presentation/bloc/word/word_event.dart';
import 'package:motdepasse/presentation/bloc/word/word_state.dart';
import 'package:motdepasse/presentation/bloc/word_step/word_step_bloc.dart';
import 'package:motdepasse/presentation/bloc/word_step/word_step_event.dart';
import 'package:motdepasse/presentation/widgets/button_icon.dart';
import 'package:quickalert/quickalert.dart';

import '../widgets/step_item.dart';

class StartPage extends StatelessWidget {
  const StartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange.withOpacity(0.8),
      body: BlocListener<WordBloc, WordState>(
        listener: (context, state) async {
          logger.w(state.words.length);
          if (state.words.isNotEmpty &&
              state.words.reduce((value, element) {
                    for (final v in value) {
                      element.add(v);
                    }
                    return element;
                  }).length ==
                  35) {
            context.read<WordStepBloc>().add(InitWordStepEvent(
                words: state.words[state.currentIndex],
                maxStep: 9 - state.currentIndex));
            soundStart(context, () {
              context.replace('/scene');
            });
          } else {
            QuickAlert.show(
                context: context,
                type: QuickAlertType.warning,
                confirmBtnColor: Colors.deepOrange,
                title: "Erreur",
                text:
                    'There is no enough words in in local. Please connect to internet to load all available words!');
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: BlocBuilder<WordBloc, WordState>(builder: (context, state) {
            return Column(
              children: [
                Expanded(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        child: SizedBox(
                            child: Lottie.asset("assets/lotties/gold.json",
                                repeat: true)),
                      ),
                      Column(
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
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Visibility(
                        visible: state.currentIndex == 4,
                        child: ButtonIcon(
                            onPressed: () {
                              soundFinish(context, () {
                                context.replace('/score');
                              });
                            },
                            icon: const Icon(
                              Bootstrap.skip_forward,
                              color: Colors.white,
                            ),
                            title: "Skip")),
                    BlocBuilder<LoadingBloc, LoadingState>(
                      builder: (context, loadingBlocState) {
                        return Visibility(
                          visible: !loadingBlocState.isLoading,
                          replacement: const SizedBox(
                              height: 80,
                              width: 80,
                              child: CupertinoActivityIndicator(
                                radius: 10,
                                color: Colors.white,
                              )),
                          child: ButtonIcon(
                              onPressed: () {
                                if (state.currentIndex == 0) {
                                  context.read<WordBloc>().add(
                                      WordGenerateWordEvent(context: context));
                                } else {
                                  context.read<WordStepBloc>().add(
                                      InitWordStepEvent(
                                          words:
                                              state.words[state.currentIndex],
                                          maxStep: 9 - state.currentIndex));
                                  context.replace('/scene');
                                }
                              },
                              icon: const Icon(
                                Bootstrap.play_circle,
                                color: Colors.white,
                              ),
                              title: "Start"),
                        );
                      },
                    ),
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
