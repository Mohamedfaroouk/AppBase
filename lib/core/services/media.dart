import 'dart:io';
import 'dart:typed_data';

// import 'package:audioplayers/audioplayers.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_file_dialog/flutter_file_dialog.dart';

class MediaService {
  static final MediaService _instance = MediaService._internal();
  factory MediaService() => _instance;
  MediaService._internal();
  Future<File?> pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );
    if (result != null) {
      return File(result.files.first.path ?? "");
    }
    return null;
  }

  // playSound() async {
  //   // get sound
  //   if ((await AppPreferences.sharedPreferences.getBool("sound")) == false) {
  //     return;
  //   }
  //   AudioPlayer audioPlayer = AudioPlayer();

  //   await audioPlayer.play(AssetSource(
  //     "audio/scan.wav",
  //   ));
  //   audioPlayer.onPlayerComplete.listen((event) {
  //     audioPlayer.dispose();
  //   });
  // }

  static Future<bool> saveFile(File file) async {
    String? message;
    bool isError = false;

    try {
      // Ask the user to save it
      final params = SaveFileDialogParams(sourceFilePath: file.path);
      final finalPath = await FlutterFileDialog.saveFile(params: params);

      if (finalPath != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  static Future<bool> saveFileBytes(Uint8List file, String fileName) async {
    try {
      // Ask the user to save it
      final params = SaveFileDialogParams(data: file, fileName: fileName);
      final finalPath = await FlutterFileDialog.saveFile(params: params);

      if (finalPath != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e.toString());
      return false;
    }
  }
}
