import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:share_plus/share_plus.dart';

import '../../../constants/colors.dart';

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
          backgroundColor: kblack,
        ),
        backgroundColor: kblack,
        body: Column(
          children: [
            Center(
              child: Image.file(
                //load system image
                File(widget.path), //system image path

                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          color: kblack,
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceAround, children: [
            IconButton(
              onPressed: () async {
                final temp = await getTemporaryDirectory();

                await Share.shareFiles([widget.path],
                    text: 'check out my Apps https://Safeloging.com');
              },
              icon: Icon(
                Icons.share,
                color: kwhite,
              ),
              iconSize: 30,
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.rotate_90_degrees_ccw_outlined,
                color: kwhite,
              ),
              iconSize: 30,
            ),
            InkWell(
              onTap: () async {
                setState(() {
                  delete(widget.path);
                });
              },
              child: Icon(
                Icons.delete_forever,
                color: kwhite,
                size: 30,
              ),
            ),
          ]),
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
