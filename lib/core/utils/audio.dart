import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:motdepasse/presentation/widgets/audio_player.dart';

soundStart(BuildContext context, Function() callback) {
  context.audioPlayer.stop().then((value) {
    context.audioPlayer.play(AssetSource('audio/start.mp3')).then((value) {
      callback();
    });
  });
}

soundFail(BuildContext context, Function() callback) {
  context.audioPlayer.stop().then((value) {
    context.audioPlayer.play(AssetSource('audio/fail.mp3')).then((value) {
      callback();
    });
  });
}

soundFailed(BuildContext context, Function() callback) {
  context.audioPlayer.stop().then((value) {
    context.audioPlayer.play(AssetSource('audio/failure.mp3')).then((value) {
      callback();
    });
  });
}

soundCorrect(BuildContext context, Function() callback) {
  context.audioPlayer.stop().then((value) {
    context.audioPlayer.play(AssetSource('audio/success.mp3')).then((value) {
      callback();
    });
  });
}

soundFinish(BuildContext context, Function() callback) {
  context.audioPlayer.stop().then((value) {
    context.audioPlayer.play(AssetSource('audio/finished.mp3')).then((value) {
      callback();
    });
  });
}