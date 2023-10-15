
import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart' as au;



base class AudioPlayerContext extends InheritedWidget {
  final player = au.AudioPlayer();
  AudioPlayerContext({super.key, required super.child});

  @override
  bool updateShouldNotify(covariant AudioPlayerContext oldWidget) {
    return false;
  }

  static AudioPlayerContext? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<AudioPlayerContext>();
  }

  static AudioPlayerContext of(BuildContext context) {
    final AudioPlayerContext? result = maybeOf(context);
    assert(result != null, 'No AudioPlayerProvider found in context');
    return result!;
  }
}

class AudioPlayerProvider extends StatelessWidget {
  final Widget child;

  const AudioPlayerProvider(
      {super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return AudioPlayerContext(
      child: Builder(builder: (context) => child),
    );
  }
}

extension AudioPlayer on BuildContext {
  au.AudioPlayer get audioPlayer => AudioPlayerContext.of(this).player;
}
