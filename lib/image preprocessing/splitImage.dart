// ignore_for_file: file_names

import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:image/image.dart' as img_lib;
import 'package:flutter/services.dart' show rootBundle;
import 'package:path_provider/path_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  _splitImage('assets/images/tester.jpg', 4);
}

Future<void> _splitImage(String originalImagePath, int size) async {
  // extract the Image from the path
  img_lib.Image? image;

  ByteData byteData = await rootBundle.load(originalImagePath);
  Uint8List bytes = byteData.buffer.asUint8List();
  image = img_lib.decodeImage(bytes);
  // Uint8List bytes = await _readFileByte(originalImagePath);
  // image = img_lib.decodeImage(bytes);

  int x = 0, y = 0;
  int width = ((image?.width)! / size).round();
  int height = ((image?.height)! / size).round();

  // split image to parts
  List<img_lib.Image> parts = [];
  for (int i = 0; i < size; i++) {
    for (int j = 0; j < size; j++) {
      parts.add(img_lib.copyCrop(image!, x, y, width, height));
      x += width;
    }
    x = 0;
    y += height;
  }

  // extract the names from the path
  String originalImageName = (originalImagePath.split('/').last);
  String folderName = (originalImageName.split('.').first);

  // create a directory for the images
  String folderPath = await _createDir(folderName);

  // write the images to the corresponding output files
  for (int i = 0; i < parts.length; i++) {
    File('$folderPath/${i.toString()}.jpg')
        .writeAsBytesSync(img_lib.encodeJpg(parts[i]));
    // print("adding file: $folderPath/${i.toString()}.jpg");
  }
}

Future<String> _createDir(String folderName) async {
  // final io.Directory? _appDocDir = await getExternalStorageDirectory();
  final Directory _appDocDir = await getApplicationDocumentsDirectory();
  final Directory dirFolder = Directory(
      '${_appDocDir.path}/Github/eco_slide_puzzle/assets/images/$folderName');
  // print(dirFolder.path);
  bool directoryExists = await dirFolder.exists();
  if (directoryExists) {
    // empty the directory
    // print("directory exists");
    dirFolder.deleteSync(recursive: true);
    // print("directory deleted");
  } else {
    // print("directory does not exist");
  }
  // create the directory
  final Directory newFolder = await dirFolder.create(recursive: true);
  // print("directory created");

  return newFolder.path;
  //}
}
