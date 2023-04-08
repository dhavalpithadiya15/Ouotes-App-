import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quotesapp/modelclass.dart';
import 'package:quotesapp/secondpage.dart';

void main() {
  runApp(MaterialApp(home: HomePage(),));
}



class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    forPermission();
  }

  Future<void> forPermission() async {
    var status = await Permission.storage.status;
    if (status.isDenied) {
      // We didn't ask for permission yet or the permission has been denied before but not permanently.
      await [
        Permission.storage,
      ].request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Quotes"),
      ),
      body: GridView.builder(
        itemCount: ModelClass().titles.length,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 1),
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(context, MaterialPageRoute(
                builder: (context) {
                  return SecondPage(
                      ModelClass().titles, ModelClass().title_color, index);
                },
              ));
            },
            child: Container(
              padding: EdgeInsets.all(25),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                color: ModelClass().title_color[index],
                child: Center(
                  child: Text(
                    "${ModelClass().titles[index]}",
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
