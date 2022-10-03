import 'dart:developer';
import 'dart:io';

import 'package:file_cryptor/file_cryptor.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart' as path;

class FileService {
  final String pinNumber;

  FileService({required this.pinNumber});

  // getting the default folder for each folder types (real and fake)
  String getFolderPath() =>
      '/storage/emulated/0/Android/data/com.example.safe_encrypt/files/safe/app/new/$pinNumber/Main Album/';

  // importing files
  void importFiles() async {
    String fileName = '';
    String fileType = '';

    FilePickerResult? result =
        await FilePicker.platform.pickFiles(allowMultiple: true);

    if (result != null) {
      List<File> files = result.paths.map((path) => File(path!)).toList();

      for (File file in files) {
        fileType = path.extension(file.path);
        print(path.extension(file.path));
        fileName = path.basename(file.path);
        // '${DateTime.now().microsecondsSinceEpoch.toString()}$fileType';

        File fileToSave = File(file.path);
        fileToSave.copy('${getFolderPath()}$fileName');

        log(files.toString());

        await encryptFiles(fileName, '$fileName.aes', getFolderPath());
        delete('${getFolderPath()}$fileName');
      }
    } else {
      // User canceled the picker
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
