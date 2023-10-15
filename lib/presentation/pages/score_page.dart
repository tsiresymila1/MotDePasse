import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:motdepasse/core/utils/score.dart';
import 'package:motdepasse/presentation/bloc/word/word_bloc.dart';
import 'package:motdepasse/presentation/bloc/word/word_state.dart';

class ScorePage extends StatelessWidget {
  const ScorePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange.withOpacity(0.8),
      body: Center(
        child: BlocBuilder<WordBloc, WordState>(
          builder: (context, state) {
            String score = getScoreByIndex(state.currentIndex);
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
                    Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      child: SizedBox(
                          child: Lottie.asset("assets/lotties/congratulation.json")),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 12),
                      child: Text("Score",
                          style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 42,
                              color: Color(0xffFFD700))),
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(score,
                            style: const TextStyle(
                                color: Color(0xffFFD700),
                                fontWeight: FontWeight.w700,
                                fontSize: 36)),
                        const Icon(
                          Icons.monetization_on_rounded,
                          color: Color(0xffFFD700),
                          size: 16,
                        )
                      ],
                    ),
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
