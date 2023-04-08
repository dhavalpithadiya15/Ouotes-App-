import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:quotesapp/fourthpage.dart';

class ThirdPage extends StatefulWidget {
  List<String> temp;
  int index; // second class index
  List<Color> title_color;
  int i;

  ThirdPage(this.temp, this.index, this.title_color, this.i);

  @override
  State<ThirdPage> createState() => _ThirdPageState();
}

class _ThirdPageState extends State<ThirdPage> {
  PageController pg = PageController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      pg = PageController(initialPage: widget.index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 9,
              child: Container(
                padding: EdgeInsets.all(10),
                child: PageView.builder(
                  onPageChanged: (value) {
                    setState(() {
                      widget.index = value;
                    });
                    print(value);
                  },
                  controller: pg,
                  itemCount: 6,
                  scrollDirection: Axis.horizontal,
                  physics: NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Container(
                      alignment: Alignment.center,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        margin: EdgeInsets.only(left: 15, right: 15, top: 15),
                        color: widget.title_color[widget.i],
                        child: Center(
                          child: Text(
                            "${widget.temp[widget.index]}",
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                        // color: Colors.blue,
                      ),
                    );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                // margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  // color: Colors.green,
                  borderRadius: BorderRadius.circular(25),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (widget.index > 0) {
                            widget.index--;
                          } else {
                            Fluttertoast.showToast(
                                msg: "That's all",
                                toastLength: Toast.LENGTH_SHORT,
                                gravity: ToastGravity.TOP,
                                timeInSecForIosWeb: 1,
                                backgroundColor: Colors.grey,
                                textColor: Colors.black,
                                fontSize: 15.0);
                          }
                        });
                      },
                      icon: Icon(
                        Icons.keyboard_double_arrow_left,
                        size: 35,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              String hh = "${widget.temp[widget.index]}";
                              return FourthPage(hh);
                            },
                          ),
                        );
                      },
                      icon: Icon(
                        Icons.edit,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.share,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.copy,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        setState(() {
                          if (widget.index < widget.temp.length - 1) {
                            widget.index++;
                          }
                        });
                      },
                      icon: Icon(
                        Icons.keyboard_double_arrow_right,
                        size: 35,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
