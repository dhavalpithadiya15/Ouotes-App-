import 'package:flutter/material.dart';
import 'package:quotesapp/modelclass.dart';
import 'package:quotesapp/thirdpage.dart';

class SecondPage extends StatefulWidget {
  List<String> titles;
  List<Color> title_color;
  int i; // i is frist class index and index is second class

  SecondPage(this.titles, this.title_color, this.i);

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  List<String> temp = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    forindex();
  }

  forindex() {
    if (widget.i == 0) {
      temp = ModelClass().life_quotes;
    } else if (widget.i == 1) {
      temp = ModelClass().famous_quotes;
    } else if (widget.i == 2) {
      temp = ModelClass().sad_quotes;
    } else if (widget.i == 3) {
      temp = ModelClass().happiness_quotes;
    } else if (widget.i == 4) {
      temp = ModelClass().love_quotes;
    } else if (widget.i == 5) {
      temp = ModelClass().motivational_quotes;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("${widget.titles[widget.i]}"),
      ),
      body: GridView.builder(
        itemCount: 6,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return ThirdPage(temp, index, widget.title_color, widget.i);
                  },
                ),
              );
            },
            child: Container(
              padding: EdgeInsets.all(5),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                child: Center(
                    child: Text(
                  "${temp[index]}",
                  textAlign: TextAlign.center,
                )),
                color: widget.title_color[widget.i],
              ),
            ),
          );
        },
      ),
    );
  }
}
