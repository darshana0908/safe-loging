import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:safe_encrypt/screens/features/gallery/album_settings.dart';
import '../../../../constants/colors.dart';

class PlatformAlbum extends StatefulWidget {
  final String title;
  final bool isDelete;
  final String path;
  final String album;
  final Image image;


  PlatformAlbum(
      {Key? key,
      required this.image,
      required this.title,
      required this.isDelete,
      required this.path,
      required this.album,
  })
      : super(key: key);

  @override
  State<PlatformAlbum> createState() => _PlatformAlbumState();
}

class _PlatformAlbumState extends State<PlatformAlbum> {
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
                                              delete(widget.path);

                                              await Navigator.pushNamed(
                                                  context, "Setting");
                                            },
                                          ).show();
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
                                              builder: (_) =>
                                                  const AlbumSettings()));
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

  // showAlertDialog(BuildContext context, String path) {
  //   // set up the buttons
  //   Widget cancelButton = TextButton(
  //     child: const Text("Cancel"),
  //     onPressed: () {
  //       Navigator.pop(context);
  //     },
  //   );
  //   Widget continueButton = TextButton(
  //     child: const Text("Yes"),
  //     onPressed: () {
  //       setState(() {
  //         delete(path);
  //         Navigator.pop(context, true);
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //               builder: (_) => const Home(),
  //             ));
  //       });
  //     },
  //   );

  //   // set up the AlertDialog
  //   AlertDialog alert = AlertDialog(
  //     title: const Text("Confirm"),
  //     content: const Text("Are you sure you want to move this album to Trash?"),
  //     actions: [cancelButton, continueButton],
  //   );

  //   // show the dialog
  //   showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return alert;
  //     },
  //   );
  // }

  void delete(String path) {
    final dir = Directory(path);

    dir.deleteSync(recursive: true);
  }
}
