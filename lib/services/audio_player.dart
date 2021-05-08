import 'package:audioplayers/audioplayers.dart';

class PlayAudio {
  Future<void> playAudio(AudioPlayer player, String path) async {
    try {
      await player.play(path, isLocal: true);
    } catch (e) {
      print('The audio cannot be played because $e');
    }
  }

  Future<void> seek() async {}
}
