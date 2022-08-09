import 'dart:developer';
import 'dart:io';

import 'package:file_cryptor/file_cryptor.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

class ImageService {
  final bool isFake;
  final ImagePicker _picker = ImagePicker();

  ImageService({this.isFake = false});

  // getting the default folder for each folder types (real and fake)
  String getFolderPath() {
    if (isFake) {
      return '/storage/emulated/0/Android/data/com.example.safe_encrypt/files/fakeFolder/Main Album/';
    } else {
      return '/storage/emulated/0/Android/data/com.example.safe_encrypt/files/folder/Main Album/';
    }
  }

  // importing photos to default folder
  importPhotos() async {
    String imageName = '';
    String fileType = '';

    final List<XFile>? imageList = await _picker.pickMultiImage();

    if (imageList != null) {
      for (XFile image in imageList) {
        fileType = path.extension(image.path);
        imageName =
            '${DateTime.now().microsecondsSinceEpoch.toString()}$fileType';

        File fileToSave = File(image.path);
        fileToSave.copy('${getFolderPath()}$imageName');

        await encryptFiles(imageName, '$imageName.aes', getFolderPath());
        delete('${getFolderPath()}$imageName');
      }
    }
  }

  // taking photos from camera to default folder
  takePhoto() async {
    String imageName = '';
    String fileType = '';

    final XFile? image = await _picker.pickImage(source: ImageSource.camera);

    if (image != null) {
      fileType = path.extension(image.path);
      imageName =
          '${DateTime.now().microsecondsSinceEpoch.toString()}$fileType';

      File fileToSave = File(image.path);
      fileToSave.copy('${getFolderPath()}$imageName');

      await encryptFiles(imageName, '$imageName.aes', getFolderPath());
      delete('${getFolderPath()}$imageName');
    }
  }

  Future<File> encryptFiles(
      String inputFileName, String outputFileName, String directory) async {
    FileCryptor fileCryptor = FileCryptor(
      key: 'Your 32 bit key.................',
      iv: 16,
      dir: directory,
    );

    return fileCryptor.encrypt(
        inputFile: inputFileName, outputFile: outputFileName);
  }

// deleting files
  void delete(String path) {
    log(path);
    final dir = Directory(path);
    dir.deleteSync(recursive: true);
  }
}
