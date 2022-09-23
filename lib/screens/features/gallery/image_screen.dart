import 'dart:developer';
import 'dart:io';

import 'package:file_cryptor/file_cryptor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;

import '../../../services/image_service.dart';
import '../../../constants/colors.dart';
import 'image_details.dart';

class ImageScreen extends StatefulWidget {
  final String path;
  final String title;
  const ImageScreen({Key? key, required this.path, required this.title})
      : super(key: key);

  @override
  State<ImageScreen> createState() => _ImageScreenState();
}

class _ImageScreenState extends State<ImageScreen> {
  String imageName = '';
  String fileType = '';
  bool _isLoading = false;

  int x = 1;

  int size = 5;
  final ImagePicker _picker = ImagePicker();
  List<String> decryptedImages = [];
  int _countOfReload = 0;
  bool imgload = false;

  @override
  void initState() {
    decryptImages();
    setState(() {
      loadPhotos();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          deleteDecryptedImages(decryptedImages);
          return true;
        },
        child: SafeArea(
          child: Scaffold(
            floatingActionButton: Padding(
              padding: const EdgeInsets.only(bottom: 50),
              child: SpeedDial(
                buttonSize: const Size(70.0, 70.0),
                childrenButtonSize: const Size(55.0, 55.0),
                animatedIcon: AnimatedIcons.add_event,
                overlayColor: const Color(0xff00aeed),
                overlayOpacity: 1.0,
                activeIcon: Icons.close,
                foregroundColor: kwhite,
                activeForegroundColor: kblack,
                backgroundColor: kblue,
                activeBackgroundColor: kwhite,
                spacing: 20,
                spaceBetweenChildren: 15,
                icon: Icons.add,
                children: [
                  SpeedDialChild(
                    labelWidget: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text(
                        'Take photo',
                        style: TextStyle(
                            color: kwhite,
                            fontSize: 22,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    onTap: () async => takePhoto(),
                    elevation: 150,
                    backgroundColor: Colors.black38,
                    child: Icon(Icons.camera_alt, color: kwhite, size: 30),
                    labelBackgroundColor: const Color(0xff00aeed),
                  ),
                  SpeedDialChild(
                      child: Icon(Icons.photo, color: kwhite, size: 30),
                      labelWidget: Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Text('Import photos',
                            style: TextStyle(
                                color: kwhite,
                                fontSize: 22,
                                fontWeight: FontWeight.w500)),
                      ),
                      onTap: () async => importPhotos(),
                      backgroundColor: Colors.black38),
                ],
              ),
            ),
            backgroundColor: kwhite,
            body: CustomScrollView(
              physics: const PageScrollPhysics(),
              scrollBehavior: const ScrollBehavior(),
              slivers: [
                SliverAppBar(
                  backgroundColor: kdarkblue,
                  actions: [
                    IconButton(
                      icon: Icon(x == 1
                          ? Icons.view_list
                          : x == 2
                              ? Icons.view_module
                              : Icons.view_comfortable),
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        setState(() {
                          if (x == 1) {
                            setState(() {
                              x = 2;
                            });
                          } else if (x == 2) {
                            x = 3;
                          } else {
                            x = 1;
                          }
                        });
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () {},
                    ),
                  ],
                  flexibleSpace: FlexibleSpaceBar(
                      title: SizedBox(
                        width: 250,
                        height: 50,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.title),
                            Text(
                              '${decryptedImages.length.toString()} Photos',
                              style: TextStyle(color: kgray, fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                      background: imgload
                          ? Image.file(
                              File(
                                decryptedImages.last,
                              ),
                              fit: BoxFit.cover,
                            )
                          : Image.asset(
                              'assets/Capture5.JPG',
                              fit: BoxFit.cover,
                            )

                      // Image.asset(
                      //   '${widget.path}/$imageName',
                      //   fit: BoxFit.fill,
                      // ),
                      ),
                  floating: false,
                  pinned: true,
                  expandedHeight: MediaQuery.of(context).size.height * 0.305,
                ),
                SliverList(
                    delegate: SliverChildListDelegate([
                  SizedBox(
                    height: 800,
                    child: _isLoading
                        ? const Center(
                            child: CupertinoActivityIndicator(
                              radius: 55,
                              color: Colors.red,
                            ),
                          )
                        : loadPhotos(),
                  ),
                ]))
              ],
            ),
            // Positioned(
            //   child: SizedBox(
            //     height: double.infinity,
            //     width: double.infinity,
            //     child: HawkFabMenu(
            //       blur: 155.8,
            //       backgroundColor: kliteblue,
            //       openIcon: Icons.add,
            //       closeIcon: Icons.close,
            //       items: [
            //         HawkFabMenuItem(
            //             label: 'Import photos',
            //             ontap: () async => importPhotos(),
            //             icon: const Icon(Icons.photo),
            //             color: const Color.fromRGBO(0, 0, 0, 0.38),
            //             labelColor: Colors.white,
            //             labelBackgroundColor: kliteblue),
            //         HawkFabMenuItem(
            //           label: 'Take photo',
            //           ontap: () async => takePhoto(),
            //           icon: const Icon(Icons.camera_alt),
            //           color: Colors.black38,
            //           labelColor: Colors.white,
            //           labelBackgroundColor: kliteblue,
            //         ),
            //       ],
            //       body: const SizedBox(
            //           // child: _isLoading
            //           // ? const Center(
            //           //     child: CircularProgressIndicator())
            //           // : loadPhotos()),
            //           ),
            //     ),
            //   ),
            // ),
          ),
        ));
  }

  // loading all photos in the folder
  loadPhotos() {
    if (decryptedImages.isNotEmpty) {
      return Container(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              mainAxisSpacing: 10,
              childAspectRatio: x == 1
                  ? 1
                  : x == 2
                      ? 1
                      : 4,
              crossAxisCount: x == 1
                  ? 2
                  : x == 2
                      ? 4
                      : 1),
          padding: const EdgeInsets.all(0.8),
          itemCount: decryptedImages.length,
          itemBuilder: (context, index) {
            String imgPath = decryptedImages[index];

            String imgname = imgPath.split('/').last.replaceAll("'", '');

            print(imgPath);
            return GestureDetector(
                onDoubleTap: () => delete(imgPath),
                onTap: () =>
                    Navigator.push(context, MaterialPageRoute(builder: (_) {
                      return ImageDetails(path: imgPath);
                    })),
                child: x == 1
                    ? Card(
                        elevation: 8.0,
                        child: Hero(
                            tag: imgPath,
                            child: Image.file(
                              File(imgPath),
                              fit: BoxFit.cover,
                            )))
                    : x == 2
                        ? Card(
                            elevation: 8.0,
                            child: Hero(
                                tag: imgPath,
                                child: Image.file(
                                  File(imgPath),
                                  fit: BoxFit.cover,
                                )))
                        : SizedBox(
                            height: 100,
                            child: Card(
                              child: Hero(
                                  tag: imgPath,
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 150,
                                          height: 200,
                                          child: Image.file(
                                            File(imgPath),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Text(imgname)
                                      ],
                                    ),
                                  )),
                            ),
                          ));
          },
        ),
      );
    } else {
      return Padding(
        padding: const EdgeInsets.only(top: 150),
        child: Center(
          child: Column(
            children: [
              Center(
                  child: Icon(Icons.photo_library_rounded,
                      size: 50, color: Colors.grey[400])),
              const SizedBox(height: 50),
              Text("This album is empty.",
                  style: TextStyle(fontSize: 18.0, color: Colors.grey[500])),
            ],
          ),
        ),
      );
    }
  }

  // import photos inside the folder
  importPhotos() async {
    log(widget.path);
    print(imageName);
    final List<XFile>? imageList = await _picker.pickMultiImage();

    if (imageList != null) {
      for (XFile image in imageList) {
        fileType = path.extension(image.path);
        imageName =
            '''IMG-${DateTime.now().microsecondsSinceEpoch.toString()}$fileType\nCreated-${DateTime.now().toString()}''';

        File fileToSave = File(image.path);
        fileToSave.copy('${widget.path}/$imageName');

        ImageService().encryptFiles(imageName, '$imageName.aes', widget.path);
        setState(
          () {
            decryptedImages.add('${widget.path}/$imageName');
          },
        );
      }
    }
  }

  // take photos inside the folder
  takePhoto() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.camera);
    print(imageName);
    if (image != null) {
      fileType = path.extension(image.path);
      imageName =
          '''IMG-${DateTime.now().microsecondsSinceEpoch.toString()}$fileType\nCreated-${DateTime.now()}''';

      File fileToSave = File(image.path);
      fileToSave.copy('${widget.path}/$imageName');

      ImageService().encryptFiles(imageName, '$imageName.aes', widget.path);
      setState(() => decryptedImages.add('${widget.path}/$imageName'));
    }
  }

  // decrypt images when opening folder
  void decryptImages() async {
    setState(() => _isLoading = true);

    FileCryptor fileCryptor = FileCryptor(
        key: 'Your 32 bit key.................', iv: 16, dir: widget.path);
    String currentDirectory = fileCryptor.getCurrentDir();
    String imageName;
    String outputName;

    Directory openedFolder = Directory(widget.path);
    List<String> encryptedImages = openedFolder
        .listSync()
        .map((item) => item.path)
        .where((item) => item.endsWith(".aes"))
        .toList(growable: true);

    if (encryptedImages.isNotEmpty) {
      for (var image in encryptedImages) {
        imageName = image.replaceAll('$currentDirectory/', '');
        outputName = imageName.replaceAll('.aes', '');
        File decryptedFile = await fileCryptor.decrypt(
            inputFile: imageName, outputFile: outputName);
        decryptedImages.add(decryptedFile.path);
      }

      setState(() {
        imgload = true;
        _isLoading = false;
      });
    } else {
      setState(() => _isLoading = false);
    }
  }

  // delete decrypted images when closing folder (going back)
  void deleteDecryptedImages(List<String> decryptedFiles) async {
    if (decryptedFiles.isNotEmpty) {
      for (var image in decryptedFiles) {
        final dir = Directory(image);
        dir.deleteSync(recursive: true);
      }
    }
  }

  // delete single file (both decrypted and encrypted versions)
  void delete(String path) {
    final decryptedDir = Directory(path);
    final encryptedDir = Directory('$path.aes');
    setState(() {
      decryptedImages.remove(path);
      decryptedDir.deleteSync(recursive: true);
      encryptedDir.deleteSync(recursive: true);
    });
  }

  @override
  void autoReload() {
    setState(() {
      _countOfReload = _countOfReload + 1;
    });
  }
}

class imgload extends ChangeNotifier {
  String decryptedImages = '';
  String get getecryptedImages => decryptedImages;
  img() {
    Image.file(
      File(decryptedImages.length.toString()),
      fit: BoxFit.fill,
    );
  }
}
