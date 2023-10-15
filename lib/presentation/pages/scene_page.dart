import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:line_icons/line_icon.dart';
import 'package:lottie/lottie.dart';
import 'package:motdepasse/core/utils/audio.dart';
import 'package:motdepasse/presentation/bloc/word/word_bloc.dart';
import 'package:motdepasse/presentation/bloc/word/word_state.dart';
import 'package:motdepasse/presentation/bloc/word_step/word_step_bloc.dart';
import 'package:motdepasse/presentation/bloc/word_step/word_step_event.dart';
import 'package:motdepasse/presentation/bloc/word_step/word_step_state.dart';
import 'package:motdepasse/presentation/widgets/button_icon.dart';
import 'package:motdepasse/presentation/widgets/storage.dart';
import 'package:timer_count_down/timer_count_down.dart';

import '../../core/utils/constant.dart';
import '../../core/utils/logger.dart';
import '../bloc/word/word_event.dart';

class ScenePage extends StatelessWidget {
  const ScenePage({Key? key}) : super(key: key);

  check(BuildContext context, WordState wordState, WordStepState state) {
    logger.i("Words found::: ${state.wordsFound}");
    if (state.currentStep + 1 < state.maxStep) {
      if (state.wordsFound.length + 1 == MAX_STEP) {
        soundFinish(context, () {
          context.read<WordStepBloc>().add(UpdateWordStepEvent(
              step: state.currentStep,
              wordFound: state.words[state.currentStep]));
          context
              .read<WordBloc>()
              .add(WordUpdateIndexEvent(index: wordState.currentIndex + 1));
          context.replace("/detail");
        });
      } else {
        soundCorrect(context, () {
          context.read<WordStepBloc>().add(UpdateWordStepEvent(
              step: state.currentStep + 1,
              wordFound: state.words[state.currentStep]));
        });
      }
    } else {
      soundFinish(context, () {
        context.read<WordStepBloc>().add(UpdateWordStepEvent(
            step: state.currentStep,
            wordFound: state.words[state.currentStep]));
        context
            .read<WordBloc>()
            .add(WordUpdateIndexEvent(index: wordState.currentIndex + 1));
        if (wordState.currentIndex + 1 < MAX_STEP) {
          context.replace("/detail");
        } else {
          context.replace("/score");
        }
      });
    }
  }

  pass(BuildContext context, WordState wordState, WordStepState state) async {
    logger.w(
        [state.maxStep, state.currentStep, state.wordsFound.length, MAX_STEP]);
    if ((state.maxStep - 1 - state.currentStep + 1) <
        MAX_STEP - state.wordsFound.length + 1) {
      soundFailed(context, () {
        context.read<WordStepBloc>().add(UpdateWordStepEvent(
            step: state.currentStep,
            notFoundWord: state.words[state.currentStep]));
        context.replace("/score");
      });
      return;
    }
    if (state.currentStep + 1 < state.maxStep) {
      soundFail(context, () {
        context.read<WordStepBloc>().add(UpdateWordStepEvent(
            step: state.currentStep + 1,
            notFoundWord: state.words[state.currentStep]));
      });
    } else {
      soundFailed(context, () {
        context.read<WordStepBloc>().add(UpdateWordStepEvent(
            step: state.currentStep,
            notFoundWord: state.words[state.currentStep]));
        context.replace("/score");
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.deepOrange.withOpacity(0.8),
        body: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
                  child: Countdown(
                    seconds: int.parse(
                            context.storage.read<String>("duration") ?? "3") *
                        60,
                    build: (BuildContext context, double time) => Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.deepOrange.withOpacity(0.8),
                                blurStyle: BlurStyle.inner,
                                blurRadius: 12,
                                spreadRadius: 2,
                                offset: const Offset(-2, 3)),
                            BoxShadow(
                                color: Colors.deepOrange.withOpacity(0.6),
                                blurStyle: BlurStyle.inner,
                                blurRadius: 12,
                                spreadRadius: 2,
                                offset: const Offset(-2, 4))
                          ],
                          borderRadius: BorderRadius.circular(8)),
                      child: Text(
                        "${(time ~/ 60).toString().padLeft(2, "0")}:${(time % 60).toInt().toString().padLeft(2, "0")}",
                        style: const TextStyle(
                          fontSize: 28,
                        ),
                      ),
                    ),
                    interval: const Duration(milliseconds: 1000),
                    onFinished: () {
                      soundFailed(context, () => context.replace("/score"));
                    },
                  ),
                ),
              ],
            ),
            BlocBuilder<WordBloc, WordState>(
              builder: (context, wordState) {
                return BlocBuilder<WordStepBloc, WordStepState>(
                    builder: (context, state) {
                  final currentWord = state.words[state.currentStep];
                  return Expanded(
                    child: Column(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ZoomIn(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8, vertical: 8),
                                      decoration: BoxDecoration(
                                        color: Colors.deepOrange,
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: [
                                          BoxShadow(
                                              color: Colors.deepPurple
                                                  .withOpacity(0.8),
                                              blurStyle: BlurStyle.inner,
                                              blurRadius: 12,
                                              spreadRadius: 2,
                                              offset: const Offset(-2, 4)),
                                          BoxShadow(
                                              color: Colors.deepPurple
                                                  .withOpacity(0.6),
                                              blurStyle: BlurStyle.inner,
                                              blurRadius: 12,
                                              spreadRadius: 2,
                                              offset: const Offset(-2, 4))
                                        ],
                                      ),
                                      child: Text(
                                        currentWord,
                                        style: const TextStyle(
                                            fontSize: 36,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 24),
                                child: Text(
                                  "Find logical word around",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24),
                                ),
                              ),
                              SizedBox(
                                  height: 120,
                                  child: Lottie.asset(
                                      "assets/lotties/connecting.json")),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(bottom: 24),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              ButtonIcon(
                                title: "Pass",
                                onPressed: () {
                                  pass(context, wordState, state);
                                },
                                icon: const Icon(
                                  OctIcons.x_circle_16,
                                  color: Colors.red,
                                ),
                              ),
                              ButtonIcon(
                                title: "Check",
                                onPressed: () {
                                  check(context, wordState, state);
                                },
                                icon: const Icon(
                                  OctIcons.check_circle_16,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                });
              },
            ),
          ],
        ));
  }
}
