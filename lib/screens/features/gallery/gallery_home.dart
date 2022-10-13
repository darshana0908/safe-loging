import 'dart:async';
import 'dart:developer';

import 'dart:io';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:safe_encrypt/constants/colors.dart';
import 'package:safe_encrypt/services/icon.dart';
import 'package:safe_encrypt/utils/widgets/custom_drawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/helper_methods.dart';
import '../settings/settings.dart';
import 'components/glalery_folder.dart';
import 'image_screen.dart';
import 'dart:convert';

class GalleryHome extends StatefulWidget {
  final String title = "Flutter Data Table";
  final bool isFake;
  final String pinNumber;
  const GalleryHome({Key? key, this.isFake = false, required this.pinNumber}) : super(key: key);

  @override
  State<GalleryHome> createState() => _GalleryHomeState();
}

class _GalleryHomeState extends State<GalleryHome> with WidgetsBindingObserver {
  final TextEditingController _folderName = TextEditingController();
  List<FileSystemEntity> folderList = [];
  Timer? timer;
  var jsonResponse = jsonDecode('{"data": []}') as Map<String, dynamic>;
  bool takingPhoto = false;
  String newpath = '';
  List<String> myfile = [];
  String? imageName;
  String finalImage = 'assets/ic.JPG';
  String assets = 'assets/ic.JPG';
  getbool() {
    setState(() {
      takingPhoto = true;
    });
  }

  @override
  void initState() {
    // takingPhoto == true ?
    WidgetsBinding.instance.addObserver(this);
    // : WidgetsBinding.instance.removeObserver(this);
    requestPermission(Permission.storage);
    takingPhoto = false;
    getFolderList();

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    _folderName.dispose();

    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
  }

  @override
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('$state  $takingPhoto');
    if (state == AppLifecycleState.resumed) {
      if (takingPhoto) {
        setState(() {
          takingPhoto = false;
        });
      } else {
        setState(() {
          takingPhoto = false;
        });
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_) => const AppIcon()), (Route<dynamic> route) => false);
      }
    }
  }

  String? imgload = '';
  String? faldername = '';

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return true;
        },
        child: Scaffold(
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: SpeedDial(
              buttonSize: const Size(70.0, 70.0),
              childrenButtonSize: const Size(55.0, 55.0),
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
                // SpeedDialChild(
                //   labelWidget: Padding(
                //     padding: const EdgeInsets.only(right: 20),
                //     child: Text(
                //       'Take photo',
                //       style: TextStyle(color: kwhite, fontSize: 22, fontWeight: FontWeight.w500),
                //     ),
                //   ),
                //   onTap: () async {
                //     setState(() => takingPhoto = true);
                //     ImageService(pinNumber: widget.pinNumber).takePhoto();
                //     // .then((val) {
                //     //   setState(() => takingPhoto = false);
                //     // });
                //   },
                //   elevation: 150,
                //   backgroundColor: Colors.black38,
                //   child: Icon(Icons.camera_alt, color: kwhite, size: 30),
                //   labelBackgroundColor: const Color(0xff00aeed),
                // ),
                // SpeedDialChild(
                //     child: Icon(Icons.photo, color: kwhite, size: 30),
                //     labelWidget: Padding(
                //       padding: const EdgeInsets.only(right: 20),
                //       child: Text('Import files', style: TextStyle(color: kwhite, fontSize: 22, fontWeight: FontWeight.w500)),
                //     ),
                //     onTap: () async {
                //       setState(() {
                //         takingPhoto = true;
                //       });
                //       String extention = '';
                //       FileService(pinNumber: widget.pinNumber).importFiles();
                //       // .then((val) {
                //       //   setState(() {
                //       //     takingPhoto = false;
                //       //   });
                //       // });
                //     },
                //     backgroundColor: Colors.black38),
                SpeedDialChild(
                  child: Icon(Icons.add_to_photos_rounded, color: kwhite, size: 30),
                  labelWidget: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text('Add album', style: TextStyle(color: kwhite, fontSize: 22, fontWeight: FontWeight.w500)),
                  ),
                  elevation: 20,
                  backgroundColor: Colors.black38,
                  onTap: () async => showCreateFolderDialog(context),
                )
              ],
            ),
          ),
          appBar: AppBar(
            backgroundColor: kdarkblue,
            title: const Text('Keepsafe'),
            // backgroundColor: kdarkblue,
            actions: <Widget>[
              PopupMenuButton(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width / 2,
                      child: Column(
                        children: [
                          Container(
                            alignment: Alignment.topLeft,
                            child: TextButton(
                              autofocus: true,
                              child: Text('Settings', style: TextStyle(color: kblack, fontSize: 17)),
                              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const Settings())),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: TextButton(
                              autofocus: true,
                              child: Text('Help', style: TextStyle(color: kblack, fontSize: 17)),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          drawer: CustomDrawer(
            pinNumber: widget.pinNumber,
            takinphoto: takingPhoto,
            getbool: getbool,
          ),
          body: GridView.builder(
              itemCount: folderList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, crossAxisSpacing: 4.0, mainAxisSpacing: 4.0),
              itemBuilder: (BuildContext context, index) {
                String oneEntity = folderList[index].toString();
                String folderName = oneEntity.split('/').last.replaceAll("'", '');
                print(folderName);
                return InkWell(
                  child: PlatformAlbum(
                    // selected image of folder cover
                    // use provider (FolderCoverImageProvider)
                    title: folderName,
                    album: 'Album Settings',
                    isDelete: index == 0 ? false : true,
                    path: folderList[index].path,
                    pinnuber: widget.pinNumber,
                  ),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ImageScreen(
                                getbool: getbool,
                                title: folderName,
                                path: folderList[index].path,
                              ))),
                );
              }),
        ),
      ),
    );

    // );  ),
  }

  // openFiles(List<PlatformFile> files) =>
  //     Navigator.push(context, MaterialPageRoute(builder: (_) => FilePage()));

  // create folder dialog
  showCreateFolderDialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              width: double.infinity,
              height: 250,
              padding: const EdgeInsets.all(20),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                TextField(controller: _folderName, decoration: const InputDecoration(hintText: 'Folder name')),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('CANCEL')),
                    TextButton(
                        onPressed: () async {
                          setState(() async {
                            createFolder(_folderName.text);
                            await getFolderList();
                            _folderName.clear();
                          });
                        },
                        child: const Text('CREATE')),
                  ],
                )
              ]),
            ),
          );
        });
  }

  // load app folders
  getFolderList() async {
    final Directory directoryi = Directory('/storage/emulated/0/Android/data/com.example.safe_encrypt/files/safe/app/new/${widget.pinNumber}');

    // log(directory.toString());

    folderList = directoryi.listSync(followLinks: true);
    folderList.removeWhere((item) => item.runtimeType.toString() == '_File');
    setState(() {
      log(imageName.toString());
      finalImage = imageName.toString();
    });
  }

  // creating folders
  Future<bool> createFolder(String newFolderName) async {
    Directory? directory = Directory('/storage/emulated/0/Android/data/com.example.safe_encrypt/files/safe/app/new/${widget.pinNumber}');

    try {
      if (Platform.isAndroid) {
        if (await requestPermission(Permission.storage)) {
          directory = await getExternalStorageDirectory();
          log(directory!.path);

          String newPath = '';
          List<String> folders = directory.path.split("/");

          for (int i = 1; i < folders.length; i++) {
            String folder = folders[i];
            newPath += "/$folder";
          }

          newPath = "/storage/emulated/0/Android/data/com.example.safe_encrypt/files/safe/app/new/${widget.pinNumber}/$newFolderName";

          directory = Directory(newPath);
          log(directory.path);
        } else {
          return false;
        }
      } else {
        if (await requestPermission(Permission.photos)) {
          directory = await getTemporaryDirectory();
        } else {
          return false;
        }
      }

      if (!await directory.exists()) {
        await directory.create(recursive: true);
      }
      if (await directory.exists().whenComplete(
        () async {
          SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
          await sharedPreferences.setString('foldername-$newFolderName-${widget.pinNumber}', assets);
          AwesomeDialog(
            context: context,
            animType: AnimType.LEFTSLIDE,
            headerAnimationLoop: false,
            dialogType: DialogType.SUCCES,
            showCloseIcon: true,
            title: 'Success',
            desc: '',
            btnOkOnPress: () async {
              debugPrint('Continue');

              setState(() {
                getFolderList();

                requestPermission(Permission.storage);

                Navigator.pop(context, true);
              });
            },
            btnOkIcon: Icons.check_circle,
            onDismissCallback: (type) async {
              debugPrint('Dialog Dismiss from callback $type');
            },
          ).show();
        },
      )) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log(e.toString());
    }
    return false;
  }

  String getFolderPath() {
    return '/storage/emulated/0/Android/data/com.example.safe_encrypt/files/safe/app/new/${widget.pinNumber}/';
  }

// Cam-IMG 1664964306767412.jpg
  void delete(String path) {
    takingPhoto = false;
    print(takingPhoto);
    log(path);
    final dir = Directory(path);
    dir.deleteSync(recursive: true);
  }
}
