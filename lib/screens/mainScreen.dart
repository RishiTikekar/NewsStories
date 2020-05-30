import 'dart:convert';
//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:http/http.dart' as http;
import 'package:google_fonts/google_fonts.dart';
import 'package:triveous/detailedNewsScreen.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool isLoading = true;
  Map<dynamic, dynamic> dataRetrieved = {};
  Future getDataa() async {
    setState(() {
      isLoading = true;
    });
    var url = 'http://newsapi.org/v2/top-headlines?' +
        'country=us&' +
        'apiKey=18e89538f0424d22803efd653e21140e';
    var data = await http.get(url);
    dataRetrieved = json.decode(data.body);
    // print(dataRetrieved);
    // print("ddd%%%%%%");
    print(dataRetrieved["articles"][0]);
    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    getDataa();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Container(
              height: height,
              width: width,
              padding: EdgeInsets.all(8.0),
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailedNewsScreen(dataRetrieved["articles"]
                                        [index]["url"])));
              },
                                          child: Container(
                        alignment: Alignment.topCenter,
                        height: height * 0.4,
                        width: width - 16,
                        decoration: BoxDecoration(
                            boxShadow: <BoxShadow>[
                              BoxShadow(color: Colors.black, blurRadius: 6)
                            ],
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white),
                        child: Column(
                          children: <Widget>[
                            Container(
                              height: height * 0.25,
                              width: width - 16,
                              padding: EdgeInsets.all(10),
                              alignment: Alignment.bottomLeft,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.black38,
                                image: DecorationImage(
                                    image: NetworkImage(dataRetrieved["articles"]
                                        [index]["urlToImage"]),
                                    fit: BoxFit.cover),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: <Widget>[
                                  Text(
                                    dataRetrieved["articles"][index]["source"]
                                        ["name"],
                                    maxLines: 1,
                                    overflow: TextOverflow.fade,
                                    style: GoogleFonts.merriweather(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    dataRetrieved["articles"][index]["title"],
                                    maxLines: 1,
                                    style: GoogleFonts.crimsonText(
                                        color: Colors.white),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                dataRetrieved["articles"][index]["content"] +
                                    "  more.....",
                                maxLines: 4,
                                style:
                                    GoogleFonts.crimsonPro(color: Colors.black87),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (context, index) {
                    return Divider();
                  },
                  itemCount: dataRetrieved["articles"].length > 5
                      ? 5
                      : dataRetrieved["articles"].length),
            ),
    );
  }
}
