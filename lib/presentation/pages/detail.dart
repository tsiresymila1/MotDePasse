import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:lottie/lottie.dart';
import 'package:motdepasse/core/utils/score.dart';
import 'package:motdepasse/presentation/bloc/word/word_bloc.dart';
import 'package:motdepasse/presentation/bloc/word/word_state.dart';
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
            return Stack(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Lottie.asset("assets/lotties/congrat.json"),
                    Lottie.asset("assets/lotties/congrat.json")
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Column(
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
                                            fontSize: 32,
                                            color: state.wordsFound.contains(e)
                                                ? Colors.white
                                                : Colors.red),
                                      ))
                                  .toList(),
                            ),
                            BlocBuilder<WordBloc, WordState>(
                              builder: (context, state) {
                                String score =
                                    getScoreByIndex(state.currentIndex);
                                return Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 24, vertical: 8),
                                  margin: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                      color: const Color(0xffFFD700),
                                      borderRadius: BorderRadius.circular(8),
                                      boxShadow: const [
                                        BoxShadow(
                                            color: Color(0xd7ffd700),
                                            blurStyle: BlurStyle.inner,
                                            blurRadius: 12,
                                            spreadRadius: 2,
                                            offset: Offset(-2, 4)),
                                        BoxShadow(
                                            color: Color(0x94ffd700),
                                            blurStyle: BlurStyle.inner,
                                            blurRadius: 12,
                                            spreadRadius: 2,
                                            offset: Offset(-2, 4))
                                      ]),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(score,
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 36)),
                                      const Icon(
                                        Icons.monetization_on_rounded,
                                        color: Colors.white,
                                        size: 16,
                                      )
                                    ],
                                  ),
                                );
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ButtonIcon(
                            onPressed: () {
                              context.replace("/home");
                            },
                            icon: const Icon(
                              LineAwesome.forward_solid,
                              color: Colors.white,
                            ),
                            title: "Next"),
                      ],
                    )
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
