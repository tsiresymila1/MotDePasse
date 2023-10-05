import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:motdepasse/presentation/bloc/word/word_bloc.dart';
import 'package:motdepasse/presentation/bloc/word/word_state.dart';
import 'package:motdepasse/presentation/bloc/word_step/word_step_bloc.dart';
import 'package:motdepasse/presentation/bloc/word_step/word_step_event.dart';
import 'package:motdepasse/presentation/bloc/word_step/word_step_state.dart';
import 'package:motdepasse/presentation/widgets/button_icon.dart';

import '../../core/utils/constant.dart';
import '../../core/utils/logger.dart';
import '../bloc/word/word_event.dart';

class ScenePage extends StatelessWidget {
  const ScenePage({Key? key}) : super(key: key);

  check(BuildContext context, WordState wordState, WordStepState state) {
    logger.i("Words found::: ${state.wordsFound}");
    if (state.currentStep + 1 < state.maxStep) {
      if (state.wordsFound.length + 1 == MAX_STEP) {
        context.read<WordStepBloc>().add(UpdateWordStepEvent(
            step: state.currentStep,
            wordFound: state.words[state.currentStep]));
        context
            .read<WordBloc>()
            .add(WordUpdateIndexEvent(index: wordState.currentIndex + 1));
        context.replace("/detail");
      } else {
        context.read<WordStepBloc>().add(UpdateWordStepEvent(
            step: state.currentStep + 1,
            wordFound: state.words[state.currentStep]));
      }
    } else {
      if (wordState.currentIndex + 1 < MAX_STEP) {
        context
            .read<WordBloc>()
            .add(WordUpdateIndexEvent(index: wordState.currentIndex + 1));
        context.replace("/detail");
      } else {
        context.replace("/score");
      }
    }
  }

  pass(BuildContext context, WordState wordState, WordStepState state) {
    if ((state.maxStep - 1 - state.currentStep + 1) <
        MAX_STEP - state.wordsFound.length + 1) {
      context.read<WordStepBloc>().add(UpdateWordStepEvent(
          step: state.currentStep,
          notFoundWord: state.words[state.currentStep]));
      context.replace("/score");
      return;
    }
    if (state.currentStep + 1 < state.maxStep) {
      context.read<WordStepBloc>().add(UpdateWordStepEvent(
          step: state.currentStep + 1,
          notFoundWord: state.words[state.currentStep]));
    } else {
      context.read<WordStepBloc>().add(UpdateWordStepEvent(
          step: state.currentStep,
          notFoundWord: state.words[state.currentStep]));
      context.replace("/score");
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WordBloc, WordState>(
      builder: (context, wordState) {
        return BlocBuilder<WordStepBloc, WordStepState>(
          builder: (context, state) {
            final currentWord = state.words[state.currentStep];
            return Scaffold(
              backgroundColor: Colors.deepOrange.withOpacity(0.8),
              body: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [],
                  ),
                  Expanded(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 8),
                        decoration: const BoxDecoration(
                            color: Colors.deepOrange,
                            border: Border.symmetric(
                                horizontal: BorderSide.none,
                                vertical: BorderSide(
                                    color: Colors.deepPurple, width: 10))),
                        child: Text(
                          currentWord,
                          style: const TextStyle(
                              fontSize: 36, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  )),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      ButtonIcon(
                        title: "Pass",
                        onPressed: () {
                          pass(context, wordState, state);
                        },
                        icon:
                            const Icon(Icons.close_outlined, color: Colors.red),
                      ),
                      ButtonIcon(
                        title: "Check",
                        onPressed: () {
                          check(context, wordState, state);
                        },
                        icon: const Icon(Icons.check, color: Colors.green),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
