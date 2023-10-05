import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motdepasse/presentation/bloc/word/word_bloc.dart';
import 'package:motdepasse/presentation/bloc/word/word_state.dart';

class ScorePage extends StatelessWidget {
  const ScorePage({Key? key}) : super(key: key);

  String getScoreByIndex(int index) {
    switch (index) {
      case 0:
        return "0";
      case 1:
        return "100";
      case 2:
        return "250";
      case 3:
        return "500";
      case 4:
        return "1000";
      default:
        return "2000";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange.withOpacity(0.8),
      body: Center(
        child: BlocBuilder<WordBloc, WordState>(
          builder: (context, state) {
            String score = getScoreByIndex(state.currentIndex);
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
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
            );
          },
        ),
      ),
    );
  }
}
