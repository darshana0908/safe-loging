import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hawk_fab_menu/hawk_fab_menu.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:safe_encrypt/constants/colors.dart';
import 'package:safe_encrypt/services/image_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/helper_methods.dart';
import '../auth/components/pin_number/user_pin.dart';
import '../new_accounts/confirm_pin_number.dart';
import '../new_accounts/new_account_loging.dart';
import '../settings/settings.dart';
import 'album_covers.dart';
import 'components/glalery_folder.dart';
import 'image_screen.dart';

class GalleryHome extends StatefulWidget {
  final bool isFake;
  const GalleryHome({Key? key, this.isFake = false}) : super(key: key);

  @override
  State<GalleryHome> createState() => _GalleryHomeState();
}

class _GalleryHomeState extends State<GalleryHome> {
  final TextEditingController _folderName = TextEditingController();
  List<FileSystemEntity> folderList = [];
  Timer? timer;
  @override
  void initState() {
    _keepAlive(true);
    requestPermission(Permission.storage);
    getFolderList();
    loadig();
    print(imgload);
    // timer = Timer(
    //   const Duration(seconds: 20),
    //   () {
    //     /// Navigate to seconds screen when timer callback in executed
    //     Navigator.push(
    //       context,
    //       MaterialPageRoute(
    //         builder: (context) => UserPIn(),
    //       ),
    //     );
    //   },
    // );
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
      onTap: () {
        startKeepAlive();
      },
      child: WillPopScope(
        onWillPop: () {
          exit(0);
        },
        child: Scaffold(
          appBar: AppBar(
            // title: const Text('keepsafe'),
            backgroundColor: kdarkblue,
            // automaticallyImplyLeading: false,
            // leading: const Icon(Icons.account_circle),
            actions: <Widget>[
              IconButton(
                  icon: const Icon(Icons.delete, color: Colors.white54),
                  onPressed: () {}),
              IconButton(
                  icon: const Icon(Icons.cloud, color: Colors.white),
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
                      // user.displayName!.toString(),
                      style: const TextStyle(fontSize: 18),
                    ),
                    accountEmail: Text(''),
                    currentAccountPictureSize: const Size.square(50),
                    currentAccountPicture: const CircleAvatar(
                      backgroundColor: Color.fromARGB(255, 165, 255, 137),
                      child: Text(
                        "A",
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
                  leading: const Icon(Icons.book),
                  title: const Text(' Create New Account'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ConfirmPin(),
                        ));
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.book),
                  title: const Text(' New Account Loging'),
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
                  title: const Text('LogOut'),
                  onTap: () {
                    exit(0);
                  },
                ),
              ],
            ),
          ),
          body: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: HawkFabMenu(
              blur: 155.8,
              backgroundColor: kliteblue,
              openIcon: Icons.add,
              closeIcon: Icons.close,
              items: [
                HawkFabMenuItem(
                    label: 'Add album',
                    ontap: () async => showCreateFolderDialog(context),
                    icon: const Icon(Icons.add_to_photos_rounded),
                    color: Colors.black38,
                    labelColor: Colors.white,
                    labelBackgroundColor: kliteblue),
                HawkFabMenuItem(
                    label: 'Import photos',
                    ontap: () async =>
                        ImageService(isFake: widget.isFake).importPhotos(),
                    icon: const Icon(Icons.photo),
                    color: const Color.fromRGBO(0, 0, 0, 0.38),
                    labelColor: Colors.white,
                    labelBackgroundColor: kliteblue),
                HawkFabMenuItem(
                  label: 'Take photo',
                  ontap: () async =>
                      ImageService(isFake: widget.isFake).takePhoto(),
                  icon: const Icon(Icons.camera_alt),
                  color: Colors.black38,
                  labelColor: Colors.white,
                  labelBackgroundColor: kliteblue,
                ),
              ],
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
                          image: Image.asset('assets/Capture9.JPG',fit: BoxFit.fill,),

                          // Image.asset(
                          //     Provider.of<FolderCoverImageProvider>(context,
                          //             listen: false)
                          //         .imgList[index],
                          //     fit: BoxFit.fill),
                          title: folderName,
                          album: 'Album Settings',
                          isDelete: index == 0 ? false : true,
                          path: folderList[index].path),
                      onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) =>
                                  ImageScreen(path: folderList[index].path))),
                    );
                  }),
            ),
          ),
        ),
      ),
    );
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
        '/storage/emulated/0/Android/data/com.example.safe_encrypt/files/folder');

    // log(directory.toString());

    folderList = directory.listSync(followLinks: true);
    folderList.removeWhere((item) => item.runtimeType.toString() == '_File');
  }

  // creating folders
  Future<bool> createFolder(String newfolderName) async {
    String foldername = _folderName.text;
    final Directory _directory = Directory(
        '/storage/emulated/0/Android/data/com.example.safe_encrypt/files/$foldername');
    Directory? directory;
    // print(_directory);

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
              "/storage/emulated/0/Android/data/com.example.safe_encrypt/files/folder/$newfolderName";

          directory = Directory(newPath);
          log(directory.path);
          getFolderList();
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
              () {},
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
            title: 'Succes',
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
              debugPrint('Dialog Dissmiss from callback $type');
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

  void timeOutCallBack() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) {
        return UserPIn();
      }),
    );
  }
}

Timer? _keepAliveTimer;

const _inactivityTimeout = Duration(seconds: 10);
void _keepAlive(bool visible) {
  _keepAliveTimer?.cancel();
  if (visible) {
    _keepAliveTimer = null;
  } else {
    _keepAliveTimer = Timer(_inactivityTimeout, () => exit(0));
  }
}

class _KeepAliveObserver extends WidgetsBindingObserver {
  @override
  didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        _keepAlive(true);
        break;
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.detached:
        _keepAlive(false); // Conservatively set a timer on all three
        break;
    }
  }
}

/// Must be called only when app is visible, and exactly once
void startKeepAlive() {
  assert(_keepAliveTimer == null);
  _keepAlive(true);
  WidgetsBinding.instance.addObserver(_KeepAliveObserver());
}
