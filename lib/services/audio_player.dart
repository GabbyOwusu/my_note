import 'package:audioplayer/audioplayer.dart';

class PlayAudio {
  AudioPlayer player = AudioPlayer();

  Future<void> playAudio(String path) async {
    try {
      await player.play(path, isLocal: true);
    } catch (e) {
      print('The audio cannot be played because $e');
    }
  }

  Future<void> pauseAudio() async {
    await player.stop();
  }

  Future<void> seek() async {}
}
