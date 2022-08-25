import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

import '../../../constants/colors.dart';

import 'package:share_plus/share_plus.dart';

class ImageDetails extends StatefulWidget {
  final String path;
  const ImageDetails({Key? key, required this.path}) : super(key: key);

  @override
  State<ImageDetails> createState() => _ImageDetailsState();
}

class _ImageDetailsState extends State<ImageDetails> {
  @override
  void initState() {
    // TODO: implement

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: kdarkblue,
          title: const Text('Image Deatils'),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  child: Image.file(
                    //load system image
                    File(widget.path), //system image path
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3 * 1.5,
                    fit: BoxFit.fill,
                  ),
                ),
                BottomAppBar(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () async {
                            final temp = await getTemporaryDirectory();

                            await Share.shareFiles([widget.path],
                                text:
                                    'check out my Apps https://Safeloging.com');
                          },
                          icon: Icon(
                            Icons.share,
                            color: kblue,
                          ),
                          iconSize: 50,
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(
                            Icons.rotate_90_degrees_ccw_outlined,
                            color: kblue,
                          ),
                          iconSize: 50,
                        ),
                        InkWell(
                          onTap: () async {
                            setState(() {
                              delete(widget.path);
                            });
                          },
                          child: Icon(
                            Icons.delete_forever,
                            color: kblue,
                            size: 50,
                          ),
                        ),
                      ]),
                )
              ],
            ),
          ),
        ));
  }

  void delete(String path) async {
    final decryptedDir = Directory(path);
    final encryptedDir = Directory('$path.aes');

    setState(() async {
      encryptedDir.deleteSync(recursive: true);
      decryptedDir.deleteSync(recursive: true);
    });
  }
}
