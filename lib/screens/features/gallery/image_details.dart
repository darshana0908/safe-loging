import 'dart:io';

import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../settings/settings.dart';

class ImageDetails extends StatefulWidget {
  final String path;
  const ImageDetails({Key? key, required this.path}) : super(key: key);

  @override
  State<ImageDetails> createState() => _ImageDetailsState();
}

class _ImageDetailsState extends State<ImageDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height / 3,
            color: kliteblue,
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back_rounded, color: Colors.white),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      IconButton(icon: const Icon(Icons.delete, color: Colors.white54), onPressed: () {}),
                      IconButton(icon: const Icon(Icons.cloud, color: Colors.white), onPressed: () {}),
                      PopupMenuButton(
                        icon: Icon(
                          Icons.more_vert,
                          color: kwhite,
                        ),
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
                                      child: Text(
                                        'Settings',
                                        style: TextStyle(color: kblack, fontSize: 17),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(builder: (context) => const Settings()),
                                        );
                                      },
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: TextButton(
                                      autofocus: true,
                                      child: Text(
                                        'Help',
                                        style: TextStyle(color: kblack, fontSize: 17),
                                      ),
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
                ],
              )
            ]),
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height / 4,
          ),
          loadPhotos(),
        ],
      ),
    ));
  }

  loadPhotos() {
    Directory _directory = Directory(widget.path);

    if (!Directory(_directory.path).existsSync()) {
      return Container(
        padding: const EdgeInsets.only(bottom: 60.0),
        child: const Center(
          child: Text(
            "All images should appear here",
            style: TextStyle(fontSize: 18.0),
          ),
        ),
      );
    } else {
      var imageList = _directory.listSync().map((item) => item.path).where((item) => item.endsWith(".jpg")).toList(growable: false);

      if (imageList.isNotEmpty) {
        return Container(
          padding: const EdgeInsets.only(bottom: 60.0),
        );
      } else {
        return Center(
          child: Container(
            padding: const EdgeInsets.only(bottom: 60.0),
            child: const Text(
              "Sorry, No Images Where Found.",
              style: TextStyle(fontSize: 18.0),
            ),
          ),
        );
      }
    }
  }
}
