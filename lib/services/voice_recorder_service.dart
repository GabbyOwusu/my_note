// import 'dart:io';

// import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
// import 'package:my_note/models/Note.dart';
// import 'package:path_provider/path_provider.dart';

// class VoiceRecordingService {
//   Future<bool> haspermissions = FlutterAudioRecorder.hasPermissions;
//  late FlutterAudioRecorder recorder;

//   Future<String> getAudioPath(Note note) async {
//     Directory directory = await getApplicationDocumentsDirectory();
//     DateTime diff = DateTime.now();
//     String audiopath = directory.path + '/note-2-audio-$diff';
//     note.audioPath = audiopath;
//     return audiopath;
//   }

//   Future initRecording(Note n) async {
//     String dir = await getAudioPath(n);
//     recorder = FlutterAudioRecorder(dir, audioFormat: AudioFormat.AAC);
//     await recorder.initialized;
//   }

//   Future startRecording() async {
//     await recorder.start();
//   }

//   Future stopRecording() async {
//     await recorder.stop();
//   }

//   Future<void> record(Note note) async {
//     try {
//       if (await haspermissions) {
//         await initRecording(note);
//         print('Path here ${note.audioPath}');
//         await startRecording();
//       } else {
//         return;
//       }
//     } catch (e) {
//       print('>>>>>>>>>>>>>>>>>>>>>>>> Recording failed $e');
//     }
//   }
// }
