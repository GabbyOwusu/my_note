import 'dart:io';

import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:path_provider/path_provider.dart';

class AudioService {
  Future<bool> haspermissions = FlutterAudioRecorder.hasPermissions;

  Future<String> getPath() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String audiopath = directory.path;
    return audiopath;
  }

  FlutterAudioRecorder recorder;

  Future initRecording() async {
    String dir = await getPath();
    final diff = DateTime.now();
    recorder = FlutterAudioRecorder(dir + 'note-2-audi-$diff.mp4');
    await recorder.initialized;
  }

  Future startRecording() async {
    await recorder.start();
  }

  Future stopRecording() async {
    await recorder.stop();
  }

  Future<void> record() async {
    try {
      if (await haspermissions) {
        await initRecording();
        await startRecording();
      } else {
        return;
      }
    } catch (e) {
      print('>>>>>>>>>>>>>>>>>>>>>>>> Recording failed $e');
    }
  }
}
