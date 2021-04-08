import 'dart:io';

import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:path_provider/path_provider.dart';

class AudioService {
  Future<bool> haspermissions = FlutterAudioRecorder.hasPermissions;
  FlutterAudioRecorder recorder;

  Future<String> getAudioPath() async {
    Directory directory = await getApplicationDocumentsDirectory();
    DateTime diff = DateTime.now();
    String audiopath = directory.path + '/note-2-audi-$diff.mp4';
    return audiopath;
  }

  Future initRecording() async {
    String dir = await getAudioPath();
    recorder = FlutterAudioRecorder(dir);
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
