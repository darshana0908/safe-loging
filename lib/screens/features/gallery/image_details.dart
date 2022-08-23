import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';

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
    delete(widget.path);
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
                    height: MediaQuery.of(context).size.height / 3 * 2,
                    fit: BoxFit.fill,
                  ),
                ),
                BottomAppBar(
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return Expanded(
                                  child: AlertDialog(
                                    content: SizedBox(
                                      height: 250,
                                      child: Column(
                                        children: [
                                          IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                                Icons.whatsapp_sharp),
                                            iconSize: 100,
                                            color: Colors.green,
                                          ),
                                          IconButton(
                                            onPressed: () async {
                                              final Email email = Email(
                                                body: 'Email body',
                                                subject: 'Email subject',
                                                recipients: [
                                                  'example@example.com'
                                                ],
                                                cc: ['cc@example.com'],
                                                bcc: ['bcc@example.com'],
                                                attachmentPaths: [
                                                  '/path/to/attachment'
                                                ],
                                                isHTML: false,
                                              );

                                              await FlutterEmailSender.send(
                                                  email);
                                            },
                                            icon: const Icon(
                                                Icons.email_outlined),
                                            iconSize: 100,
                                            color: Colors.red,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          icon: Icon(
                            Icons.share,
                            color: kblue,
                          ),
                          iconSize: 50,
                        ),
                        Icon(
                          Icons.rotate_90_degrees_ccw_outlined,
                          color: kblue,
                          size: 50,
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
    initState();
  }
}
