import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:motdepasse/presentation/bloc/word_step/word_step_bloc.dart';
import 'package:motdepasse/presentation/bloc/word_step/word_step_state.dart';
import 'package:motdepasse/presentation/widgets/button_icon.dart';

class DetailScreen extends StatelessWidget {
  const DetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange.withOpacity(0.8),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: BlocBuilder<WordStepBloc, WordStepState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: state.words
                          .take(state.currentStep + 1)
                          .toList()
                          .map((e) => Text(
                                e,
                                style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                    color: state.wordsFound.contains(e)
                                        ? Colors.white
                                        : Colors.red),
                              ))
                          .toList(),
                    ),
                  ),
                ),
                ButtonIcon(
                    onPressed: () {
                      context.replace("/home");
                    },
                    icon: const Icon(
                      Icons.skip_next_rounded,
                      color: Colors.white,
                    ),
                    title: "Next")
              ],
            );
          },
        ),
      ),
    );
  }
}
