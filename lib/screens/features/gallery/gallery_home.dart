import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:http/http.dart' as http;
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:image_picker/image_picker.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:safe_encrypt/constants/colors.dart';
import 'package:safe_encrypt/services/image_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../services/file_service.dart';
import '../../../utils/helper_methods.dart';
import '../auth/components/pin_number/user_pin.dart';
import '../new_accounts/confirm_pin_number.dart';
import '../new_accounts/new_account_loging.dart';
import '../new_accounts/new_account_pin_nuber.dart';
import '../settings/settings.dart';
import 'album_covers.dart';
import 'components/glalery_folder.dart';
import 'image_screen.dart';
import 'dart:convert' as convert;
import 'package:path/path.dart' as path;

class GalleryHome extends StatefulWidget {
  final String title = "Flutter Data Table";
  final bool isFake;
  final String pinnumber;
  const GalleryHome({Key? key, this.isFake = false, required this.pinnumber})
      : super(key: key);

  @override
  State<GalleryHome> createState() => _GalleryHomeState();
}

class _GalleryHomeState extends State<GalleryHome> {
  final TextEditingController _folderName = TextEditingController();
  List<FileSystemEntity> folderList = [];
  Timer? timer;
  var jsonResponse = convert.jsonDecode('{"data": []}') as Map<String, dynamic>;

  // User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    requestPermission(Permission.storage);
    getFolderList();
    loadig();
    print(widget.pinnumber);

    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    _folderName.dispose();

    super.dispose();
  }

  String? imgload = '';
  String? faldername = '';
  String _fileText = '';

  loadig() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    imgload = prefs.getString(
      'imgname',
    );
    faldername = prefs.getString('faldername');
    print(imgload);
    print(faldername);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: WillPopScope(
        onWillPop: () {
          exit(0);
        },
        child: Scaffold(
          floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 50),
            child: SpeedDial(
              buttonSize: Size(70.0, 70.0),
              childrenButtonSize: Size(55.0, 55.0),
              // animatedIcon:AnimatedIcons.add_event ,

              overlayColor: Color(0xff00aeed),
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
                  onTap: () async {
                    return ImageService(pinNumber: widget.pinnumber)
                        .takePhoto();
                  },
                  elevation: 150,
                  backgroundColor: Colors.black38,
                  child: Icon(Icons.camera_alt, color: kwhite, size: 30),
                  labelBackgroundColor: Color(0xff00aeed),
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
                    onTap: () async => ImageService(pinNumber: widget.pinnumber)
                        .importPhotos(),
                    backgroundColor: Colors.black38),
                SpeedDialChild(
                    child: Icon(Icons.photo, color: kwhite, size: 30),
                    labelWidget: Padding(
                      padding: const EdgeInsets.only(right: 20),
                      child: Text('Import all',
                          style: TextStyle(
                              color: kwhite,
                              fontSize: 22,
                              fontWeight: FontWeight.w500)),
                    ),
                    onTap: () async => FileService(pinNumber: widget.pinnumber).importFiles(),
                    backgroundColor: Colors.black38),
                SpeedDialChild(
                  child: Icon(Icons.add_to_photos_rounded,
                      color: kwhite, size: 30),
                  labelWidget: Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: Text('Add album',
                        style: TextStyle(
                            color: kwhite,
                            fontSize: 22,
                            fontWeight: FontWeight.w500)),
                  ),
                  elevation: 20,
                  backgroundColor: Colors.black38,
                  onTap: () async {
                    return showCreateFolderDialog(context);
                  },
                )
              ],
            ),
          ),
          appBar: AppBar(
            title: Text('Keepsafe'),
            // title: const Text('keepsafe'),
            backgroundColor: kdarkblue,
            // automaticallyImplyLeading: false,
            // leading: const Icon(Icons.account_circle),
            actions: <Widget>[
              IconButton(
                  icon: const Icon(Icons.delete, color: Colors.white54),
                  onPressed: () {}),
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
                              child: Text('Settings',
                                  style:
                                      TextStyle(color: kblack, fontSize: 17)),
                              onPressed: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const Settings())),
                            ),
                          ),
                          Container(
                            alignment: Alignment.topLeft,
                            child: TextButton(
                              autofocus: true,
                              child: Text('Help',
                                  style:
                                      TextStyle(color: kblack, fontSize: 17)),
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
          drawer: Drawer(
            child: ListView(
              padding: const EdgeInsets.all(0),
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(
                    color: kdarkblue,
                  ), //BoxDecoration
                  child: UserAccountsDrawerHeader(
                    decoration: BoxDecoration(color: kdarkblue),
                    accountName: Text(
                      '',
                      style: const TextStyle(fontSize: 18),
                    ),
                    accountEmail: Text(''),
                    currentAccountPictureSize: const Size.square(50),
                    currentAccountPicture: CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 165, 255, 137),
                      child: Text(
                        '',
                        style: TextStyle(fontSize: 30.0, color: Colors.blue),
                      ), //Text
                    ), //circleAvatar
                  ), //UserAccountDrawerHeader
                ), //DrawerHeader
                ListTile(
                  leading: const Icon(Icons.person),
                  title: const Text(' My Profile '),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.create),
                  title: const Text(' Create New profile'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NewAccountPin(),
                        ));
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.login),
                  title: const Text(' New profile Login'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const NewAccountLoging(),
                        ));
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.workspace_premium),
                  title: const Text(' Go Premium '),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.video_label),
                  title: const Text(' Saved Videos '),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.edit),
                  title: const Text(' Edit Profile '),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.logout),
                  title: const Text('Quite'),
                  onTap: () {
                    exit(0);
                  },
                ),
              ],
            ),
          ),
          body: GridView.builder(
              itemCount: folderList.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 4.0,
                  mainAxisSpacing: 4.0),
              itemBuilder: (BuildContext context, index) {
                String oneEntity = folderList[index].toString();
                String folderName =
                    oneEntity.split('/').last.replaceAll("'", '');

                return InkWell(
                  child: PlatformAlbum(
                    // selected image of folder cover
                    // use provider (FolderCoverImageProvider)
                    image: Image.asset(
                      'assets/Capture9.JPG',
                      fit: BoxFit.fill,
                    ),

                    title: folderName,
                    album: 'Album Settings',
                    isDelete: index == 0 ? false : true,
                    path: folderList[index].path,
                    pinnuber: widget.pinnumber,
                  ),
                  onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => ImageScreen(
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
                TextField(
                    controller: _folderName,
                    decoration: const InputDecoration(hintText: 'Folder name')),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                        onPressed: () => Navigator.pop(context, true),
                        child: const Text('CANCEL')),
                    TextButton(
                        onPressed: () async {
                          setState(() async {
                            createFolder(_folderName.text);
                            await getFolderList();
                            _folderName.clear();

                            Navigator.pop(context);
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
    final Directory directory = Directory(
        '/storage/emulated/0/Android/data/com.example.safe_encrypt/files/safe/app/new/${widget.pinnumber}');

    // log(directory.toString());

    folderList = directory.listSync(followLinks: true);
    folderList.removeWhere((item) => item.runtimeType.toString() == '_File');
  }

  // creating folders
  Future<bool> createFolder(String newfolderName) async {
    String foldername = _folderName.text;
    final Directory _directory = Directory(
        '/storage/emulated/0/Android/data/com.example.safe_encrypt/files/safe/app/new/${widget.pinnumber}');
    Directory? directory;

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

          newPath =
              "/storage/emulated/0/Android/data/com.example.safe_encrypt/files/safe/app/new/${widget.pinnumber}/$newfolderName";

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
        await directory.create(recursive: true).whenComplete(
          () {
            setState(() {
              getFolderList();
            });
          },
        );
      }
      if (await directory.exists().whenComplete(
        () {
          AwesomeDialog(
            context: context,
            animType: AnimType.LEFTSLIDE,
            headerAnimationLoop: false,
            dialogType: DialogType.SUCCES,
            showCloseIcon: true,
            title: 'Success',
            desc: '',
            btnOkOnPress: () {
              debugPrint('Continue');
              setState(() {
                getFolderList();
                initState();
                requestPermission(Permission.storage);
                getFolderList();
                Navigator.pop(context, true);
              });
            },
            btnOkIcon: Icons.check_circle,
            onDissmissCallback: (type) {
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
}
