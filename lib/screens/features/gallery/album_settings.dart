import 'dart:developer';
import 'dart:io';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:safe_encrypt/constants/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'album_covers.dart';
import 'gallery_home.dart';

class AlbumSettings extends StatefulWidget {
  const AlbumSettings({Key? key, required this.foldernames, required this.path, required this.pin, required this.isDelete}) : super(key: key);
  final String foldernames;
  final String path;
  final String pin;
  final bool isDelete;

  @override
  State<AlbumSettings> createState() => _AlbumSettingsState();
}

class _AlbumSettingsState extends State<AlbumSettings> {
  String? imageName;
  String finalImage = '';
  String assets = 'assets/ic.JPG';
  final TextEditingController controler = TextEditingController();
  @override
  void initState() {
    final String foldernames;
    loadImage();

    log(imageName.toString());
    finalImage = imageName.toString();
    // TODO: implement initState
    super.initState();
  }

  loadImage() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var imageName = sharedPreferences.getString('foldername-${widget.foldernames}-${widget.pin}');
    print(widget.foldernames);
    setState(() {
      log(imageName.toString());
      finalImage = imageName.toString();
    });
    // return Image.file(File(imageName.toString()));
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          // backgroundColor: kdarkblue,
          title: const Text('Album settings'),
          backgroundColor: kdarkblue,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'General',
                  style: TextStyle(color: kblue, fontSize: 20),
                ),
              ),
              widget.isDelete
                  ? InkWell(
                      onTap: () {
                        showrenameFolderDialog(context);
                      },
                      child: Card(
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width,
                          height: 150,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Name',
                                  style: TextStyle(color: kblack, fontSize: 19, fontWeight: FontWeight.w500),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  child: Text(
                                    widget.foldernames,
                                    style: TextStyle(fontSize: 17, color: kgray, fontWeight: FontWeight.w500),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  : Card(
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: 150,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name',
                                style: TextStyle(color: kblack, fontSize: 19, fontWeight: FontWeight.w500),
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 10),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.foldernames,
                                      style: TextStyle(fontSize: 17, color: kgray, fontWeight: FontWeight.w500),
                                    ),
                                    Icon(
                                      Icons.lock,
                                      color: kgray,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
              const SizedBox(
                height: 50,
              ),
              Divider(
                color: kblack,
              ),
              const SizedBox(
                height: 50,
              ),
              InkWell(
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Album Cover',
                              style: TextStyle(color: kblack, fontSize: 19, fontWeight: FontWeight.w500),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Text(
                                'Custom',
                                style: TextStyle(fontSize: 17, color: kgray, fontWeight: FontWeight.w500),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 200,
                          height: 150,
                          child: Image.asset(
                            finalImage,
                            fit: BoxFit.fill,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => AlbumCovers(
                                pin: widget.pin,
                                path: widget.path,
                                foldersname: widget.foldernames,
                              )));
                },
              ),
              const SizedBox(
                height: 20,
              ),
              Divider(
                color: kblack,
              ),
            ]),
          ),
        ),
      ),
    );
  }

  showrenameFolderDialog(context) {
    showDialog(
        context: context,
        builder: (context) {
          return Dialog(
            child: Container(
              width: double.infinity,
              height: 250,
              padding: const EdgeInsets.all(20),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                TextField(controller: controler, decoration: const InputDecoration(hintText: 'Folder name')),
                const SizedBox(height: 40),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('CANCEL')),
                    TextButton(
                        onPressed: () async {
                          print(widget.foldernames);
                          setState(() {
                            var myfile = Directory(widget.path);
                            changeFileNameOnly(myfile, controler.text);
                          });

                          AwesomeDialog(
                            context: context,
                            animType: AnimType.LEFTSLIDE,
                            headerAnimationLoop: false,
                            dialogType: DialogType.SUCCES,
                            showCloseIcon: true,
                            title: 'Success',
                            desc: '',
                            btnOkText: 'Add Album Cover',
                            btnOkOnPress: () async {
                              debugPrint('Continue');

                              print('kkkkkkkkkkkkkk');
                              print(widget.foldernames);
                              print('kkkkkkkkkkkkkk');
                              await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) => GalleryHome(
                                            pinNumber: widget.pin,
                                          )));
                            },
                            btnOkIcon: Icons.check_circle,
                            onDismissCallback: (type) async {
                              debugPrint('Dialog Dismiss from callback $type');
                            },
                          ).show();
                        },
                        child: const Text('CREATE')),
                  ],
                )
              ]),
            ),
          );
          // showrenameFolderDialog(context) {
          //   showDialog(
          //       context: context,
          //       builder: (context) {
          //         return Dialog(
          //           child: Center(
          //             child: Container(
          //               width: double.infinity,
          //               height: 200,
          //               padding: const EdgeInsets.all(210),
          //               child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisSize: MainAxisSize.min, children: [
          //                 TextField(controller: controler, decoration: const InputDecoration(hintText: 'Folder name')),
          //                 const SizedBox(height: 40),
          //         Row(
          //           mainAxisAlignment: MainAxisAlignment.end,
          //           children: [
          //             TextButton(onPressed: () => Navigator.pop(context, true), child: const Text('CANCEL')),
          //             TextButton(
          //                 onPressed: () async {
          //                   var myfile = Directory(widget.path);
          //                   changeFileNameOnly(myfile, controler.text);
          //                 },
          //                 child: const Text('CREATE')),
          //           ],
          //         )
          //       ]),
          //     ),
          //   ),
          // );
        });
  }

  Future changeFileNameOnly(myfile, newFileName) async {
    var path = myfile.path;

    var lastSeparator = path.lastIndexOf(Platform.pathSeparator);
    var newPath = path.substring(0, lastSeparator + 1) + newFileName;
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    // print("****************");
    // print(widget.foldernames);
    // print("****************");

    String? oldKey = sharedPreferences.getString("foldername-${widget.foldernames}-${widget.pin}");

    await sharedPreferences.setString('foldername-$newFileName-${widget.pin}', oldKey.toString());
    log(newFileName);
    setState(() {
      log(imageName.toString());
      finalImage = imageName.toString();
      loadImage();
      log(imageName.toString());
      finalImage = imageName.toString();
    });
    return myfile.rename(newPath);
  }
}
