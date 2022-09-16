import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:safe_encrypt/screens/features/gallery/album_settings.dart';
import 'package:safe_encrypt/screens/features/gallery/gallery_home.dart';
import '../../../../constants/colors.dart';

class PlatformAlbum extends StatefulWidget {
  final String title;
  final bool isDelete;
  final String path;
  final String album;
  final Image image;

  const PlatformAlbum({
    Key? key,
    required this.image,
    required this.title,
    required this.isDelete,
    required this.path,
    required this.album,
  }) : super(key: key);

  @override
  State<PlatformAlbum> createState() => _PlatformAlbumState();
}

class _PlatformAlbumState extends State<PlatformAlbum> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
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
                child: widget.image,
                // child: Consumer<FolderCoverImageProvider>(
                //   builder: (context, value, child) {
                //     return value;
                //     );
                //   },
                // ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                          fontSize: 17, fontWeight: FontWeight.w500),
                    ),
                    PopupMenuButton(
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
                                        autofocus: true,
                                        child: Text('Delete',
                                            style: TextStyle(
                                                color: kblack, fontSize: 17)),
                                        onPressed: () {
                                          setState(() {
                                            delete(widget.path);
                                          });
                                          AwesomeDialog(
                                              context: context,
                                              dialogType: DialogType.WARNING,
                                              headerAnimationLoop: false,
                                              animType: AnimType.TOPSLIDE,
                                              showCloseIcon: true,
                                              closeIcon: const Icon(Icons
                                                  .close_fullscreen_outlined),
                                              title: 'Warning',
                                              desc:
                                                  'Are you sure want to delete folder',
                                              btnCancelOnPress: () {},
                                              onDissmissCallback: (type) {
                                                debugPrint(
                                                    'Dialog Dissmiss from callback $type');
                                              },
                                              btnOkOnPress: () async {
                                                setState(() {
                                                  delete(widget.path);

                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (_) =>
                                                              const GalleryHome()));
                                                });
                                              }).show();
                                          // showAlertDialog(context, widget.path);
                                        }),
                                  ),
                                ),
                                Container(
                                  alignment: Alignment.topLeft,
                                  child: TextButton(
                                    autofocus: true,
                                    child: Text(
                                      widget.album,
                                      style: TextStyle(
                                          color: kblack, fontSize: 17),
                                    ),
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (_) => AlbumSettings(
                                                    foldernames: widget.title,
                                                  )));
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

  void delete(String path) {
    setState(() {
      final dir = Directory(path);
      dir.deleteSync(recursive: true);
    });
  }
}
