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
import 'package:safe_encrypt/screens/features/auth/components/pin_number/re_enter_pin_number.dart';
import 'package:safe_encrypt/screens/features/gallery/gallery_home.dart';

import '../../../services/new_account_image_services.dart';

import '../gallery/album_covers.dart';
import '../gallery/components/glalery_folder.dart';
import '../gallery/image_screen.dart';
import '../new_accounts/confirm_pin_number.dart';
import '../settings/settings.dart';
import 'new_account_loging.dart';

class NewAccountGalleryHome extends StatefulWidget {
  final String controler_pin;
  const NewAccountGalleryHome({Key? key, required this.controler_pin})
      : super(key: key);

  @override
  State<NewAccountGalleryHome> createState() => _NewAccountGalleryHomeState();
}

class _NewAccountGalleryHomeState extends State<NewAccountGalleryHome> {
  final TextEditingController _folderName = TextEditingController();
  List<FileSystemEntity> folderList = [];

  @override
  void initState() {
    requestPermission(Permission.storage);
    getFolderList();
    // Future.delayed(
    //   const Duration(seconds: 120),
    //   () {
    //     Navigator.push(
    //         context,
    //         MaterialPageRoute(
    //           builder: (context) => NewAccountLoging(),
    //         ));
    //   },
    // );
    super.initState();
  }

  @override
  void dispose() {
    _folderName.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        throw Navigator.push(
            context, MaterialPageRoute(builder: (_) => GalleryHome()));
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
                                style: TextStyle(color: kblack, fontSize: 17)),
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
                                style: TextStyle(color: kblack, fontSize: 17)),
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
                  accountEmail: Text(''
                      // user.email!

                      ),
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
                  Navigator.push(context,
                      MaterialPageRoute(builder: (_) => GalleryHome()));
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
                  ontap: () async => NewAccountImageService(
                          controler_pin: widget.controler_pin)
                      .importPhotos(),
                  icon: const Icon(Icons.photo),
                  color: const Color.fromRGBO(0, 0, 0, 0.38),
                  labelColor: Colors.white,
                  labelBackgroundColor: kliteblue),
              HawkFabMenuItem(
                label: 'Take photo',
                ontap: () async =>
                    NewAccountImageService(controler_pin: widget.controler_pin)
                        .takePhoto(),
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
                        image: Image.asset(
                            Provider.of<FolderCoverImageProvider>(context,
                                    listen: false)
                                .imgList[index],
                            fit: BoxFit.fill),
                        title: folderName,
                        album: 'Album Settings',
                        isDelete: index == 0 ? false : true,
                        path: folderList[index].path),
                    onTap: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (_) => 
                                ImageScreen(  title: folderName, path: folderList[index].path))),
                  );
                }),
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
                          await createFolder(_folderName.text);
                          await getFolderList();
                          setState(() {
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
    String foldername = widget.controler_pin;
    final Directory directory = Directory(
        "/storage/emulated/0/Android/data/com.example.safe_encrypt/files/file/$foldername");
    print(directory);
    print('kkkkk');
    print(directory);

    log(directory.toString());

    folderList = directory.listSync(followLinks: true);
    folderList.removeWhere((item) => item.runtimeType.toString() == '_File');
  }

  // creating folders
  Future<bool> createFolder(String newfolderName) async {
    String foldername = widget.controler_pin;
    final Directory _directory = Directory(
        '/storage/emulated/0/Android/data/com.example.safe_encrypt/files/file/$foldername');
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
              "/storage/emulated/0/Android/data/com.example.safe_encrypt/files/file/$foldername/$newfolderName";

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
              showCreateFolderDialog(context);
              debugPrint('Continue');
              setState(() {
                getFolderList();
                initState();
                requestPermission(Permission.storage);

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
}
