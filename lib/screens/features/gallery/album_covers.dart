import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:safe_encrypt/constants/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'gallery_home.dart';

class AlbumCovers extends StatefulWidget {
  const AlbumCovers({Key? key, required this.updatefolderlist, required this.foldersname, required this.path, required this.pin}) : super(key: key);
  final String foldersname;
  final String path;
  final String pin;
  final Function updatefolderlist;
  @override
  State<AlbumCovers> createState() => _AlbumCoversState();
}

class _AlbumCoversState extends State<AlbumCovers> {
  bool customcover = false;
  bool selectedfolder = false;
  String assetPath = 'assets/ic.JPG';
  int selected = 0;
  String imgname = '';
  List<String> imgList = [
    'assets/Capture1.JPG',
    'assets/Capture2.JPG',
    'assets/Capture3.JPG',
    'assets/Capture4.JPG',
    'assets/Capture5.JPG',
    'assets/Capture6.JPG',
    'assets/Capture7.JPG',
    'assets/Capture8.JPG',
    'assets/Capture9.JPG',
  ];

  String selectedfolderString = '';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        setState(() {
          widget.updatefolderlist;
        });
        Navigator.pop(context);
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Main Album'),
          backgroundColor: kdarkblue,
        ),
        //  backgroundColor: kdarkblue),
        body: SingleChildScrollView(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Select item from this album for the cover photo', style: TextStyle(fontSize: 17)),
            ),
            const SizedBox(height: 20),
            SizedBox(
                height: 55,
                width: MediaQuery.of(context).size.width,
                child: SwitchListTile(
                    activeTrackColor: klightBlueAccent,
                    activeColor: kblue,
                    title: const Text('Set custom cover', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
                    value: customcover,
                    onChanged: (bool value) {
                      setState(() {
                        customcover = !customcover;
                      });
                    })),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text('Default covers',
                  style: TextStyle(
                    fontSize: 20,
                  )),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 500,
              child: GridView.builder(
                  itemCount: imgList.length,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 4.0,
                    mainAxisSpacing: 4.0,
                  ),
                  itemBuilder: (BuildContext context, index) {
                    return InkWell(
                      onTap: customcover
                          ? () async {
                              AwesomeDialog(
                                context: context,
                                animType: AnimType.LEFTSLIDE,
                                headerAnimationLoop: false,
                                dialogType: DialogType.info,
                                showCloseIcon: true,
                                title: ' To change cover press ok',
                                desc: '',
                                btnOkOnPress: () async {
                                  debugPrint('Continue');
                                  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
                                  await sharedPreferences.setString('foldername-${widget.foldersname}-${widget.pin}', selectedfolderString);
                                  await Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) => GalleryHome(
                                                pinNumber: widget.pin,
                                              )),
                                      (Route<dynamic> route) => false);
                                },
                                btnOkIcon: Icons.check_circle,
                                onDismissCallback: (type) {
                                  debugPrint('Dialog Dismiss from callback $type');
                                },
                              ).show();

                              setState(() {
                                selectedfolderString = imgList[index];
                                selectedfolder = true;
                                print(selectedfolderString);
                                // saveimg(selectedfolderString);
                              });
                            }
                          : () {
                              setState(() {
                                selectedfolder = false;
                              });
                            },
                      child: Opacity(
                          opacity: customcover ? 1.0 : 0.6,
                          child: Stack(
                            children: [
                              SizedBox(
                                width: selectedfolderString == imgList[index] ? MediaQuery.of(context).size.width : 0,
                                height: selectedfolderString == imgList[index] ? MediaQuery.of(context).size.height : 0,
                              ),
                              Positioned(
                                left: selectedfolderString == imgList[index] ? 24 : 0,
                                top: selectedfolderString == imgList[index]

                                    //
                                    ? 22
                                    : 0,
                                child: SizedBox(
                                  width: selectedfolderString == imgList[index] ? 120 : MediaQuery.of(context).size.width / 3 - 8,
                                  height: selectedfolderString == imgList[index] ? 120 : 150,
                                  child: Image.asset(
                                    imgList[index],
                                    fit: BoxFit.fill,
                                  ),
                                ),
                              ),
                              Positioned(
                                  left: customcover ? 10 : 0,
                                  top: customcover ? 3 : 0,
                                  child: Icon(
                                    selectedfolderString == imgList[index] ? Icons.check_circle_rounded : null,
                                    color: klightBlueAccent,
                                    size: 30,
                                  )),
                            ],
                          )),
                    );
                  }),
            ),
          ]),
        ),
      ),
    );
  }
}
