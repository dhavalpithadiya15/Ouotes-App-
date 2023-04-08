import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:share_plus/share_plus.dart';

class FourthPage extends StatefulWidget {
  String hh;

  FourthPage(this.hh);

  @override
  State<FourthPage> createState() => _FourthPageState();
}

class _FourthPageState extends State<FourthPage> {
  String folderPath = "";
  double defalutFontSize = 18;
  Color currentColor = Colors.white;
  Color currentTextColor = Colors.black;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    createFolder();
  }

  createFolder() async {
    final folderName = "myquotees";
    final path = Directory("storage/emulated/0/$folderName");
    if ((await path.exists())) {
      // TODO:
      print("exist");
    } else {
      // TODO:
      print("not exist");
      path.create();
    }
    setState(() {
      folderPath = path.path;
      print(folderPath);
    });
  }

  GlobalKey globalKey = GlobalKey();

  Future<Uint8List> capturePng() async {
    try {
      print('inside');
      RenderRepaintBoundary? boundary = globalKey.currentContext!
          .findRenderObject() as RenderRepaintBoundary?;
      ui.Image image = await boundary!.toImage(pixelRatio: 3.0);
      ByteData? byteData =
          await image.toByteData(format: ui.ImageByteFormat.png);
      var pngBytes = byteData!.buffer.asUint8List();
      var bs64 = base64Encode(pngBytes);
      print(pngBytes);
      print(bs64);
      setState(() {});
      return pngBytes;
    } catch (e) {
      print(e);
      return Future.value();
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 9,
              child: RepaintBoundary(
                key: globalKey,
                child: Container(
                  margin: EdgeInsets.all(10),
                  child: Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25)),
                    color: currentColor,
                    child: Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        textAlign: TextAlign.center,
                        "${widget.hh}",
                        style: TextStyle(
                            fontSize: defalutFontSize, color: currentTextColor),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Color Picker"),
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  pickerColor: currentColor,
                                  onColorChanged: (Color color) {
                                    setState(() {
                                      currentColor = color;
                                    });
                                  },
                                ),
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Done"),
                                )
                              ],
                            );
                          },
                        );
                      },
                      child: Text("BG color"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        capturePng().then((value) async {
                          print(value);
                          String imageName = "Image${Random().nextInt(1000)}.jpg";
                          String imagePath = "$folderPath/$imageName";
                          File ff = File(imagePath);
                          ff.writeAsBytes(value);
                          await Share.shareFiles(['${ff.path}'],
                              text: 'https://pub.dev/packages/share_plus');
                        });
                      },
                      child: Text("Share"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return StatefulBuilder(
                              builder: (context, setState1) {
                                return Container(
                                  height: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadiusDirectional.only(
                                        topStart: Radius.circular(20),
                                        topEnd: Radius.circular(20)),
                                  ),
                                  child: Slider(
                                    max: 40,
                                    min: 10,
                                    value: defalutFontSize,
                                    onChanged: (value) {
                                      setState(() {
                                        setState1(() {
                                          defalutFontSize = value;
                                        });
                                      });
                                    },
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                      child: Text("Font size"),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text("Color Picker"),
                              content: SingleChildScrollView(
                                child: ColorPicker(
                                  pickerColor: currentTextColor,
                                  onColorChanged: (Color color) {
                                    setState(() {
                                      currentTextColor = color;
                                    });
                                  },
                                ),
                              ),
                              actions: [
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("Done"),
                                )
                              ],
                            );
                          },
                        );
                      },
                      child: Text("Text Color"),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
