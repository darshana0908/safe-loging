import 'dart:developer';

import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:safe_encrypt/screens/features/gallery/album_settings.dart';
import 'package:safe_encrypt/screens/features/gallery/gallery_home.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../constants/colors.dart';

class PlatformAlbum extends StatefulWidget {
  final String title;
  final bool isDelete;
  final String path;
  final String album;
  final Function getRenameFolderlist;
  final String pinnuber;

  const PlatformAlbum({
    Key? key,
    required this.getRenameFolderlist,
    required this.title,
    required this.isDelete,
    required this.path,
    required this.album,
    required this.pinnuber,
  }) : super(key: key);

  @override
  State<PlatformAlbum> createState() => _PlatformAlbumState();
}

class _PlatformAlbumState extends State<PlatformAlbum> {
  String? imageName;
  String finalImage = '';
  String? assetsName;
  String finalAssets = '';

  bool isImageLoading = true;

  @override
  void initState() {
    widget.title;
    loadImage();
    setState(() {});

    // loadImage();
    // TODO: implement initState
    super.initState();
  }

  gettitel() {
    setState(() {
      widget.title;
    });
  }

  loadImage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();

    var imageName = sharedPreferences.getString('foldername-${widget.title}-${widget.pinnuber}');

    setState(() {
      finalImage = imageName.toString();
      log(finalImage);
      isImageLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        child: Container(
          // color: kwhite,
          width: MediaQuery.of(context).size.width / 2 - 16,
          height: 230,
          decoration: const BoxDecoration(),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width / 2 - 16,
                height: 180,
                color: kindigo,
                child: isImageLoading ? const CupertinoActivityIndicator() : Image.asset(finalImage, fit: BoxFit.fill),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    PopupMenuButton(
                      position: PopupMenuPosition.under,
                      splashRadius: 20,
                      itemBuilder: (context) => [
                        PopupMenuItem(
                        
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width / 2,
                            child: Column(
                              children: [
                                Visibility(
                                  visible: widget.isDelete,
                                  child: Container(
                                    alignment: Alignment.topLeft,
                                    child: TextButton(
                                        style: const ButtonStyle(),
                                        autofocus: true,
                                        child: const Text('Delete', style: TextStyle(fontSize: 17)),
                                        onPressed: () {
                                          // setState(() {
                                          //   delete(widget.path);
                                          // });
                                          AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.WARNING,
                                              headerAnimationLoop: false,
                                              animType: AnimType.TOPSLIDE,
                                              showCloseIcon: true,
                                              closeIcon: const Icon(Icons.close_fullscreen_outlined),
                                              title: 'Warning',
                                              desc: 'Are you sure want to delete folder',
                                              btnCancelOnPress: () {},
                                              onDismissCallback: (type) {
                                                debugPrint('Dialog Dissmiss from callback $type');
                                              },
                                              btnOkOnPress: () async {
                                                String key = '';
                                                setState(() {
                                                  log(imageName.toString());
                                                  finalImage = imageName.toString();
                                                  delete(widget.path);
                                                  print(widget.pinnuber);
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (_) => GalleryHome(
                                                                pinNumber: widget.pinnuber,
                                                              )));
                                                });
                                              }).show();

                                          // showcoAlertDialog(context, widget.path);
                                        }),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: TextButton(
                                    autofocus: true,
                                    child: Text(
                                      widget.album,
                                      style: const TextStyle(fontSize: 17),
                                    ),
                                    onPressed: () async {
                                      bool result = await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => AlbumSettings(
                                                    getRenameFolderlist: widget.getRenameFolderlist,
                                                    foldernames: widget.title,
                                                    path: widget.path,
                                                    pin: widget.pinnuber,
                                                    isDelete: widget.isDelete,
                                                  )));
                                      if (result) loadImage();
                                    },
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
              )
            ],
          ),
        ),
      ),
    );
  }

  Future changeFileNameOnly(File file, String newFileName) {
    var path = widget.path;
    var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    var newPath = path.substring(0, lastSeparator + 1) + newFileName;
    return file.rename(newPath);
  }

  void delete(String path) {
    setState(() {
      final dir = Directory(path);
      dir.deleteSync(recursive: true);
    });
  }
}
