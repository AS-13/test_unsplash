import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:test_unsplash/photo_screen.dart';

class HomePage extends StatefulWidget {
  HomePage(this.title);
  String title;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List list = [];

  @override
  void initState() {
    super.initState();
    getData();
  }

  getData() async {
    String _url =
        "https://api.unsplash.com/photos/?client_id=cf49c08b444ff4cb9e4d126b7e9f7513ba1ee58de7906e4360afc1a33d1bf4c0";
    var result = await http.get(_url);
    setState(() {
      list = jsonDecode(result.body);
    });
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            return InkWell(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(builder: (context)=>PhotoPage(list[index]['urls']['full'])));
                },
                child: Container(
                  height: height * .3,
                  width: width * .4,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: NetworkImage(list[index]['urls']['small']),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  margin: EdgeInsets.all(5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text("Name: ${list[index]['alt_description'] == null ? "no Name"
                          : list[index]['alt_description']}",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        maxLines: 1,
                      ),
                      Text("User Name: ${list[index]['user']['username'] == null
                          ? "no User Name"
                          : list[index]['user']['username']}",
                        style: TextStyle(fontSize: 20, color: Colors.white),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ));
          },
        ));
  }
}
